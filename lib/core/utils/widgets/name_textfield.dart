import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NameTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final bool isRequired;
  final String? Function(String?)? validator;
  final String labelText;
  final bool allowNumbers;

  const NameTextField({
    super.key,
    this.controller,
    this.hintText = 'Name',
    this.onChanged,
    this.isRequired = true,
    this.validator,
    required this.labelText,
    this.allowNumbers = false,
  });

  @override
  State<NameTextField> createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<NameTextField> {
  bool _isValid = true;
  String? _errorText;
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
      _validateName(_controller.text);
    }
  }

  bool _validateName(String value) {
    // Check if empty but required
    if (value.isEmpty && widget.isRequired) {
      setState(() {
        _isValid = false;
        _errorText = '${widget.labelText} is required';
      });
      return false;
    }

    // If not empty, validate the name format
    if (value.isNotEmpty) {
      // Name validation - alphanumeric check if numbers allowed
      RegExp nameRegex = widget.allowNumbers
          ? RegExp(
              r'^[a-zA-Z0-9\s\-\.]+$') // Allow letters, numbers, spaces, hyphens, periods
          : RegExp(
              r'^[a-zA-Z\s\-\.]+$'); // Allow only letters, spaces, hyphens, periods

      if (!nameRegex.hasMatch(value)) {
        setState(() {
          _isValid = false;
          _errorText = widget.allowNumbers
              ? 'Please enter a valid ${widget.labelText.toLowerCase()}'
              : 'Please enter a valid ${widget.labelText.toLowerCase()} (no numbers or special characters)';
        });
        return false;
      }

      // Minimum length check (optional)
      if (value.trim().length < 2) {
        setState(() {
          _isValid = false;
          _errorText = '${widget.labelText} must be at least 2 characters';
        });
        return false;
      }
    }

    // Valid name
    setState(() {
      _isValid = true;
      _errorText = null;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        keyboardType: TextInputType.name,
        textCapitalization:
            TextCapitalization.words, // Auto-capitalize each word
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
          errorText: !_isValid ? _errorText : null,
        ),
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        // Filter input to match validation rules
        inputFormatters: [
          if (!widget.allowNumbers)
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s\-\.]')),
        ],
        validator: widget.validator ??
            (value) {
              if (widget.isRequired && (value == null || value.isEmpty)) {
                return '${widget.labelText} is required';
              }

              if (value != null && value.isNotEmpty) {
                // Name validation
                RegExp nameRegex = widget.allowNumbers
                    ? RegExp(r'^[a-zA-Z0-9\s\-\.]+$')
                    : RegExp(r'^[a-zA-Z\s\-\.]+$');

                if (!nameRegex.hasMatch(value)) {
                  return widget.allowNumbers
                      ? 'Please enter a valid ${widget.labelText.toLowerCase()}'
                      : 'Please enter a valid ${widget.labelText.toLowerCase()} (no numbers or special characters)';
                }

                // Minimum length check
                if (value.trim().length < 2) {
                  return '${widget.labelText} must be at least 2 characters';
                }
              }
              return null;
            },
      ),
    );
  }
}
