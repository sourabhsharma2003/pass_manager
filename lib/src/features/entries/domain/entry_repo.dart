import 'package:password_manager/src/core/result_wrapper/result.dart';
import 'package:password_manager/src/features/entries/domain/entry_domain.dart';

abstract class EntryRepo {
  Future<Result<void>> saveEntry(EntryDomain domain);
  Future<Result<List<EntryDomain>>> getEntries();
  Future<Result<void>> deleteEntry(String id);
  Future<Result<void>> deleteDatabase();
}
