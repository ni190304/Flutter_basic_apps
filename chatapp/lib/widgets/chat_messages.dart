import 'package:chatapp/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  

  @override
  Widget build(BuildContext context) {
    final authuser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, msgsnapshot) {
        if (msgsnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!msgsnapshot.hasData || msgsnapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No new messages'),
          );
        }

        if (msgsnapshot.hasError) {
          return const Center(
            child: Text("We couldn't reload the messages"),
          );
        }

        final Loadedmsg = msgsnapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 40,
            left: 13,
            right: 13,
          ),
          reverse: true,
          itemCount: Loadedmsg.length,
          itemBuilder: (context, index) {
            final chatMessages = Loadedmsg[index].data();
            final nextChatMessage = index + 1 < Loadedmsg.length
                ? Loadedmsg[index + 1].data()
                : null;

            final currentMessageId = chatMessages['user-id'];
            final nextMessageId =
                nextChatMessage != null ? nextChatMessage['user-id'] : null;

            final nextUserIsSame = nextMessageId == currentMessageId;

            if (nextUserIsSame) {
              return MessageBubble.next(
                  message: chatMessages['text'],
                  isMe: authuser.uid == currentMessageId);
            } else {
              return MessageBubble.first(
                  userImage: chatMessages['userimage'],
                  username: chatMessages['username'],
                  message: chatMessages['text'],
                  isMe: authuser.uid == currentMessageId);
            }
          },
        );
      },
    );
  }
}
