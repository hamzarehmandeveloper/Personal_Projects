class WorkerProposalModel {
  String? workDescription;
  String? proposalTitle;
  String? selectedCategory;
  List<String>? imageUrls;
  String? proposerId;
  String? proposerName;
  String? proposerDeviceToken;
  String? proposalId;
  String? workRequestPostId;
  String? workerID;
  String? workerName;
  String? workerDeviceToken;
  String? material;
  String? rate;
  bool? isAccept;
  String? location;
  dynamic timestamp;
  dynamic workReachTime;
  dynamic workStartTime;
  dynamic workEndTime;

  WorkerProposalModel({
    this.workDescription,
    this.selectedCategory,
    this.proposalTitle,
    this.imageUrls,
    this.proposerId,
    this.proposerName,
    this.proposalId,
    this.timestamp,
    this.material,
    this.rate,
    this.isAccept,
    this.workerID,
    this.location,
    this.workerName,
    this.workRequestPostId,
    this.workReachTime,
    this.workStartTime,
    this.workEndTime,
    this.proposerDeviceToken,
    this.workerDeviceToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'workDescription': workDescription,
      'selectedCategory': selectedCategory,
      'imageUrls': imageUrls,
      'proposerId': proposerId,
      'proposerName': proposerName,
      'proposalId': proposalId,
      'timestamp': timestamp,
      'material': material,
      'rate': rate,
      'isAccept': false,
      'workerID': workerID,
      'workerName': workerName,
      'location': location,
      'proposalTitle': proposalTitle,
      'workRequestPostId': workRequestPostId,
      'workReachTime': workReachTime,
      'workStartTime': workStartTime,
      'workEndTime': workEndTime,
      'proposerDeviceToken': proposerDeviceToken,
      'workerDeviceToken': workerDeviceToken,
    };
  }

  factory WorkerProposalModel.fromJson(Map<String, dynamic> json, String proposalId ) {
    return WorkerProposalModel(
      workDescription: json['workDescription'],
      selectedCategory: json['selectedCategory'],
      imageUrls: json['imageUrls'] != null ? List<String>.from(json['imageUrls']) : [],
      proposerId: json['proposerId'],
      proposerName: json['proposerName'],
      proposalId: json['proposalId'],
      timestamp: json['timestamp'] != null ? json['timestamp'] : null,
      material: json['material'],
      rate: json['rate'],
      isAccept: json['isAccept'],
      workerID: json['workerID'],
      workerName: json['workerName'],
      location: json['location'],
      proposalTitle: json['proposalTitle'],
      workRequestPostId: json['workRequestPostId'],
      workStartTime: json['workStartTime'],
      workReachTime: json['workReachTime'],
      workEndTime: json['workEndTime'],
      proposerDeviceToken: json['proposerDeviceToken'],
      workerDeviceToken: json['workerDeviceToken']
    );
  }
}
