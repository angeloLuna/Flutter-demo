class ValidationMixins {

  String validateEmail(value) {
    if (!value.contains("@") || !value.contains(".")) {
      return 'Invalid email';
    }
    return null;
  }

  String validateLength(value) {
    if (value.length < 4) {
      return 'password too short';
    }
    return null;
  }

  String validateRequired(value) {
    if (value.length < 1) {
      return 'Field required';
    }
    return null;
  }

}