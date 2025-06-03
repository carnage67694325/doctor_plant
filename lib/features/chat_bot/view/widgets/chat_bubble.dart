import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:doct_plant/core/utils/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final bool? isSender;

  const ChatBubble({
    super.key,
    required this.message,
    this.isSender,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller with a short duration
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    // Create a scale animation that starts small and pops to normal size
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack, // Use easeOutBack for a nice "pop" effect
    );

    // Start the animation when the widget is built
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: BubbleSpecialOne(
        text: widget.message,
        textStyle: TextStyle(color: Colors.white, fontSize: 16.sp),
        color: AppColors.tileColor,
        isSender: widget.isSender ?? true,
      ),
    );
  }
}
