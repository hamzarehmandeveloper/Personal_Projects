import 'package:flutter/material.dart';

class MessagingScreen extends StatefulWidget {
  final String workerName;
  final String workerImage;

  MessagingScreen({required this.workerName, required this.workerImage});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final List<Message> messages = [
    Message(
      message: 'Hello there!',
      sender: 'User',
      time: DateTime.now().subtract(Duration(minutes: 5)),
      date: 'July 20, 2023',
    ),
    Message(
      message: 'Hi! How can I help you?',
      sender: 'Worker',
      time: DateTime.now().subtract(Duration(minutes: 3)),
      date: 'July 20, 2023',
    ),
  ];

  ScrollController scrollController = ScrollController();
  final TextEditingController messageTextController = TextEditingController();

  void sendMessage(String message) {
    final newMessage = Message(
      sender: 'User',
      message: message,
      time: DateTime.now(),
      date: _getCurrentDate(),
    );
    setState(() {
      messages.add(newMessage);
      messageTextController.clear();
    });
    _scrollToBottom();
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent+ 100,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              backgroundImage: AssetImage(widget.workerImage),
            ),
            SizedBox(width: 10),
            Text(
              widget.workerName,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: messages.length,
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUserMessage = message.sender == 'User';
                return Container(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: isUserMessage
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      if (message.date != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            message.date,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: isUserMessage
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (!isUserMessage)
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 15,
                              child: Image.asset('assets/images/demo.png'),
                            ),
                          Flexible(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                margin: const EdgeInsets.only(
                                    bottom: 8.0, left: 8.0, right: 8.0),
                                decoration: BoxDecoration(
                                  color: isUserMessage
                                      ? Colors.green
                                      : Colors.blue,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      message.message,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '${message.time.hour}:${message.time.minute.toString().padLeft(2, '0')}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (isUserMessage)
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 15,
                              child: Text(message.sender[0]),
                            ),
                        ],
                      ),

                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageTextController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.black, width: 5),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    String message = messageTextController.text.trim();
                    if (message.isNotEmpty) {
                      sendMessage(message);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.all(15),
                  ),
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),

          /*Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 0, bottom: 0, right: 5),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Say Hi',
                          hintStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      String message = messageTextController.text.trim();
                      if (message.isNotEmpty) {
                        sendMessage(message);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}

class Message {
  final String message;
  final String sender;
  final DateTime time;
  final String date;

  Message({
    required this.message,
    required this.sender,
    required this.time,
    required this.date,
  });
}
