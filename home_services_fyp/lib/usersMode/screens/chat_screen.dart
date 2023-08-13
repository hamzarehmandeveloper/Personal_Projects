import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "dart:convert";
import '../../Constants.dart';
import '../../FireStore_repo/APIsCall.dart';
import '../../models/message_model.dart';

class MessagingScreen extends StatefulWidget {
  final String? receiverID;
  final String? name;
  final String? receiverToken;

  MessagingScreen({required this.receiverID, required this.name,required this.receiverToken});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final List<Message> messages = [];

  ScrollController scrollController = ScrollController();
  final TextEditingController messageTextController = TextEditingController();


  String _getCurrentDate() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
  }

  void sendMessage(String messageText) {
    if (messageText.trim().isEmpty) return;

    final now = DateTime.now();
    final currentDate = _getCurrentDate();
    print(now);

    List<String?> ids = [Constants.userModel!.userId, widget.receiverID];
    ids.sort();
    String chatIDs = ids.join('_');

    Message message = Message(
      senderID: Constants.userModel!.userId,
      msg: messageText,
      read: 'false',
      receiverID: widget.receiverID,
      sent: currentDate,
      date: now,
    );

    Map<String, dynamic> chatRoomData = {
      'members': ids,
    };

    FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatIDs)
        .set(chatRoomData, SetOptions(merge: true))
        .then((_) {
      FirebaseFirestore.instance
          .collection('ChatRoom')
          .doc(chatIDs)
          .collection('Messages')
          .add(message.toJson());
    });
    APIsCall.sendNotification(messageText,widget.receiverToken,Constants.userModel!.name);
    _scrollToBottom();
    messageTextController.clear();
  }


  Stream<List<Message>> getMessagesStream() {

    List<String?> ids = [Constants.userModel!.userId, widget.receiverID];
    ids.sort();
    String chatIDs = ids.join('_');

    return FirebaseFirestore.instance
        .collection('ChatRoom').doc(chatIDs).collection('Messages')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList();
    });
  }


  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              backgroundImage: AssetImage('assets/images/demo.png'),
            ),
            const SizedBox(width: 10),
            Text(
              widget.name!,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: getMessagesStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<Message> receivedMessages = snapshot.data!;
                receivedMessages.sort((a,b){
                  Timestamp aValue = a.date;
                  Timestamp bValue = b.date;
                  return aValue.compareTo(bValue);});
                return receivedMessages.isNotEmpty ? ListView.builder(
                  controller: scrollController,
                  itemCount: receivedMessages.length,
                  padding: const EdgeInsets.all(8.0),
                  itemBuilder: (context, index) {
                    final message = receivedMessages[index];
                    Timestamp date = message.date;
                    final isUserMessage = message.senderID == Constants.userModel!.userId;
                    print('is user : $isUserMessage');
                    return Container(
                      alignment: isUserMessage
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: isUserMessage
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (date != null)
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  date.toDate().toString(),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          message.msg.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        /*Text(
                                          '${message.date.hour}:${message.time.minute.toString().padLeft(2, '0')}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),*/
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              /*if (isUserMessage)
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 15,
                                  child: Text(message.sender[0]),
                                ),*/
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ):const Center(child: Text('Start Converstion'),) ;
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
                        borderSide: const BorderSide(color: Colors.black, width: 5),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    sendMessage(messageTextController.text.trim());
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
