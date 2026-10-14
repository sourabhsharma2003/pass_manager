import 'package:password_manager/src/features/entries/data/entity_model.dart';
import 'package:password_manager/src/features/entries/domain/entry_domain.dart';

abstract class MockEntries {
  static const entry=EntryModel(
      id: '',
      sitename: 'sstsite',
      userNameOrEmail: 'test@gmail.com',
      entryCategory: EntryCategory.others,
      password: 'testpassword',
    );
  static const entry2=EntryModel(
      id: '',
      sitename: 'entry',
      userNameOrEmail: 'test@gmail.com',
      password: 'testpass',
      entryCategory: EntryCategory.personal,
    );

    static const entrywithid=EntryModel(
      id: '',
      sitename: 'entry',
      userNameOrEmail: 'test@gmail.com',
      password: 'testpass',
      entryCategory: EntryCategory.others,
    );
}