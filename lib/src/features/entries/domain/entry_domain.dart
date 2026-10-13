class EntryDomain {
  final String id;
  final String sitename;
  final String userNameOrEmail;
  final String password;
  final EntryCategory entryCategory;
  const  EntryDomain({
    required this.id,
    required this.sitename,
    required this.userNameOrEmail,
    required this.password,
    required this.entryCategory
  });
}

enum EntryCategory { work, personal ,others}
