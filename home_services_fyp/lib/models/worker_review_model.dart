class WorkerReviewModel {
  String? proposerId;
  String? proposerName;
  String? proposalId;
  String? workerID;
  String? workerName;
  String? userReview;


  WorkerReviewModel({
    this.proposerId,
    this.proposerName,
    this.proposalId,
    this.workerID,
    this.workerName,
    this.userReview
  });

  Map<String, dynamic> toJson() {
    return {
      'proposerId': proposerId,
      'proposerName': proposerName,
      'proposalId': proposalId,
      'isAccept': false,
      'workerID': workerID,
      'workerName': workerName,
      'userReview': userReview
    };
  }

  factory WorkerReviewModel.fromJson(Map<String, dynamic> json, String proposalId ) {
    return WorkerReviewModel(
      proposerId: json['proposerId'],
      proposerName: json['proposerName'],
      proposalId: json['proposalId'],
      workerID: json['workerID'],
      workerName: json['workerName'],
      userReview: json['userReview'],
    );
  }
}
