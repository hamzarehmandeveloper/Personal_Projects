import 'package:flutter/material.dart';

class ConversationsProvider extends ChangeNotifier {
  Stream<List<String>>? _uniqueParticipantIDsStream;

  Stream<List<String>> get uniqueParticipantIDsStream => _uniqueParticipantIDsStream!;

  void setUniqueParticipantIDsStream(Stream<List<String>> stream) {
    _uniqueParticipantIDsStream = stream;
    notifyListeners();
  }
}
