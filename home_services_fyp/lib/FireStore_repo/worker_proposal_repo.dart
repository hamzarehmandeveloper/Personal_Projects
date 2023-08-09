import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_services_fyp/models/worker_proposals_model.dart';

class WorkerProposalRepo{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> storeWorkRequestProposal(WorkerProposalModel proposal) async {
    try {
      CollectionReference collection = FirebaseFirestore.instance.collection('WorkerProposals');
      DocumentReference docRef = await collection.add(proposal.toJson());
      proposal.proposalId = docRef.id;
      await docRef.set(proposal.toJson());
      print('Proposal send successfully');
    } catch (e) {
      print('Error storing work request proposal: $e');
      throw e;
    }
  }


  Future<WorkerProposalModel?> fetchProposalData(String?  id) async {
    try {
      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('WorkerProposals')
          .doc(id)
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
        documentSnapshot.data() as Map<String, dynamic>;
        return WorkerProposalModel.fromJson(data, documentSnapshot.id);
      } else {
        print('Proposal not found.');
        return null;
      }
    } catch (e) {
      print('Error fetching proposal data: $e');
      return null;
    }
  }

}