class PasswordValidator {
  static const int minLength = 8;
  static const int maxLength = 16;
  static const String allowedSpecialChars = r'().?-#!@$%&';

  static bool hasValidLength(String password) {
    return password.length >= minLength && password.length <= maxLength;
  }

  static bool hasUpperAndLowerCase(String password) {
    return password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[A-Z]'));
  }

  static bool hasNumber(String password) {
    return password.contains(RegExp(r'[0-9]'));
  }

  static bool hasSpecialCharacter(String password) {
    return password.contains(RegExp(r'[().?#!@$%&-]'));
  }

  static bool hasNoConsecutiveChars(String password) {
    for (int i = 0; i < password.length - 2; i++) {
      if (password[i] == password[i + 1] && password[i] == password[i + 2]) {
        return false;
      }
    }
    return true;
  }

  static bool hasNoTurkishChars(String password) {
    return !password.contains(RegExp(r'[ıİğĞüÜşŞöÖçÇ]'));
  }

  static Map<String, bool> validatePassword(String password) {
    return {
      'length': hasValidLength(password),
      'casing': hasUpperAndLowerCase(password),
      'number': hasNumber(password),
      'special': hasSpecialCharacter(password),
      'consecutive': hasNoConsecutiveChars(password),
      'turkishChars': hasNoTurkishChars(password),
    };
  }
}
