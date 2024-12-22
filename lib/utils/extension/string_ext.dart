extension StringExt on String {
  String getFileExtension() {
    try {
      return this.split('.').last;
    } catch (e) {
      return '';
    }
  }

  double thousandsToDouble() {
    try {
      return double.parse(this.replaceAll(',', ''));
    } catch (e) {
      return 0;
    }
  }

  bool isValidEmail() {
    // Regular expression pattern for a valid email
    RegExp regex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$',
      caseSensitive: false,
      multiLine: false,
    );

    // Check if the email matches the pattern
    if (regex.hasMatch(this)) {
      return true; // Valid email
    } else {
      return false; // Invalid email
    }
  }

  bool isValidPassword() {
    return this.length >= 8 && this.contains(RegExp(r'[A-Z]')) && this.contains(RegExp(r'[0-9]'));
  }

}