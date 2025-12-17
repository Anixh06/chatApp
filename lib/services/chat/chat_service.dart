import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {

  //get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;



  //get user stream
  Stream<List<Map<String, dynamic>>> getUserStream(){
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
      
    });
  }


  //send message
  Future<void> sendMessage(String receiverID, message) async
{
  //get current user info
  final String currentuserID = _auth.currentUser!.uid;
  final String currentUserEmail = _auth.currentUser!.email!;
  final Timestamp timestamp = Timestamp.now();


  //create new message
  Message newMessage = Message(
    senderID: currentuserID,
    senderEmail: currentUserEmail,
    receiverID: receiverID,
    content: message,
    timestamp: timestamp,
  );


  //construct chat room ID for the two users (sorted to ensure uniqueness)
  List<String> ids = [currentuserID, receiverID];
  ids.sort();
  String chatRoomID = ids.join('_');

  //add new message to database
  await _firestore
      .collection("chat_rooms")
      .doc(chatRoomID)
      .collection("messages")
      .add(newMessage.toMap());

}

  //get messages stream
  Stream<QuerySnapshot> getMessages(String userID, otherUserID){
    //construct chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');


    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

}