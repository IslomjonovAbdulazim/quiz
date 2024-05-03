import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  Future<String?> uploadImageToFirebase(String imagePath, String userId) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    File imageFile = File(imagePath);

    try {
      TaskSnapshot snapshot = await storage
          .ref()
          .child('avatars/$userId.png')
          .putFile(imageFile);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }
}
