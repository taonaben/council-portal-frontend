import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portal/constants/colors/colors.dart';

class AlidaAiMain extends StatefulWidget {
  const AlidaAiMain({super.key});

  @override
  State<AlidaAiMain> createState() => _AlidaAiMainState();
}

class _AlidaAiMainState extends State<AlidaAiMain> {
  final List<Map<String, String>> messages = [
    {"sender": "me", "text": "Hi Alida Ai!"},
    {"sender": "ai", "text": "Hello, how can I help you today?"},
    {"sender": "me", "text": "I need some information about the city council."},
    {"sender": "ai", "text": "Sure, what do you need to know?"},
    {"sender": "me", "text": "Can you tell me about the upcoming events?"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: discussionPanel()), createChatTextBox()],
    );
  }

  Widget discussionPanel() {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isMe = message["sender"] == "me";
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isMe ? primaryColor : background2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                message["text"]!,
                style: TextStyle(color: isMe ? Colors.white : textColor1),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget createChatTextBox() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            color: background2,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              TextFormField(
                maxLines: 10,
                minLines: 1,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Ask anything',
                  hintStyle: TextStyle(color: textColor1),
                ),
                style: const TextStyle(color: textColor1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  contextChip(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.paperplane,
                        color: primaryColor,
                      ))
                ],
              )
            ],
          )),
    );
  }

  Widget contextChip() {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text("Context", style: TextStyle(color: textColor1)),
            Gap(8),
            Icon(
              CupertinoIcons.add,
              color: textColor1,
            )
          ],
        ),
      ),
    );
  }
}
