String firebaseErrorHandler(String errorCode) {
  String errorMessage;

  switch (errorCode) {
    case 'weak-password':
      errorMessage = 'كلمة المرور ضعيفة جدًا';
      break;
    case 'email-already-in-use':
      errorMessage = 'البريد الإلكتروني مستخدم بالفعل';
      break;
    case 'invalid-email':
      errorMessage = 'البريد الإلكتروني غير صالح';
      break;
    case 'invalid-credential':
      errorMessage = 'هناك خطأ في البريد الاكتروني او كلمة السر';
      break;
    case 'user-not-found':
      errorMessage = 'المستخدم غير موجود';
      break;
    case 'network-request-failed':
      errorMessage = 'تحقق من الاتصال في الانترنت';
      break;
    default:
      errorMessage = 'حدث خطأ أثناء تسجيل الدخول';
  }
  return errorMessage;
}
