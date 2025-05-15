// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarhanaciyasarmobil/utils/formatters/formatter.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String address;
  final DateTime? dateTime;
  bool selectedAddress;
  AddressModel({
    required this.address,
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    this.dateTime,
    this.selectedAddress = true,
  });

  String get formattedPhoneNo => TRFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
      id: '',
      name: '',
      phoneNumber: '',
      street: '',
      city: '',
      state: '',
      postalCode: '',
      address: '');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'address': address,
      'dateTime': DateTime.now(),
      'selectedAddress': selectedAddress
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
        address: data['address'] as String,
        id: data['id'] as String,
        name: data['name'] as String,
        phoneNumber: data['phoneNumber'] as String,
        street: data['street'] as String,
        city: data['city'] as String,
        state: data['state'] as String,
        postalCode: data['postalCode'] as String,
        selectedAddress: data['selectedAddress'] as bool,
        dateTime: (data['dateTime'] as Timestamp).toDate());
  }

  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return AddressModel(
        address: data['address'] ?? '',
        id: snapshot.id,
        name: data['name'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        street: data['street'] ?? '',
        city: data['city'] ?? '',
        state: data['state'] ?? '',
        postalCode: data['postalCode'] ?? '',
        selectedAddress: data['selectedAddress'] as bool,
        dateTime: (data['dateTime'] as Timestamp).toDate());
  }

  @override
  String toString() {
    return '$city, $state, $street, $postalCode';
  }
}
