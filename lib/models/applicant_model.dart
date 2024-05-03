import 'package:equatable/equatable.dart';

class ApplicantModel extends Equatable {
  late String userId;
  late int corrects;
  late int totalAttempts;
  late String name;
  late String title;
  late DateTime time;
  late String lastname;
  String? avatar;

  ApplicantModel({
    required this.corrects,
    required this.totalAttempts,
    required this.userId,
    required this.avatar,
    required this.lastname,
    required this.name,
    required this.title,
    required this.time,
  });

  ApplicantModel.fromJson(Map<String, dynamic> json) {
    corrects = json['corrects'];
    totalAttempts = json['totalAttempts'];
    userId = json['userId'];
    avatar = json['avatar'];
    lastname = json['lastname'];
    name = json['name'];
    title = json['title'];
    time = DateTime.parse(json['time']);
  }

  Map<String, dynamic> toJson() => {
        'corrects': corrects,
        'totalAttempts': totalAttempts,
        'userId': userId,
        'avatar': avatar,
        'lastname': lastname,
        'name': name,
        'title': title,
        'time': time.toIso8601String(),
      };

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object?> get props => [userId];
}
