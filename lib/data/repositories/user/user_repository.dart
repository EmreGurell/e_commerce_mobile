import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarhanaciyasarmobil/data/repositories/authentication/authentication_repository.dart';
import 'package:tarhanaciyasarmobil/features/authentication/models/user_model.dart';
import 'package:tarhanaciyasarmobil/utils/exceptions/exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException().message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw 'Bir şeyler ters gitti. Lütfen tekrar deneyiniz.';
    }
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException().message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw 'Bir şeyler ters gitti. Lütfen tekrar deneyiniz.';
    }
  }

  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException().message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw 'Bir şeyler ters gitti. Lütfen tekrar deneyiniz.';
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException().message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw 'Bir şeyler ters gitti. Lütfen tekrar deneyiniz.';
    }
  }

  Future<void> removeUserRecord(String uid) async {
    try {
      await _db.collection("Users").doc(uid).delete();
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException().message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw 'Bir şeyler ters gitti. Lütfen tekrar deneyiniz.';
    }
  }

  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw MyFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MyFormatException().message;
    } on PlatformException catch (e) {
      throw MyPlatformException(e.code).message;
    } catch (e) {
      throw 'Bir şeyler ters gitti. Lütfen tekrar deneyiniz.';
    }
  }
}
