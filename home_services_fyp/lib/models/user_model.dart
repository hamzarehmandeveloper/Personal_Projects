class User {
  final String imagePath;
  final String name;
  final String email;
  final String about;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
  });
}

class UserPreferences {
  static const myUser = User(
    imagePath: 'assets/images/demo.png',
    name: 'Hamza Rehman',
    email: 'hamzarehman@gmail.com',
    about:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  );
}
