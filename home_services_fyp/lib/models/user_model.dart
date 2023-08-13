class UserModel {
  String? userId;
  String? imagePath;
  String? name;
  String? email;
  String? city;
  String? about;
  String? phoneNo;
  String? skill;
  bool? isWorker;
  double? rating;
  int? numOfRatings;
  String? userToken;


  UserModel({
    this.userId,
    this.imagePath,
    this.name,
    this.email,
    this.city,
    this.about,
    this.skill,
    this.phoneNo,
    this.isWorker,
    this.rating,
    this.numOfRatings,
    this.userToken
  });
  Map<String, dynamic> toJson(){
    return{
      'userId': userId,
      'imagePath': imagePath,
      'name': name,
      'email': email,
      'city': city,
      'phoneNo': phoneNo,
      'isWorker': false,
      'about': about,
      'skill': skill,
      'rating': rating,
      'numOfRatings': numOfRatings,
      'userToken': userToken,
    };
  }
  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      userId: id,
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      imagePath: json["imagePath"] ?? "",
      city: json["city"] ?? "",
      phoneNo: json["phoneNo"] ?? "",
      isWorker: json["isWorker"],
      about: json["about"] ?? "",
      skill: json["skill"] ?? "",
      rating: json["rating"] != null ? json["rating"].toDouble() : 0.0,
      numOfRatings: json['numOfRatings'] ?? 0,
      userToken: json["userToken"] ?? "",
    );
  }
}

