import 'dart:developer';

import 'package:doct_plant/core/utils/widgets/dr_plant_background.dart';
import 'package:doct_plant/features/chat_bot/view/view_model/cubit/chatbot_cubit.dart';
import 'package:doct_plant/features/chat_bot/view/widgets/chat_bot_messages_list.dart';
import 'package:doct_plant/features/chat_bot/view/widgets/chat_bubble.dart';
import 'package:doct_plant/features/chat_bot/view/widgets/chatbot_response.dart';
import 'package:doct_plant/features/chat_bot/view/widgets/send_prompt_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBotViewBody extends StatefulWidget {
  const ChatBotViewBody({super.key});

  @override
  State<ChatBotViewBody> createState() => _ChatBotViewBodyState();
}

class _ChatBotViewBodyState extends State<ChatBotViewBody> {
  final List<Widget> messages = [];
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  bool isLoadingAdded = false;

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DrPlantBackground(
        child: BlocConsumer<ChatbotCubit, ChatbotState>(
          listener: (context, state) {
            if (state is ChatbotFailure) {
              if (isLoadingAdded) {
                messages.removeLast();
                isLoadingAdded = false;
              }
              log(state.errMessage);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errMessage)),
              );
            } else if (state is ChatbotLoading && !isLoadingAdded) {
              messages.add(const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: CircularProgressIndicator(),
                ),
              ));
              isLoadingAdded = true;
              setState(() {});
            } else if (state is ChatbotSuccess) {
              if (isLoadingAdded) {
                messages.removeLast();
                isLoadingAdded = false;
              }
              messages.add(
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.h),
                  child: ChatBubble(
                    message: state.response,
                    isSender: false,
                  ),
                ),
              );
              setState(() {});
              scrollToBottom();
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ChatbotMessagesList(
                    messages: messages,
                    controller: scrollController,
                  ),
                ),
                SendPromptTextfield(
                  controller: controller,
                  onSend: () async {
                    final text = controller.text.trim();
                    if (text.isEmpty) return;

                    setState(() {
                      messages.add(
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0.h),
                          child: ChatBubble(message: text, isSender: true),
                        ),
                      );
                    });
                    scrollToBottom();

                    controller.clear();
                    await context.read<ChatbotCubit>().sendPrompt(text);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
