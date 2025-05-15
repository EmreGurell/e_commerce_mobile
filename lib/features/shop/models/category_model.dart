import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String parentId;
  String image;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = '',
    required this.isFeatured,
  });

  //Empty Helper Function
  static CategoryModel empty() => CategoryModel(
      id: '', name: '', parentId: '', isFeatured: false, image: '');

  //Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'parentId': parentId,
      'isFeatured': isFeatured,
    };
  }

  //Map Json oriented document snapshot from Firebase to UserModel
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return CategoryModel(
          id: document.id,
          name: data['name'] ?? '',
          parentId: data['parentId'] ?? '',
          isFeatured: data['isFeatured'] ?? false,
          image: data['image'] ?? '');
    } else {
      return CategoryModel.empty();
    }
  }
}
