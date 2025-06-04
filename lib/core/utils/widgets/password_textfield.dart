import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final bool isRequired;
  final String? Function(String?)? validator;
  final bool showStrengthIndicator;

  const PasswordTextField({
    super.key,
    this.controller,
    this.hintText = 'Password',
    this.labelText = 'Password',
    this.onChanged,
    this.isRequired = true,
    this.validator,
    this.showStrengthIndicator = false,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;
  late final TextEditingController _controller;
  bool _isValid = true;
  String? _errorText;
  double _passwordStrength = 0.0;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _validatePassword(_controller.text);
    }
  }

  bool _validatePassword(String value) {
    if (value.isEmpty && widget.isRequired) {
      setState(() {
        _isValid = false;
        _errorText = 'Password is required';
      });
      return false;
    }

    // Basic password validation - can be enhanced
    if (value.isNotEmpty && value.length < 8) {
      setState(() {
        _isValid = false;
        _errorText = 'Password must be at least 8 characters';
      });
      return false;
    }

    setState(() {
      _isValid = true;
      _errorText = null;
      if (widget.showStrengthIndicator) {
        _calculatePasswordStrength(value);
      }
    });
    return true;
  }

  void _calculatePasswordStrength(String password) {
    if (password.isEmpty) {
      _passwordStrength = 0.0;
      return;
    }

    double strength = 0.0;

    // Length check
    if (password.length >= 8) strength += 0.2;
    if (password.length >= 12) strength += 0.1;

    // Complexity checks
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.2; // Uppercase
    if (password.contains(RegExp(r'[a-z]'))) strength += 0.2; // Lowercase
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.2; // Numbers
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      strength += 0.2; // Special chars
    }

    setState(() {
      _passwordStrength = strength > 1.0 ? 1.0 : strength;
    });
  }

  Color _getStrengthColor() {
    if (_passwordStrength < 0.3) return Colors.red;
    if (_passwordStrength < 0.7) return Colors.orange;
    return Colors.green;
  }

  String _getStrengthText() {
    if (_passwordStrength < 0.3) return 'Weak';
    if (_passwordStrength < 0.7) return 'Medium';
    return 'Strong';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            obscureText: _obscureText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 25.h,
              ),
              prefixIcon: const Icon(
                Icons.lock,
                color: Color(0xff99A1AF),
                size: 40,
              ),
              hintText: widget.hintText,
              labelText: widget.labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
              ),
              errorText: !_isValid ? _errorText : null,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
            onChanged: (value) {
              if (widget.showStrengthIndicator) {
                _calculatePasswordStrength(value);
              }
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            validator: widget.validator ??
                (value) {
                  if (widget.isRequired && (value == null || value.isEmpty)) {
                    return 'Password is required';
                  }
                  if (value != null && value.isNotEmpty && value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
          ),
        ),
        if (widget.showStrengthIndicator && _controller.text.isNotEmpty) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: _passwordStrength,
                  backgroundColor: Colors.grey[300],
                  color: _getStrengthColor(),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _getStrengthText(),
                style: TextStyle(color: _getStrengthColor()),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
