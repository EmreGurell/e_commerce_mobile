// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  String? productsCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productsCount,
  });

  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'productsCount': productsCount,
      'isFeatured': isFeatured
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      productsCount: data['productsCount'] ?? 0.toString(),
    );
  }

  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return BrandModel(
        id: document.id,
        name: data['name'] ?? '',
        image: data['image'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        productsCount: data['productsCount']?.toString(),
      );
    } else {
      return BrandModel.empty();
    }
  }
}
