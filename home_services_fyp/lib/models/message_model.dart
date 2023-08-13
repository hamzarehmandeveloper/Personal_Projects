class Message {
  String? senderID;
  String? msg;
  String? read;
  String? receiverID;
  String? sent;
  dynamic? date;
  Message({
    required this.senderID,
    required this.msg,
    required this.read,
    required this.receiverID,
    required this.sent,
    required this.date
  });
  Message.fromJson(Map<String, dynamic> json,) {
    senderID = json['senderID'].toString();
    msg = json['msg'].toString();
    read = json['read'].toString();
    receiverID = json['receiverID'].toString();
    sent = json['sent'].toString();
    date = json['date'];
  }
  Map<String, dynamic> toJson() {
    return {
      'senderID': senderID,
      'msg': msg,
      'read': read,
      'receiverID': receiverID,
      'sent': sent,
      'date': date,
    };
  }
}
