import 'package:flutter/cupertino.dart';

class ChatbotMessagesList extends StatelessWidget {
  const ChatbotMessagesList({
    super.key,
    required this.messages,
    required this.controller,
  });

  final List<Widget> messages;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      controller: controller,
      physics: const BouncingScrollPhysics(),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return messages[index];
      },
    );
  }
}
