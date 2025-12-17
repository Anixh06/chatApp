

import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/components/message_bubble.dart';
import 'package:chat_app/components/chat_input.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
   ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  //text controller
  final TextEditingController _messageController = TextEditingController();

  //chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //send message
  void sendMessage() async {
    //if there is something inside the textfield
    if(_messageController.text.isNotEmpty){
      //send message
      await _chatService.sendMessage(receiverID, _messageController.text);
      //clear textfield
      _messageController.clear();
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with $receiverEmail"),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            //display all messages
            Expanded(
              child: _buildMessageList(),
            ),




            //user input with keyboard handling
            ChatInput(
              controller: _messageController,
              onSend: sendMessage,
              hintText: "Type your message...",
            ),
          ],
        ),
      ),
    );
  }

  //build message list
  Widget _buildMessageList(){
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        //errors
        if(snapshot.hasError){
          return const Text("Error");
        }

        //loading
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading...");
        }

        //return list view
        return ListView(
          children:
          snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          );
      },
    );
  }


  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //get current user ID
    String currentUserID = _authService.getCurrentUser()!.uid;

    //determine if message is from current user
    bool isCurrentUser = data['senderID'] == currentUserID;

    return MessageBubble(
      message: data["content"],
      isCurrentUser: isCurrentUser,
    );
  }




  //build message input
  Widget _buildUserInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16, left: 12, right: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          //textfield should take up most of the space
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: "Type your message...",
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  suffixIcon: _messageController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                        onPressed: sendMessage,
                      )
                    : null,
                ),
                onSubmitted: (value) => sendMessage(),
                textInputAction: TextInputAction.send,
                maxLines: null,
                minLines: 1,
              ),
            ),
          ),
          
          //show send button only when text is not empty and no suffixIcon
          if (_messageController.text.isNotEmpty) ...[
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: sendMessage,
                icon: Icon(
                  Icons.arrow_upward,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  size: 20,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

}