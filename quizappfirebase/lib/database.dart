import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizappfirebase/User.dart';

class dbservices{
  late final String? uid;
  dbservices({this.uid});

  final CollectionReference usercl = FirebaseFirestore.instance.collection("users");
  Future updatedata(String name, int age, int phone) async {
    return await usercl.doc(uid).set(
      {
        'Name' : name,
        'Age' : age,
        'phone' : phone,
      }
    );
  }

  List<Userinfo> userlistss(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return Userinfo(
        name: doc.get('Name') ?? '',
        age: doc.get('Age') ?? '',
        phone: doc.get('phone') ?? '',
      );
    }).toList();
  }
  
  Stream<List<Userinfo>> get usersdata {
    return usercl.snapshots().map(userlistss);
  }
}