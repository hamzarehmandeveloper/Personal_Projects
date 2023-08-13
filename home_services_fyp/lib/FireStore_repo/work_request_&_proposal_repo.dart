import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/workRequestModel.dart';

class WorkRequestRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> storeWorkRequestProposal(WorkRequestProposal proposal) async {
    try {
      CollectionReference collection = FirebaseFirestore.instance.collection('WorkRequests');
      DocumentReference docRef = await collection.add(proposal.toJson());
      proposal.proposalRequestId = docRef.id;
      await docRef.set(proposal.toJson());
      print("Proposal submitted successfully");
    } catch (e) {
      print('Error storing work request proposal: $e');
      throw e;
    }
  }

  DateTime timestampToDateTime(Timestamp timestamp) {
    return timestamp.toDate();
  }

  Future<List<WorkRequestProposal>> fetchWorkRequestProposals(String? currentUserID) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firestore.collection('WorkRequests').get();

      List<WorkRequestProposal> proposals = querySnapshot.docs
          .where((doc) => doc['proposerId'] != currentUserID)
          .map((doc) {
        Map<String, dynamic> data = doc.data();
        return WorkRequestProposal.fromJson(data, doc.id);
      }).toList();

      print('data fetched');
      return proposals;
    } catch (e) {
      print('Error fetching work request proposals: $e');
      throw e;
    }
  }
}