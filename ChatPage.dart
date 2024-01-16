import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_miner/GlobalFunction.dart';
import 'package:firebase_miner/Settings.dart';
import 'package:flutter/material.dart';

class Chatpage extends StatefulWidget {
  String username;
  String uid;
  String email;
  Chatpage({required this.username, required this.uid, required this.email});
  @override
  State<StatefulWidget> createState() {
    return ChatpageState(username, uid, email);
  }
}

class ChatpageState extends State<Chatpage> {
  TextEditingController message_controller = TextEditingController();
  String username;
  String uid;
  String email;
  ChatpageState(this.username, this.uid, this.email);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back,color: text(),)),
        backgroundColor: background(),
        title: Fun('$username', 20, FontWeight.normal, a: text()),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Setting(),
                ));
              },
              icon: Icon(
                Icons.settings,
                color: seconddark(),
              )),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: getMessages(user!.email, widget.email),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                List<DocumentSnapshot> messages = snapshot.data!.docs;
                return ListView.builder(
                  itemBuilder: (context, index) =>
                      MessageItem(index, messages[index]),
                  itemCount: messages.length,
                );
              }
            },
          )),
          SendMessageTextfiled(),
        ],
      ),
    );
  }

  Widget SendMessageTextfiled() {
    return Row(
      children: [
        Expanded(
            child: fun(
          message_controller,
          "Enter you Message",
        )),
        IconButton(
            onPressed: () {
              sendMessage(auth.currentUser!.uid, widget.uid,
                  message_controller.text, user!.email, widget.email);
              message_controller.clear();
            },
            icon: Icon(
              Icons.arrow_upward,
              size: 30,
              color: background(),
            ))
      ],
    );
  }

  Widget MessageItem(int index, DocumentSnapshot documentSnapshot) {
    return Align(
      alignment: documentSnapshot.get("senderId") == auth.currentUser!.uid
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: (documentSnapshot.get('senderId') == user!.uid)
                  ? seconddark()
                  : background(),
            ),
            child: Column(
              children: [
                Text(
                  "${documentSnapshot.get('message')}",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendMessage(
    String senderId,
    String receiverId,
    String message,
    String senderEmail,
    String receiverEmail,
  ) async {
    if (message.isNotEmpty) {
      String chatRoomId = getChatRoomId(senderEmail, receiverEmail);
      DocumentSnapshot chatDoc =
          await db.collection("CHAT_ROOMS").doc(chatRoomId).get();
      if (!chatDoc.exists) {
        await db
            .collection("CHAT_ROOMS")
            .doc(chatRoomId)
            .collection("MESSAGES")
            .add({
          'senderId': senderId,
          'receiverId': receiverId,
          'message': message,
          'senderEmial': senderEmail,
          'reciverEmail': receiverEmail,
          'timestamp': FieldValue.serverTimestamp(),
        });

        String recipientToken = await getRecipientToken(receiverEmail);
        await sendNotifiction(
            recipientToken, "$username sent you message", message);
      }
    }
  }

  String getChatRoomId(String userEmail, String otherUserEmail) {
    List<String> emails = [userEmail, otherUserEmail];
    emails.sort();
    return '${emails[0]}_${emails[1]}';
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    String chatRoomId = getChatRoomId(userId, otherUserId);
    return db
        .collection("CHAT_ROOMS")
        .doc(chatRoomId)
        .collection('MESSAGES')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<String> getRecipientToken(String recipientEmail) async {
    QuerySnapshot querySnapshot = await db
        .collection('USERS')
        .where('Email', isEqualTo: recipientEmail)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot document = querySnapshot.docs.first;
      Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('fcmToken')) {
        return data['fcmToken'].toString();
      }
    }

    return "";
  }

  Future<void> sendNotifiction(String token, String title, String body) async {
    await FirebaseMessaging.instance.sendMessage(
      data: {
        'title': title,
        'body': body,
      },
    );
  }
}

