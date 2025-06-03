import 'package:doct_plant/core/utils/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendPromptTextfield extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const SendPromptTextfield({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(140),
            blurRadius: 30,
            spreadRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'your message here .......',
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 9),
          GestureDetector(
            onTap: onSend,
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: const BoxDecoration(
                color: AppColors.signUpButtoColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
