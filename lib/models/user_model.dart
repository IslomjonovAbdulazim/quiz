class UserModel {
  late String id;
  late String firstname;
  late String lastname;
  String? avatar;

  UserModel({
    required this.id,
    required this.avatar,
    required this.firstname,
    required this.lastname,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'avatar': avatar,
        'firstname': firstname,
        'lastname': lastname,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
