abstract class Env {
  static const String pinkey = String.fromEnvironment('pin_key');

  static const String passkey = String.fromEnvironment('pass_key');
  static const String dbkey = String.fromEnvironment('db_key');
}
