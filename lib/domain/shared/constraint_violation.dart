class ConstraintViolation {
  final String field;
  final String message;

  ConstraintViolation(this.field, this.message);

  factory ConstraintViolation.of(
      String field, String messagePattern, Map<String, String> parameters) {
    var message = messagePattern;
    parameters.forEach((key, value) { message.replaceFirst(key, value); });
    return ConstraintViolation(field, message);
  }
}
