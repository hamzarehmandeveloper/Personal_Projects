import 'package:flutter/material.dart';
import 'chat_screen.dart';

class ConversationsScreen extends StatelessWidget {
  ConversationsScreen({super.key});
  final List<Conversation> conversations = [
    Conversation(
      user: 'Hamza',
      worker: 'Plumber',
      lastMessage: 'Hey, when can you come to fix the sink?',
      lastMessageTime: '10:30 AM',
    ),
    Conversation(
      user: 'Usman Mushtaq',
      worker: 'Electrician',
      lastMessage: 'Do you have any availability tomorrow?',
      lastMessageTime: 'Yesterday',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Inbox',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conversation = conversations[index];
          return ConversationItem(
            user: conversation.user,
            worker: conversation.worker,
            lastMessage: conversation.lastMessage,
            lastMessageTime: conversation.lastMessageTime,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MessagingScreen(workerName: conversation.user, workerImage: 'assets/images/demo.png',)));
            },
          );
        },
      ),
    );
  }
}

class ConversationItem extends StatelessWidget {
  final String user;
  final String worker;
  final String lastMessage;
  final String lastMessageTime;
  final VoidCallback onTap;

  ConversationItem({
    required this.user,
    required this.worker,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        child: Image.asset('assets/images/demo.png'),
        backgroundColor: Colors.white,
        radius: 25,
      ),
      title: Text(
        user,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '$worker - $lastMessage',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        lastMessageTime,
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}


class Conversation {
  final String user;
  final String worker;
  final String lastMessage;
  final String lastMessageTime;

  Conversation({
    required this.user,
    required this.worker,
    required this.lastMessage,
    required this.lastMessageTime,
  });
}