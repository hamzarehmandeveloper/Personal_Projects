class WorkerModel {
  final String id;
  final String imagePath;
  final String name;
  final String about;
  final String email;
  final String identityCardNo;
  final String city;
  final String phoneNumber;
  final String skill;

  const WorkerModel({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.about,
    required this.email,
    required this.phoneNumber,
    required this.skill,
    required this.identityCardNo,
    required this.city,
  });
}

class WorkerPreferences {
  static const myWorker = WorkerModel(
    id: '1',
    imagePath: 'assets/images/demo.png',
    name: 'Hamza Rehman',
    about: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    email: 'hamza@gmail.com',
    phoneNumber: '1234567844',
    skill: 'Plumber',
    identityCardNo: '1234567891234',
    city: 'Haroonabad',
  );
}
