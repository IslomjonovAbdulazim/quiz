import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:the_quiz/models/applicant_model.dart';
import 'package:the_quiz/models/live_model.dart';
import 'package:the_quiz/models/question_model.dart';
import 'package:the_quiz/models/test_model.dart';
import 'package:the_quiz/models/user_model.dart';

class DBService {
  ///user
  Future<UserModel?> getUser() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      late String uuid;
      if (Platform.isAndroid) {
        uuid = (await deviceInfoPlugin.androidInfo).id;
      } else if (Platform.isIOS) {
        uuid = (await deviceInfoPlugin.iosInfo).identifierForVendor!;
      }
      final res = await firestore.collection("users").doc(uuid).get();
      return UserModel.fromJson(res.data()!);
    } catch (e) {
      debugPrint("get user $e");
      return null;
    }
  }

  Future<String?> createUser(UserModel user) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection("users").doc(user.id).set(user.toJson());
    } catch (e) {
      debugPrint("createUser ${e.toString()}");
      return "something went wrong";
    }
    return null;
  }

  //test
  Future<List<TestModel>> getTests(String author) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final data = await firestore
          .collection("data")
          .doc(author)
          .collection("tests")
          .get();
      return data.docs.map((test) => TestModel.fromJson(test.data())).toList();
    } catch (e) {
      debugPrint("Get tests");
      return [];
    }
  }

  Future<TestModel> getSpecificTest(LiveModel live) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final test = await firestore
          .collection("data")
          .doc(live.author)
          .collection("tests")
          .doc(live.testId)
          .get();
      return TestModel.fromJson(test.data()!);
    } catch (e) {
      return TestModel(id: '-', author: '', title: '', onLive: null);
    }
  }

  Future<String?> createTest(TestModel test) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final res = await firestore
          .collection("data")
          .doc(test.author)
          .collection("tests")
          .add(test.toJson());
      test.id = res.id;
      await firestore
          .collection("data")
          .doc(test.author)
          .collection("tests")
          .doc(res.id)
          .set(test.toJson());
    } catch (e) {
      debugPrint("createTest ${e.toString()}");
      return "something went wrong";
    }
    return null;
  }

  Future<String?> updateTest(TestModel test) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection("data")
          .doc(test.author)
          .collection("tests")
          .doc(test.id)
          .update(
            test.toJson(),
          );
      return null;
    } catch (e) {
      debugPrint("Update test $e");
      return "something went wrong";
    }
  }

  Future<bool> deleteTest(TestModel test) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection("data")
          .doc(test.author)
          .collection("tests")
          .doc(test.id)
          .delete();
      return true;
    } catch (e) {
      debugPrint("delete test: $e");
      return false;
    }
  }
}

class QuestionDBService {
  Future<void> createQuestion(
    QuestionModel question,
  ) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final res = await firestore
          .collection("data")
          .doc(question.author)
          .collection("questions")
          .doc(question.testId)
          .collection("skip")
          .add(question.toJson());
      question.id = res.id;
      await firestore
          .collection("data")
          .doc(question.author)
          .collection("questions")
          .doc(question.testId)
          .collection("skip")
          .doc(question.id)
          .set(
            question.toJson(),
          );
    } catch (e) {
      debugPrint("create question $e");
    }
  }

  Future<List<QuestionModel>> getAllQuestions(
      String author, String testId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final res = await firestore
          .collection("data")
          .doc(author)
          .collection("questions")
          .doc(testId)
          .collection("skip")
          .get();
      final List json = res.docs.map((question) => question.data()).toList();
      return json.map((json) => QuestionModel.fromJson(json)).toList();
    } catch (e) {
      debugPrint("create question $e");
      return [];
    }
  }

  Future<void> updateQuestion(QuestionModel question) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection("data")
          .doc(question.author)
          .collection("questions")
          .doc(question.testId)
          .collection("skip")
          .doc(question.id)
          .update(
            question.toJson(),
          );
    } catch (e) {
      debugPrint("create question $e");
    }
  }

  Future<void> deleteQuestion(QuestionModel question) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection("data")
          .doc(question.author)
          .collection("questions")
          .doc(question.testId)
          .collection("skip")
          .doc(question.id)
          .delete();
    } catch (e) {
      debugPrint("create question $e");
    }
  }
}

