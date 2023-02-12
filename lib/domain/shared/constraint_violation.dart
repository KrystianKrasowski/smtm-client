class ConstraintViolations {
  final List<ConstraintViolation> violations;

  ConstraintViolations(this.violations);

  String get(String fieldName) =>
      violations.firstWhere((element) => element.field == fieldName).message;
}

class ConstraintViolation {
  final String field;
  final String message;

  ConstraintViolation(this.field, this.message);

  factory ConstraintViolation.of(
      String field, String messagePattern, Map<String, String> parameters) {
    var message = messagePattern;
    parameters.forEach((key, value) {
      message = message.replaceAll(key, value);
    });
    return ConstraintViolation(field, message);
  }
}
