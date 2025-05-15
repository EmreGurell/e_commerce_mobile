import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarhanaciyasarmobil/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String email;
  final String phoneNumber;

  UserModel({
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.id,
  });

  String get fullName => '$firstName $lastName';
  String get formattedPhoneNumber => TRFormatter.formatPhoneNumber(phoneNumber);

  static List<String> nameParts(String fullName) => fullName.split(" ");

  static UserModel empty() => UserModel(
      phoneNumber: '', firstName: '', lastName: '', email: '', id: '');

  // Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  // Convert Firestore DocumentSnapshot to UserModel
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    try {
      final data = document.data();

      print("Firestore’dan gelen veri: $data");

      if (data == null) {
        throw Exception("Firestore'dan boş veri alındı.");
      }

      return UserModel(
        id: document.id,
        phoneNumber: (data['phoneNumber'] ?? '').toString(),
        firstName: (data['firstName'] ?? '').toString(),
        lastName: (data['lastName'] ?? '').toString(),
        email: (data['email'] ?? '').toString(),
      );
    } catch (e) {
      print("JSON parsing hatası: $e");
      throw Exception("Firestore verisi JSON formatına çevrilemedi.");
    }
  }
}
