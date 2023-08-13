import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:home_services_fyp/models/user_model.dart';
import 'package:home_services_fyp/models/workRequestModel.dart';

class UserRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String currentUser= auth.currentUser!.uid;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  WorkRequestProposal? workRequest;


  Future<String?> getToken() async {
    String? token;
    try{
      await _firebaseMessaging.getToken().then((value) {
        token = value;
        print('token: $token');
        return token;
      });
    }catch (e){
      print('error fetching token $e');
    }
    return token;
  }

  Future<void> saveTokenToDatabase(String? token) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .update({
      'userToken': token
    });
  }

  Future<void> setupToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    await saveTokenToDatabase(token!);
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }



  Future<UserModel?> fetchWorkerProfileData(String userId) async {
    UserModel? user;
    try {
      final Map<String, dynamic>? userData = await getUserData(userId);
      if (userData != null) {
        user = UserModel.fromJson(userData, userId);
        print('User name: ${user.name}');
        print('User email: ${user.email}');
        print(user.userId);
        return user;
      } else {
        print('User data not found.');
      }
    } catch (e) {
      print('Error fetching user data here: $e');

    }
    return user;
  }

  Future<UserModel?> fetchUserData() async {
    UserModel? user;
    try {
      final Map<String, dynamic>? userData = await getUserData(currentUser);
      if (userData != null) {
        user = UserModel.fromJson(userData, currentUser);
        print('User name: ${user.name}');
        print('User email: ${user.email}');
        print(user.userId);
        return user;
      } else {
        print('User data not found.');
      }
    } catch (e) {
      print('Error fetching user data here: $e');

    }
    return user;
  }

  Future resetEmail(String newEmail) async {
    var message;
    User? firebaseUser = await auth.currentUser;
    firebaseUser
        ?.updateEmail(newEmail)
        .then(
          (value) => message = 'Success',
    )
        .catchError((onError) => message = 'error');
    return message;
  }

  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Registration Error: $e');
      return null;
    }
  }

  Future<void> createUser(UserModel user) async {
    try {
      await firestore.collection('Users').doc(user.userId).set(user.toJson());
    } catch (e) {
      print('Error creating user: $e');
      throw Exception('Failed to create user.');
    }
  }

  Future<void> updateUserData(String userId, Map<String, dynamic> data) async {
    try {
      await firestore.collection('Users').doc(userId).update(data);
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Login Error: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
      await firestore.collection('Users').doc(userId).get();
      if (userSnapshot.exists) {
        return userSnapshot.data();
      }
      return null;
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  Future<UserModel?> fetchWorkerModel(String?  workerID) async {
    UserModel? worker;
    try {
      final Map<String, dynamic>? workerData = await getUserData(workerID!);
      if (workerData != null) {
        worker = UserModel.fromJson(workerData, currentUser);
        print('Worker name: ${worker.name}');
        print('Worker email: ${worker.email}');
        print(worker.userId);
        return worker;
      } else {
        print('Worker data not found.');
      }
    } catch (e) {
      print('Error fetching user data here: $e');

    }
    return worker;
  }

  Future<void> updateRatingForWorker(String? workerID, double newRating) async {
    UserModel? workerModel = await fetchWorkerModel(workerID!);
    try {
      if (workerModel != null) {
        int numberOfRatings = workerModel.numOfRatings ?? 0;
        numberOfRatings++;

        double currentRating = workerModel.rating ?? 0.0;
        double newAverageRating =
            (currentRating * (numberOfRatings - 1) + newRating) /
                numberOfRatings;
        workerModel.rating = newAverageRating;
        workerModel.numOfRatings = numberOfRatings;
        String? inString = workerModel.rating?.toStringAsFixed(1);
        double ratingDouble = double.parse(inString!);
        print(ratingDouble);
        await firestore.collection('Users').doc(workerID).update({
          "rating": ratingDouble,
          "numOfRatings" : workerModel.numOfRatings,
        });
        print('Rating Updated');
      }
    } catch (e) {
      print('Error fetching Worker data here: $e');
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}


