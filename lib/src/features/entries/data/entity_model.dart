import 'package:password_manager/src/features/entries/domain/entry_domain.dart';

class EntryModel {
  final String id;
  final String sitename;
  final String userNameOrEmail;
  final String password;
  final EntryCategory entryCategory;
  const  EntryModel({
    required this.id,
    required this.sitename,
    required this.userNameOrEmail,
    required this.entryCategory,
    required this.password,
  });

  EntryModel copyWith({
    String? id,
    String? sitename,
    String? userNameOrEmail,
    String? password,
    EntryCategory? entryCategory,
  }) {
    return EntryModel(
      id: id ?? this.id,
      sitename: sitename ?? this.sitename,
      userNameOrEmail: userNameOrEmail ?? this.userNameOrEmail,
      entryCategory: entryCategory ?? this.entryCategory,
      password: password ?? this.password,
    );
  }

  factory EntryModel.fromdb(Map<String, dynamic> db) {
    return EntryModel(
      id: db['id'] ?? '',
      sitename: db['sitename'] ?? '',
      userNameOrEmail: db['userNameOrEmail'] ?? '',
      password: db['password'] ?? '',
      entryCategory: EntryCategory.values.firstWhere((v)=>v.name==db['entryCategory'],orElse: () => EntryCategory.others,)
      
    );
  }

  Map<String, dynamic> todb() {
    return {
      "id": id,
      "sitename": sitename,
      "userNameOrEmail": userNameOrEmail,
      "password": password,
      "entryCategory": entryCategory.name,
    };
  }

 factory EntryModel.fromdomain(EntryDomain domain) {
    return EntryModel(
      id: domain.id,
      sitename: domain.sitename,
      userNameOrEmail: domain.userNameOrEmail,
      password: domain.password,
      entryCategory: domain.entryCategory,
    );
  }

  EntryDomain todomain() {
    return EntryDomain(
      id: id,
      sitename: sitename,
      userNameOrEmail: userNameOrEmail,
      password: password,
      entryCategory: entryCategory,
    );
  }
}
