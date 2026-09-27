abstract class EntrySqlConstant {
  static const String table = '''CREATE TABLE entries(
        id TEXT PRIMARY KEY,
        sitename TEXT,
        userNameOrEmail TEXT,
        password TEXT,
        entryCategory TEXT
        )''';
}
