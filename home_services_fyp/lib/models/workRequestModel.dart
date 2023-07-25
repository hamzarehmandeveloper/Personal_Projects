class WorkRequestModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime date;
  final List<String> images;
  final String orderStatus;

  WorkRequestModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.images,
    required this.orderStatus,
  });
}


List<WorkRequestModel> requestModel = [
  WorkRequestModel(
    id: "1",
    title: "Painting Service",
    description: "Looking for someoneVehari to paint my living room.",
    location: "Vehari",
    date: DateTime(2023, 7, 25),
    images: [
      "assets/icons/plumber.png",
      "assets/icons/painter.png",
    ],
      orderStatus : 'confirm'
  ),
  WorkRequestModel(
    id: "2",
    title: "Plumbing Repair",
    description: "Need assistance with fixing a leaky faucet.",
    location: "Vehari",
    date: DateTime(2023, 7, 28),
    images: [
      "assets/icons/cleaning.png",
      "assets/icons/painter.png",
    ],
      orderStatus : 'not confirm'
  ),
  WorkRequestModel(
    id: "3",
    title: "Gardening Help",
    description: "Looking for someone to mow the lawn and trim hedges.",
    location: "Vehari",
    date: DateTime(2023, 7, 30),
    images: [
      "assets/icons/plumber.png",
      "assets/icons/painter.png",
    ],
      orderStatus: 'confirm'
  ),
];