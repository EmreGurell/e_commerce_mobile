import 'package:flutter/material.dart';

class ProjectBoxShadow {
  static BoxShadow lowerButtonShadow = BoxShadow(
    color: Colors.black.withOpacity(0.2), // Gölge rengi
    spreadRadius: 5, // Gölgede yayılma miktarı
    blurRadius: 10, // Bulanıklık miktarı
    offset: const Offset(0, 3), // Gölgenin pozisyonu
  );

  static BoxShadow lowButtonShadow = BoxShadow(
    color: Colors.black.withOpacity(0.15),
    spreadRadius: 4,
    blurRadius: 8,
    offset: const Offset(0, 2),
  );

  static BoxShadow middleButtonShadow = BoxShadow(
    color: Colors.black.withOpacity(0.3),
    spreadRadius: 6,
    blurRadius: 12,
    offset: const Offset(0, 4),
  );

  static BoxShadow highButtonShadow = BoxShadow(
    color: Colors.black.withOpacity(0.4),
    spreadRadius: 8,
    blurRadius: 16,
    offset: const Offset(0, 6),
  );

  static BoxShadow lowerCardShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.1),
    spreadRadius: 2,
    blurRadius: 4,
    offset: const Offset(0, 1),
  );

  static BoxShadow lowCardShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.15),
    spreadRadius: 3,
    blurRadius: 6,
    offset: const Offset(0, 2),
  );

  static BoxShadow middleCardShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 4,
    blurRadius: 8,
    offset: const Offset(0, 3),
  );

  static BoxShadow highCardShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.3),
    spreadRadius: 5,
    blurRadius: 10,
    offset: const Offset(0, 4),
  );

  static BoxShadow focusedShadow = BoxShadow(
    color: Colors.blue.withOpacity(0.3),
    spreadRadius: 4,
    blurRadius: 8,
    offset: const Offset(0, 3),
  );

  static BoxShadow hoverShadow = BoxShadow(
    color: Colors.black.withOpacity(0.25),
    spreadRadius: 6,
    blurRadius: 12,
    offset: const Offset(0, 4),
  );

  static BoxShadow errorShadow = BoxShadow(
    color: Colors.red.withOpacity(0.3),
    spreadRadius: 4,
    blurRadius: 8,
    offset: const Offset(0, 3),
  );

  static BoxShadow successShadow = BoxShadow(
    color: Colors.green.withOpacity(0.3),
    spreadRadius: 4,
    blurRadius: 8,
    offset: const Offset(0, 3),
  );
}
