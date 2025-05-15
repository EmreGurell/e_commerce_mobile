import 'package:intl/intl.dart';

class TRFormatter {
  // Türkçe tarih formatı
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd.MM.yyyy', 'tr_TR').format(date);
  }

  // Türk Lirası için para birimi formatı
  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'tr_TR', symbol: '₺').format(amount);
  }

  // Türkiye telefon formatı: (555) 123 45 67
  static String formatPhoneNumber(String phoneNumber) {
    final cleanedNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
    if (cleanedNumber.length == 10) {
      return '(${cleanedNumber.substring(0, 3)}) ${cleanedNumber.substring(3, 6)} ${cleanedNumber.substring(6, 8)} ${cleanedNumber.substring(8, 10)}';
    } else if (cleanedNumber.length == 11 && cleanedNumber.startsWith('0')) {
      return '(${cleanedNumber.substring(1, 4)}) ${cleanedNumber.substring(4, 7)} ${cleanedNumber.substring(7, 9)} ${cleanedNumber.substring(9, 11)}';
    }
    return phoneNumber;
  }

  // Uluslararası telefon formatı: +90 (555) 123 45 67
  static String internationalFormatPhoneNumber(String phoneNumber) {
    var digitsOnly =
        phoneNumber.replaceAll(RegExp(r'\D'), ''); // Sadece rakamlar
    String countryCode = '+90'; // Türkiye için varsayılan ülke kodu

    // Eğer ülke kodu varsa çıkarılır
    if (digitsOnly.startsWith('90')) {
      countryCode = '+${digitsOnly.substring(0, 2)}';
      digitsOnly = digitsOnly.substring(2);
    } else if (digitsOnly.startsWith('0')) {
      digitsOnly = digitsOnly.substring(1);
    }

    // Formatlama
    final formattedNumber = StringBuffer();
    formattedNumber.write('$countryCode ');

    if (digitsOnly.length >= 10) {
      formattedNumber.write('(${digitsOnly.substring(0, 3)}) ');
      formattedNumber.write('${digitsOnly.substring(3, 6)} ');
      formattedNumber.write('${digitsOnly.substring(6, 8)} ');
      formattedNumber.write(digitsOnly.substring(8, 10));
    } else {
      formattedNumber.write(digitsOnly); // Eksik numara olduğu durumda
    }

    return formattedNumber.toString();
  }
}
