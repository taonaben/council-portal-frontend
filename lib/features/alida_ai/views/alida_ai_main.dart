import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/string_methods.dart';
import 'package:portal/features/alida_ai/model/alida_model.dart';
import 'package:portal/features/alida_ai/providers/alida_providers.dart';
import 'package:portal/features/alida_ai/services/alida_services.dart';

class AlidaAiMain extends ConsumerStatefulWidget {
  const AlidaAiMain({super.key});

  @override
  ConsumerState<AlidaAiMain> createState() => _AlidaAiMainState();
}

class _AlidaAiMainState extends ConsumerState<AlidaAiMain> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isSending = false;

  // Track thumbs up/down state per message index
  final Map<int, bool> _thumbsUp = {};
  final Map<int, bool> _thumbsDown = {};

  @override
  void initState() {
    super.initState();

    ref.refresh(alidaChatHistoryProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  List<Map<String, dynamic>> _getMessages = [];

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() => _isSending = true);

    try {
      // Add the new message to the list
      _getMessages.add({
        'sender': 'user',
        'content': text,
        'created_at': DateTime.now().toIso8601String(),
      });
      AlidaResponseModel? response =
          await AlidaServices().sendMessageToAlida(text);

      if (response == null) {
        setState(() => _isSending = false);
        return;
      }

      _getMessages.add({
        'sender': 'ai',
        'content': response.response,
        'created_at': response.created_at,
      });
    } catch (e) {
      // Handle any errors that occur during sending
      setState(() => _isSending = false);
      return;
    }

    _controller.clear();

    setState(() => _isSending = false);

    // Refresh chat history
    ref.invalidate(alidaChatHistoryProvider);

    // Scroll to bottom after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatHistoryAsync = ref.watch(alidaChatHistoryProvider);
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh chat history when the user pulls down to refresh
        ref.invalidate(alidaChatHistoryProvider);
      },
      child: Column(
        children: [
          Expanded(
            child: chatHistoryAsync.when(

              data: (messages) {
                messages = [
                  ...messages,
                  ..._getMessages.map((msg) => AlidaModel(
                        sender: msg['sender'] as String,
                        content: msg['content'] as String,
                        created_at: msg['created_at'] as String,
                      )),
                ];
                return discussionPanel(messages);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
          createChatTextBox(),
        ],
      ),
    );
  }

  Widget discussionPanel(List<AlidaModel> messages) {
    // Messages are sorted descending, so reverse for chat order
    final chatMessages = messages.reversed.toList();
    return ListView.builder(
      controller: _scrollController,
      itemCount: chatMessages.length,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      itemBuilder: (context, index) {
        final message = chatMessages[index];
        final isMe = message.sender.toLowerCase() == 'user';
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: isMe
              ? userChatBubble(message.content)
              : alidaChatBubble(message.content, index),
        );
      },
    );
  }

  Widget userChatBubble(String message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: secondaryColor.withOpacity(.6),
          borderRadius: BorderRadius.circular(uniBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SelectableText(
          message,
        ),
      ),
    );
  }

  Widget alidaChatBubble(String message, int index) {
    final thumbsUp = _thumbsUp[index] ?? false;
    final thumbsDown = _thumbsDown[index] ?? false;
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SelectableText(
            message,
          ),
          const Gap(16),
          Row(
            children: [
              IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(CupertinoIcons.square_on_square, size: 16),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: message)).then((_) {
                    const CustomSnackbar(
                      message: "Message copied",
                      color: primaryColor,
                    ).showSnackBar(context);
                  });
                },
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.speaker_2, size: 16),
                onPressed: () {
                  // Add your onPressed logic here
                },
              ),
              IconButton(
                icon: Icon(
                    thumbsUp
                        ? CupertinoIcons.hand_thumbsup_fill
                        : CupertinoIcons.hand_thumbsup,
                    size: 16),
                onPressed: () {
                  setState(() {
                    _thumbsUp[index] = !thumbsUp;
                    if (_thumbsUp[index] == true) {
                      _thumbsDown[index] = false;
                    }
                  });

                  const CustomSnackbar(
                          message: "Thank you for your feedback",
                          color: primaryColor)
                      .showSnackBar(context);
                },
              ),
              IconButton(
                icon: Icon(
                    thumbsDown
                        ? CupertinoIcons.hand_thumbsdown_fill
                        : CupertinoIcons.hand_thumbsdown,
                    size: 16),
                onPressed: () {
                  setState(() {
                    _thumbsDown[index] = !thumbsDown;
                    if (_thumbsDown[index] == true) {
                      _thumbsUp[index] = false;
                    }
                  });
                  const CustomSnackbar(
                          message: "Thank you for your feedback",
                          color: primaryColor)
                      .showSnackBar(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget createChatTextBox() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0, left: 8, right: 8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: background2,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextFormField(
                controller: _controller,
                maxLines: 10,
                minLines: 1,
                enabled: !_isSending,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Ask anything',
                  hintStyle: TextStyle(color: textColor1),
                ),
                style: const TextStyle(color: textColor1),
                // onFieldSubmitted: (_) => _sendMessage(),
              ),
            ),
            IconButton(
              onPressed: _isSending ? null : _sendMessage,
              icon: _isSending
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(
                      CupertinoIcons.paperplane,
                      color: primaryColor,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
