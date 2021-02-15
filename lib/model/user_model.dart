//User Model
class UserModel {
  String uid;
  String email;
  String name;

  UserModel({this.uid, this.email, this.name});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() =>
      {"uid": uid, "email": email, "name": name};
}
