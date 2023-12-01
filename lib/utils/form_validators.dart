class FormValidators {
  static String? validateName(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Name is required';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Email is required';
    } else if (!isValidEmail(value!)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validateMessage(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Message is required';
    }
    return null;
  }

  static bool isValidEmail(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }
}
