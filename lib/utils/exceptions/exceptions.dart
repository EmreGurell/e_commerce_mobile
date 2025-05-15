class MyFirebaseException implements Exception {
  final String code;

  MyFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'permission-denied':
        return 'Bu işlemi gerçekleştirme izniniz yok.';
      case 'unavailable':
        return 'Sunucu şu anda kullanılamıyor. Lütfen daha sonra tekrar deneyin.';
      case 'weak-password':
        return 'Girilen şifre çok zayıf.';
      case 'email-already-in-use':
        return 'Bu e-posta adresiyle zaten bir hesap mevcut.';
      case 'invalid-email':
        return 'Geçersiz e-posta adresi.';
      default:
        return 'Bir Firebase hatası oluştu. Lütfen tekrar deneyin.';
    }
  }
}

class MyFormatException implements Exception {
  const MyFormatException();

  String get message => 'Geçersiz veri formatı.';
}

class MyPlatformException implements Exception {
  final String code;

  MyPlatformException(this.code);

  String get message {
    switch (code) {
      case 'network_error':
        return 'Ağ hatası. Lütfen internet bağlantınızı kontrol edin.';
      case 'device_not_supported':
        return 'Bu özellik cihazınızda desteklenmiyor.';
      default:
        return 'Bir platform hatası oluştu. Lütfen tekrar deneyin.';
    }
  }
}

class MyFirebaseAuthException implements Exception {
  final String code;

  MyFirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case 'user-not-found':
        return 'Kullanıcı bulunamadı. Lütfen e-posta adresinizi kontrol edin.';
      case 'wrong-password':
        return 'Hatalı şifre girdiniz. Lütfen tekrar deneyin.';
      case 'user-disabled':
        return 'Bu hesap devre dışı bırakılmış. Destek ile iletişime geçin.';
      case 'too-many-requests':
        return 'Çok fazla başarısız giriş denemesi yapıldı. Lütfen daha sonra tekrar deneyin.';
      case 'operation-not-allowed':
        return 'Bu işlem şu anda desteklenmiyor.';
      case 'invalid-email':
        return 'Geçersiz e-posta adresi. Lütfen kontrol edin.';
      default:
        return 'Bir kimlik doğrulama hatası oluştu. Lütfen tekrar deneyin.';
    }
  }
}
