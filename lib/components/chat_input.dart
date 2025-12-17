import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatInput extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final String hintText;

  const ChatInput({
    super.key,
    required this.controller,
    required this.onSend,
    this.hintText = "Type your message...",
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;


  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    
    // Auto-focus the text field when widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 16,
        left: 16,
        right: 16,
        top: 12,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Main text input
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: _isFocused 
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                    : Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: _isFocused 
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6),
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    suffixIcon: widget.controller.text.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _SendButton(
                            onPressed: widget.onSend,
                            isActive: widget.controller.text.isNotEmpty,
                          ),
                        )
                      : null,
                  ),
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      widget.onSend();
                    }
                  },
                  textInputAction: TextInputAction.send,
                  maxLines: null,
                  minLines: 1,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
              ),
            ),
            
            // Show send button when text is not empty and no suffixIcon
            if (widget.controller.text.isEmpty) ...[
              const SizedBox(width: 8),
              _SendButton(
                onPressed: widget.onSend,
                isActive: widget.controller.text.isNotEmpty,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isActive;

  const _SendButton({
    required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isActive 
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: isActive ? onPressed : null,
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isActive
            ? Icon(
                Icons.send_rounded,
                key: const ValueKey('send'),
                color: Theme.of(context).colorScheme.inversePrimary,
                size: 20,
              )
            : Icon(
                Icons.mic_rounded,
                key: const ValueKey('mic'),
                color: Theme.of(context).colorScheme.tertiary,
                size: 20,
              ),
        ),
        constraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
