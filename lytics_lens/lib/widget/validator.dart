class PasswordValidationWidget {
  static String? isPasswordCompliant(String password,
      [int minLength = 8, int maxLength = 20]) {
    if (password.isEmpty) {
      // return false;
      return 'This is a required field';
    }

    var hasUppercase = password.contains(RegExp(r'[A-Z]'));
    var hasDigits = password.contains(RegExp(r'[0-9]'));
    var hasLowercase = password.contains(RegExp(r'[a-z]'));
    var hasSpecialCharacters =
        password.contains(RegExp(r'[!"#$%&(' ')*+,-./:;<=>?@[\\]^_`{|}~]'));
    var hasMinLength =
        password.length >= minLength && password.length <= maxLength;
    if (!hasUppercase) {
      return 'Password Must Include one Upper Case Letter';
    }
    if (!hasLowercase) {
      return 'Password Must Include one Lower Case Letter';
    }
    if (!hasDigits) {
      return 'Password Must Include one Digit';
    }
    if (!hasSpecialCharacters) {
      return 'Password Must Include one Special Character';
    }
    if (!hasMinLength) {
      return 'Password Length must be greater than 8';
    }

    return null;
  }

  static String? validatePasswordOnPressed(String value) {
    return isPasswordCompliant(
      value,
    );
  }
}
