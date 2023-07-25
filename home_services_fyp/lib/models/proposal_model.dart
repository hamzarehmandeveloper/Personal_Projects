class ProposalModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime date;
  final String orderStatus;
  final int rate;
  final String material;
  final String estimatedTime;

  ProposalModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.orderStatus,
    required this.rate,
    required this.material,
    required this.estimatedTime,
  });
}

List<ProposalModel> proposals = [
  ProposalModel(
    id: "1",
    title: "Painting Service",
    description: "Looking for someone to paint my living room.",
    location: "Vehari",
    date: DateTime(2023, 7, 25),
    orderStatus: 'confirm',
    rate: 100,
    material: 'pipes,fitting, etc',
    estimatedTime: '2 day',
  ),
  ProposalModel(
    id: "2",
    title: "Plumbing Repair",
    description: "Need assistance with fixing a leaky faucet.",
    location: "Vehari",
    date: DateTime(2023, 7, 28),
    orderStatus: 'not confirm',
    rate: 200,
    material: 'pipes,fitting, etc',
    estimatedTime: '1 day',
  ),
  ProposalModel(
    id: "3",
    title: "Gardening Help",
    description: "Looking for someone to mow the lawn and trim hedges.",
    location: "Vehari",
    date: DateTime(2023, 7, 30),
    orderStatus: 'confirm',
    rate: 500,
    material: 'pipes,fitting, etc',
    estimatedTime: '1 day',
  ),
];
