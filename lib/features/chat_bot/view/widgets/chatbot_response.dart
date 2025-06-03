import 'package:flutter/widgets.dart';

class ChatBotResponse extends StatefulWidget {
  const ChatBotResponse({
    super.key,
    required this.response,
    required this.scrollController,
  });

  final String response;
  final ScrollController scrollController;

  @override
  State<ChatBotResponse> createState() => _ChatBotResponseState();
}

class _ChatBotResponseState extends State<ChatBotResponse> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        opacity = 1.0; // Trigger fade animation
      });
      if (widget.scrollController.hasClients) {
        widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      opacity: opacity,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              child: Text(
                widget.response..replaceAll(RegExp(r'[*]+'), '').trim(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  wordSpacing: 1.0,
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
