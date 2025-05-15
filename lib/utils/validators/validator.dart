class Validator {
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName boş bırakılamaz.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen email giriniz.';
    }

    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zAZ0-9.-]+\.[a-zA-Z]{2,}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Geçersiz email.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen şifre giriniz.';
    }

    if (value.length < 6) {
      return 'Şifreniz en az 6 karakter uzunluğunda olmalıdır.';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Şifreniz en az 1 özel karakter içermelidir.';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Şifreniz en az 1 büyük harf içermelidir.';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Şifreniz en az 1 rakam içermelidir.';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lütfen telefon numarası giriniz.';
    }

    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Geçersiz telefon numarası (10 karakter gereklidir).';
    }

    return null;
  }
}
