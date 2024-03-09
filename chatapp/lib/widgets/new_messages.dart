import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  var messagecontroller = TextEditingController();

  @override
  void dispose() {
    messagecontroller.dispose();
    super.dispose();
  }

  void submitMsg() async {
    final mesg_text = messagecontroller.text;

    if (mesg_text.isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();
    messagecontroller.clear();

    final user = FirebaseAuth.instance.currentUser!;

    final userdata = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    FirebaseFirestore.instance.collection('chat').add({
      'text': mesg_text,
      'createdAt': Timestamp.now(),
      'user-id': user.uid,
      'username': userdata.data()!['user_name'],
      'userimage': userdata.data()!['imageUrl'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            controller: messagecontroller,
            decoration: const InputDecoration(labelText: 'Send messages ...'),
            enableSuggestions: true,
          )),
          IconButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: submitMsg,
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