class TestDBService {
  Stream<QuerySnapshot<Map<String, dynamic>>> getLiveData(TestModel test) {
    final firestore = FirebaseFirestore.instance;
    final path = firestore
        .collection("data")
        .doc(test.author)
        .collection("lives")
        .doc(test.id)
        .collection(
          test.onLive!.toString(),
        );
    return path.snapshots();
  }

  Future<LiveModel> getLive(String code) async {
    final firestore = FirebaseFirestore.instance;
    final res = await firestore.collection("lives").doc(code).get();
    return LiveModel.fromJson(res.data()!);
  }

  Future<void> startLive(TestModel test, LiveModel live) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await DBService().updateTest(test);
      ApplicantModel applicant = ApplicantModel(
        corrects: 0,
        totalAttempts: 0,
        userId: test.author,
        avatar: null,
        lastname: 'fake',
        name: 'fake',
        title: '',
        time: DateTime.now(),
      );
      await firestore
          .collection("data")
          .doc(test.author)
          .collection("lives")
          .doc(test.id)
          .collection(live.code.toString())
          .doc(test.author)
          .set(applicant.toJson());
      await firestore
          .collection("lives")
          .doc(live.code.toString())
          .set(live.toJson());
      await firestore
          .collection('data')
          .doc(test.author)
          .collection("lived_data")
          .doc(test.id)
          .collection("skip")
          .doc(live.code.toString())
          .set(
            live.toJson(),
          );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteLive(String code, LiveModel live) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('lives').doc(code).delete();
    await firestore
        .collection('data')
        .doc(live.author)
        .collection("lived_data")
        .doc(live.testId)
        .collection("skip")
        .doc(live.code.toString())
        .set(
          live.toJson(),
        );
  }

  Future<void> updateIt(LiveModel live, ApplicantModel applicant) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection("data")
        .doc(applicant.userId)
        .collection("applicants")
        .doc(live.code.toString())
        .set(applicant.toJson());
    await firestore
        .collection("data")
        .doc(live.author)
        .collection("lives")
        .doc(live.testId)
        .collection(live.code.toString())
        .doc(applicant.userId)
        .set(applicant.toJson());
  }

  Future<List<ApplicantModel>> applicants(UserModel user) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final data = await firestore
          .collection('data')
          .doc(user.id)
          .collection('applicants')
          .get();
      final result = data.docs
          .map((data) => ApplicantModel.fromJson(data.data()))
          .toList();
      return result;
    } catch (e) {
      return [];
    }
  }

  Future<List<ApplicantModel>> testDetail(LiveModel live) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final data = await firestore
          .collection('data')
          .doc(live.author)
          .collection('lives').doc(live.testId).collection(live.code.toString()).get();
      final result = data.docs
          .map((data) => ApplicantModel.fromJson(data.data()))
          .toList();
      return result;
    } catch (e) {
      return [];
    }
  }

  Future<bool> joinLive(UserModel user, String code) async {
    ApplicantModel applicant = ApplicantModel(
      corrects: 0,
      totalAttempts: 0,
      userId: user.id,
      avatar: user.avatar,
      lastname: user.lastname,
      name: user.firstname,
      title: "",
      time: DateTime.now(),
    );
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final res = await firestore
          .collection("data")
          .doc(user.id)
          .collection("applicants")
          .doc(code)
          .get();
      final testData = await firestore.collection("lives").doc(code).get();
      if (res.data() != null || testData.data() == null) {
        return false;
      } else {
        final live = LiveModel.fromJson(testData.data()!);
        await firestore
            .collection("data")
            .doc(user.id)
            .collection("applicants")
            .doc(code)
            .set(applicant.toJson());
        await firestore
            .collection("data")
            .doc(live.author)
            .collection("lives")
            .doc(live.testId)
            .collection(code)
            .doc(user.id)
            .set(applicant.toJson());
        return true;
      }
    } catch (e) {
      debugPrint("join live: $e");
      return false;
    }
  }

  Future<List<LiveModel>> lives(TestModel test) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = await firestore
        .collection('data')
        .doc(test.author)
        .collection('lived_data')
        .doc(test.id)
        .collection("skip")
        .get();
    return data.docs.map((data) => LiveModel.fromJson(data.data())).toList();
  }
}
