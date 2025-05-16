import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:portal/core/utils/string_methods.dart';
import 'package:portal/features/alida_ai/components/aiChatBubble.dart';
import 'package:portal/features/alida_ai/components/userChatBubble.dart';
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

  String? _pendingUserMessage;

  _scrollToBottom() {
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
  void initState() {
    super.initState();
    // Wait for the first frame and then scroll to bottom after chat loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    });
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _isSending = true;
      _pendingUserMessage = text;
    });

    try {
      AlidaResponseModel? response =
          await AlidaServices().sendMessageToAlida(text);

      if (response == null) {
        setState(() {
          _isSending = false;
          _pendingUserMessage = null;
        });
        return;
      }
    } catch (e) {
      setState(() {
        _isSending = false;
        _pendingUserMessage = null;
      });
      return;
    }

    _controller.clear();

    setState(() {
      _isSending = false;
      _pendingUserMessage = null;
    });

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
                // Use only provider messages to avoid duplicates
                messages.sort((a, b) => DateTime.parse(a.created_at)
                    .compareTo(DateTime.parse(b.created_at)));

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
    final chatMessages = messages.toList();
    // Add temporary bubbles if sending
    if (_isSending && _pendingUserMessage != null) {
      chatMessages.add(
        AlidaModel(
          sender: 'user',
          content: _pendingUserMessage!,
          created_at: DateTime.now().toIso8601String(),
        ),
      );
      chatMessages.add(
        AlidaModel(
          sender: 'ai',
          content: 'Alida is reading your files...',
          created_at: DateTime.now().toIso8601String(),
        ),
      );
    }
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
              ? UserChatBubble(message: message.content)
              : AIChatBubble(
                  message: message.content,
                  index: index,
                  thumbsUp: _thumbsUp,
                  thumbsDown: _thumbsDown,
                ),
        );
      },
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
                  ? const Icon(
                      CupertinoIcons.stop_circle,
                      color: primaryColor,
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
