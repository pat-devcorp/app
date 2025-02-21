class StringHandler{
  static String? notEmptyAndNoMoreThan(
      String fieldName, String value, int maxLength) {
    if (value.isEmpty) {
      return "$fieldName cannot be empty.";
    }
    if (value.length > maxLength) {
      return "$fieldName cannot exceed $maxLength characters.";
    }
    return null;
  }

  static String? notContainNumbers(String fieldName, String value) {
    if (RegExp(r'\d').hasMatch(value)) {
      return "$fieldName cannot contain numbers.";
    }
    return null;
  }

  static String? validateISO8601Date(String fieldName, String value) {
    try {
      DateTime.parse(value);
      return null;
    } catch (e) {
      return "$fieldName is not a valid ISO 8601 date.";
    }
  }

  static String? isValidPhoneNumber(String fieldName, String value) {
    if (!RegExp(r'^\+?\d+$').hasMatch(value)) {
      return "$fieldName must contain only numbers and an optional leading '+'.";
    }
    return null;
  }

  static List<String> isValidEmail(String fieldName, String email) {
    List<String> errors = [];
    if (email.isEmpty) {
      errors.add("$fieldName cannot be empty");
    } else {
      final emailRegex =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
      if (!emailRegex.hasMatch(email)) {
        errors.add("Invalid $fieldName format");
      }
    }
    return errors;
  }
}