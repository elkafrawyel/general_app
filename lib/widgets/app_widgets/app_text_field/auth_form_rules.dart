class AuthFormRule {
  String ruleText;
  bool Function(String text) condition;

  AuthFormRule({
    required this.ruleText,
    required this.condition,
  });
}
