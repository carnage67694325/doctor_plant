import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final bool isRequired;
  final String? Function(String?)? validator;
  final String labelText;
  const EmailTextField({
    super.key,
    this.controller,
    this.hintText = 'Email',
    this.onChanged,
    this.isRequired = true,
    this.validator,
    required this.labelText,
  });

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  bool _isValid = true;
  final FocusNode _focusNode = FocusNode();
  late final TextEditingController _controller;

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
      _validateEmail(_controller.text);
    }
  }

  bool _validateEmail(String value) {
    if (value.isEmpty && widget.isRequired) {
      setState(() => _isValid = false);
      return false;
    }

    if (value.isNotEmpty) {
      final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
      bool isValid = emailRegExp.hasMatch(value);
      setState(() => _isValid = isValid);
      return isValid;
    }

    setState(() => _isValid = true);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.person,
            color: Color(0xff99A1AF),
            size: 40,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 25.h,
          ),
          hintText: widget.hintText,
          labelText: widget.labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          errorText: !_isValid
              ? widget.isRequired && _controller.text.isEmpty
                  ? 'Email is required'
                  : 'Please enter a valid email'
              : null,
        ),
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        validator: widget.validator ??
            (value) {
              if (widget.isRequired && (value == null || value.isEmpty)) {
                return 'Email is required';
              }
              if (value != null && value.isNotEmpty) {
                final emailRegExp =
                    RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
                if (!emailRegExp.hasMatch(value)) {
                  return 'Please enter a valid email';
                }
              }
              return null;
            },
      ),
    );
  }
}
