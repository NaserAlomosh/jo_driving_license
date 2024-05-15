class AppRegex {
  static bool isEmailValid(String email) {
    return RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
    ).hasMatch(email);
  }

  static bool isValidLink(String link) {
    final RegExp linkRegex = RegExp(
      r'^(http|https):\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,}(\/\S*)?$',
    );
    return linkRegex.hasMatch(link);
  }

  static bool isPasswordValid(String password) {
    return RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$",
    ).hasMatch(password);
  }

  static bool hasLowerCase(String password) {
    return RegExp(
      r'^(?=.*[a-z])',
    ).hasMatch(
      password,
    );
  }

  static bool hasUpperCase(String password) {
    return RegExp(
      r'^(?=.*[A-Z])',
    ).hasMatch(
      password,
    );
  }

  static bool hasNumber(String password) {
    return RegExp(
      r'^(?=.*?[0-9])',
    ).hasMatch(
      password,
    );
  }

  static bool hasSpecialCharacter(String password) {
    return RegExp(
      r'^(?=.*?[#?!@$%^&*-])',
    ).hasMatch(password);
  }

  static bool hasMinLength(String password) {
    return RegExp(
      r'^(?=.{8,})',
    ).hasMatch(password);
  }
}
