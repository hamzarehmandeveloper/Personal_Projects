import 'dart:convert';

import 'package:http/http.dart' as http;

class APIsCall{

  static void sendNotification(String? msgBody,String? receiverToken, String? title) async {
    var data = {
      'to' : receiverToken,
      'notification' : {
        'title' : title ,
        'body' : msgBody ,
        "sound": "jetsons_doorbell.mp3"
      },
      'android': {
        'notification': {
          'notification_count': 23,
        },

      },
      'data' : {
        'type' : 'msj' ,
        'id' : 'msgID'
      }
    };
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data) ,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : 'key=AAAAG-rYFPg:APA91bHT_E3NZKk-ZHF2ju9VQwHAFfWCrNh9kBfa24j7jz0UBW2wZSJvHlncVvedxAImD3u0PfcljtjsxV9v4wAi0CmQC8uobv9GLj7fSPZuClA7Xbs6HXTowXqwyDoBs6-b--Dgykj7'
        }
    ).then((value){
      print(value.body.toString());
    }).onError((error, stackTrace){
      print(error);
    });
    print(receiverToken);
  }

}