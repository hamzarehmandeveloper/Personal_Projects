class DonnerModel {
  int id;
  String name;
  String mobile;
  String blood;
  String address;
  String lastDate;

  DonnerModel(
      {required this.id,
        required this.name,
      required this.address,
      required this.mobile,
      required this.blood,
      required this.lastDate});

  Map<String, dynamic> toMap(DonnerModel donner) {
    return {
      'id':id,
      'name': name,
      'mobile': mobile,
      'blood': blood,
      'lastDate': lastDate,
      'address': address
    };
  }
}
