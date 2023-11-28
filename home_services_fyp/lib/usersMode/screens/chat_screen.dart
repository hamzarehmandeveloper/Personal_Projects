import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/usersMode/screens/worker_profile_screen.dart';
import 'package:intl/intl.dart';
import "dart:convert";
import '../../Constants.dart';
import '../../FireStore_repo/APIsCall.dart';
import '../../models/message_model.dart';

class MessagingScreen extends StatefulWidget {
  final String? receiverID;
  final String? receiverName;
  final String? receiverImagePath;
  final String? receiverToken;

  MessagingScreen(
      {required this.receiverID,
      required this.receiverName,
      required this.receiverImagePath,
      required this.receiverToken});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final List<Message> messages = [];

  ScrollController scrollController = ScrollController();
  final TextEditingController messageTextController = TextEditingController();
  DateTime? lastDisplayedDate;

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
    APIsCall.sendNotification(
        messageText, widget.receiverToken, Constants.userModel!.name);
    _scrollToBottom();
    messageTextController.clear();
  }

  Stream<List<Message>> getMessagesStream() {
    _scrollToBottom();
    List<String?> ids = [Constants.userModel!.userId, widget.receiverID];
    ids.sort();
    String chatIDs = ids.join('_');

    return FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatIDs)
        .collection('Messages')
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
        titleSpacing: 0,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkerProfileScreen(
                  userId: widget.receiverID.toString(),
                  showContactButton: false,
                ),
              ),
            );
          },
          child: Row(
            children: [
              ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: widget.receiverImagePath!,
                      fit: BoxFit.cover,
                      width: 45,
                      height: 45,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/demo.png',
                        fit: BoxFit.cover,
                        width: 45,
                        height: 45,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                widget.receiverName!,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
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
                receivedMessages.sort((a, b) {
                  Timestamp aValue = a.date;
                  Timestamp bValue = b.date;
                  return aValue.compareTo(bValue);
                });
                return receivedMessages.isNotEmpty
                    ? ListView.builder(
                        controller: scrollController,
                        itemCount: receivedMessages.length,
                        padding: const EdgeInsets.all(8.0),
                        itemBuilder: (context, index) {
                          final message = receivedMessages[index];
                          Timestamp date = message.date;
                          final isUserMessage =
                              message.senderID == Constants.userModel!.userId;
                          bool isNewDate = lastDisplayedDate == null ||
                              lastDisplayedDate?.day != date.toDate().day;
                          lastDisplayedDate = date.toDate();
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
                                if (isNewDate)
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(
                                        DateFormat('MMM dd, yyyy')
                                            .format(date.toDate())
                                            .toString(),
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
                                    /*if (!isUserMessage)
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 15,
                                        child: Image.asset(
                                            'assets/images/demo.png'),
                                      ),*/
                                    Flexible(
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(12.0),
                                          margin: const EdgeInsets.only(
                                              left: 8.0, right: 8.0, top: 8.0),
                                          decoration: BoxDecoration(
                                            color: isUserMessage
                                                ? Colors.green
                                                : Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          child: Text(
                                            message.msg.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
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
                                const SizedBox(height: 3),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    DateFormat.jm()
                                        .format(date.toDate())
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text('Start Conversation'),
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
                        borderSide:
                            const BorderSide(color: Colors.black, width: 5),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
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
