import 'package:home_services_fyp/Constants.dart';

class WorkRequestProposal {
  String? workDescription;
  String? selectedCategory;
  List<String>? imageUrls;
  String? proposerId;
  String? proposerName;
  String? proposerDeviceToken;
  String? requestTitle;
  String? proposalRequestId;
  String? location;
  List<String>? proposalSubmittedByWorkerIds = [];
  dynamic timestamp;
  bool? isAccept;

  WorkRequestProposal({
    this.workDescription,
    this.selectedCategory,
    this.imageUrls,
    this.proposerId,
    this.proposerName,
    this.proposalRequestId,
    this.timestamp,
    this.requestTitle,
    this.location,
    this.isAccept,
    this.proposerDeviceToken,
    this.proposalSubmittedByWorkerIds
  });

  Map<String, dynamic> toJson() {
    return {
      'workDescription': workDescription,
      'selectedCategory': selectedCategory,
      'imageUrls': imageUrls,
      'proposerId': proposerId,
      'proposerName': proposerName,
      'proposalId': proposalRequestId,
      'timestamp': timestamp,
      'requestTitle': requestTitle,
      'location': location,
      'isAccept': false,
      'proposerDeviceToken': proposerDeviceToken,
      'proposalSubmittedByWorkerIds': proposalSubmittedByWorkerIds,
    };
  }

  factory WorkRequestProposal.fromJson(Map<String, dynamic> json, String proposalReqId ) {
    return WorkRequestProposal(
      workDescription: json['workDescription'],
      selectedCategory: json['selectedCategory'],
      imageUrls: json['imageUrls'] != null ? List<String>.from(json['imageUrls']) : [],
      proposerId: json['proposerId'],
      proposerName: json['proposerName'],
      proposalRequestId: json['proposalId'],
      timestamp: json['timestamp'] != null ? json['timestamp'] : null,
      requestTitle: json['requestTitle'],
      location: json['location'],
      isAccept: json['isAccept'],
      proposerDeviceToken: json['proposerDeviceToken'],
      proposalSubmittedByWorkerIds:
      json['proposalSubmittedByWorkerIds'] != null
          ? List<String>.from(json['proposalSubmittedByWorkerIds'])
          : [],
    );
  }
}
