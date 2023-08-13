import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Constants.dart';
import '../../models/user_model.dart';
import 'chat_screen.dart';

class ConversationsScreen extends StatefulWidget {
  ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  Stream<List<String>> getUniqueParticipantIDs() {
    try {
      return FirebaseFirestore.instance
          .collection('ChatRoom')
          .where('members', arrayContains: Constants.userModel!.userId)
          .snapshots()
          .asyncMap((querySnapshot) async {
        List<String> uniqueIDs = [];

        for (var chatRoomDoc in querySnapshot.docs) {
          List<String> members = List<String>.from(chatRoomDoc['members']);
          members.remove(Constants.userModel!.userId);
          String otherUserID = members.first;

          QuerySnapshot messagesSnapshot = await chatRoomDoc.reference
              .collection('Messages')
              .orderBy('date', descending: true)
              .limit(1)
              .get();

          if (messagesSnapshot.docs.isNotEmpty) {
            uniqueIDs.add(otherUserID);
          }
        }

        print("Unique participant IDs: $uniqueIDs");
        print("Number of unique participant IDs: ${uniqueIDs.length}");

        return uniqueIDs;
      });
    } catch (e) {
      print('Error fetching unique participant IDs: $e');
      throw e;
    }
  }

  Stream<List<UserModel>> getUsersWithUniqueToIdsStream(
      List<String> uniqueToIds) {
    return FirebaseFirestore.instance
        .collection('Users')
        .where('userId', whereIn: uniqueToIds)
        .snapshots()
        .map((querySnapshot) {
      List<UserModel> users = querySnapshot.docs.map((doc) {
        Map<String, dynamic> userData = doc.data();
        return UserModel.fromJson(userData, doc.id);
      }).toList();

      return users;
    }).handleError((error) {
      print('Error fetching user data with unique toIds: $error');
      throw error;
    });
  }

  deleteChatAndMessages(String chatID) {
    try {
      FirebaseFirestore.instance
          .collection('ChatRoom')
          .doc(chatID)
          .collection('Messages')
          .get()
          .then((value) {
        for (var messageDoc in value.docs) {
          messageDoc.reference.delete();
        }
      }).whenComplete(() => FirebaseFirestore.instance
              .collection('ChatRoom')
              .doc(chatID)
              .delete());
      print('Chat deleted');
    } catch (e) {
      print('Error deleting chat and messages: $e');
    }
  }

  void showDeleteConfirmationDialog(BuildContext context, String chatID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text('Delete Chat'),
          content: const Text('Are you sure you want to delete this chat?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteChatAndMessages(chatID);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

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
      body: StreamBuilder<List<String>>(
        stream: getUniqueParticipantIDs(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final conversations = snapshot.data!;
          if (conversations == null || conversations.isEmpty) {
            return const Center(child: Text('No Conversations yet'));
          }
          return StreamBuilder(
              stream: getUsersWithUniqueToIdsStream(conversations),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                List<UserModel> user = snapshot.data!;
                return ListView.builder(
                  itemCount: user.length,
                  itemBuilder: (context, index) {
                    UserModel conversationData = user[index];
                    print('list lenght ${(conversations.length)}');
                    print("index $index");
                    List<String?> chatIDs = [
                      Constants.userModel!.userId,
                      conversationData.userId.toString()
                    ];
                    chatIDs.sort();
                    String chatID = chatIDs.join('_');
                    print('chat IDs: $chatID');

                    return ConversationItem(
                      user: conversationData.name,
                      skill: conversationData.skill,
                      onDelete: () async {
                        showDeleteConfirmationDialog(context, chatID);
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessagingScreen(
                              receiverID: conversationData.userId,
                              name: conversationData.name,
                              receiverToken: conversationData.userToken,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              });
        },
      ),
    );
  }
}

class ConversationItem extends StatelessWidget {
  final String? user;
  final String? skill;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  ConversationItem({
    required this.user,
    required this.onTap,
    this.onDelete,
    required this.skill
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade200,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            child: Image.asset('assets/images/demo.png'),
            backgroundColor: Colors.white,
            radius: 25,
          ),
          title: Text(
            user!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(skill.toString()),
          trailing: IconButton(
            icon: const Icon(Icons.delete,color: Colors.red,),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}
