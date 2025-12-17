import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import '../services/auth/auth_service.dart';

class HomePage extends StatelessWidget{
   HomePage ({super.key});

//chat & auth service
final ChatService _chatService = ChatService();
final AuthService _authService = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
      
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );

  }

  Widget _buildUserList(){
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return const Text("error");
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading...");
        }
        return ListView(
          children: snapshot.data!.map<Widget>((userData)=> _buildUserListItem(userData, context)).toList(),
          );
  },
  );

  }

  //build individual user list tile
  Widget _buildUserListItem(Map<String,dynamic> userData, BuildContext context){
  //get current user
  final currentUser = _authService.getCurrentUser();
  
  //display all users except current user
  if (userData["email"] != currentUser?.email){
    return UserTile(
    text: userData["email"],
    onTap: (){
      //navigate to chat page with selected user
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => ChatPage(
            receiverEmail: userData["email"],
            receiverID: userData["uid"],
        ), 
      ),
  
   );
  },
  );
  }else {
    return Container();
  }
  }
}