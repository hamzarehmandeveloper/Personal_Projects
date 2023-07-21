class ProposalModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime date;
  final List<String> images;

  ProposalModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.images,
  });
}


List<ProposalModel> proposals = [
  ProposalModel(
    id: "1",
    title: "Painting Service",
    description: "Looking for someoneVehari to paint my living room.",
    location: "Vehari",
    date: DateTime(2023, 7, 25),
    images: [
      "assets/icons/plumber.png",
      "assets/icons/painter.png",
    ],
  ),
  ProposalModel(
    id: "2",
    title: "Plumbing Repair",
    description: "Need assistance with fixing a leaky faucet.",
    location: "Vehari",
    date: DateTime(2023, 7, 28),
    images: [
      "assets/icons/cleaning.png",
      "assets/icons/painter.png",
    ],
  ),
  ProposalModel(
    id: "3",
    title: "Gardening Help",
    description: "Looking for someone to mow the lawn and trim hedges.",
    location: "Vehari",
    date: DateTime(2023, 7, 30),
    images: [
      "assets/icons/plumber.png",
      "assets/icons/painter.png",
    ],
  ),
];