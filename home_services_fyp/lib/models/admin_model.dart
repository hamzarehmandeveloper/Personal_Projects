class AdminModel {
  String? adminId;
  String? imagePath;
  String? name;
  String? email;
  String? phoneNo;
  String? userToken;
  AdminModel({
    this.adminId,
    this.imagePath,
    this.name,
    this.email,
    this.phoneNo,
    this.userToken
  });
  Map<String, dynamic> toJson(){
    return{
      'userId': adminId,
      'imagePath': imagePath,
      'name': name,
      'email': email,
      'phoneNo': phoneNo,
      'userToken': userToken,
    };
  }
  factory AdminModel.fromJson(Map<String, dynamic> json, String id) {
    return AdminModel(
      adminId: id,
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      imagePath: json["imagePath"] ?? "",
      phoneNo: json["phoneNo"] ?? "",
      userToken: json["userToken"] ?? "",
    );
  }
}

