import 'package:password_manager/src/features/entries/data/entity_model.dart';
import 'package:password_manager/src/features/entries/domain/entry_domain.dart';

abstract class MockEntries {
  static const entry=EntryModel(
      id: '',
      sitename: 'sstsite',
      userNameOrEmail: 'stest@gmail.com',
      entryCategory: EntryCategory.others,
      password: 'testpassword',
    );
  static const entry2=EntryModel(
      id: '',
      sitename: 'entry',
      userNameOrEmail: 'etest@gmail.com',
      password: 'testpass',
      entryCategory: EntryCategory.personal,
    );

    static const entrywithid=EntryModel(
      id: 'itemid2',
      sitename: 'entry',
      userNameOrEmail: 'test@gmail.com',
      password: 'testpass',
      entryCategory: EntryCategory.others,
    );
     static const entrywithid2=EntryModel(
      id: 'itemid2',
      sitename: 'entry',
      userNameOrEmail: 'test@gmail.com',
      password: 'testpass',
      entryCategory: EntryCategory.others,
    );
}