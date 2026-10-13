import 'package:password_manager/src/core/result_wrapper/result.dart';
import 'package:password_manager/src/features/entries/data/entity_model.dart';
import 'package:password_manager/src/features/entries/data/entry_datasorce.dart';
import 'package:password_manager/src/features/entries/domain/entry_domain.dart';
import 'package:password_manager/src/features/entries/domain/entry_repo.dart';
import 'package:uuid/uuid.dart';

class EntryRepoImpl implements EntryRepo {
  final EntryDatasorce data;
  final Uuid uuid;
  List<EntryDomain> entries = [];
  EntryRepoImpl({required this.data, required this.uuid});
  @override
  Future<Result<void>> deleteEntry(String id) async {
    entries.removeWhere((test) => test.id == id);
    return await data.deleteEntry(id);
  }

  @override
  Future<Result<List<EntryDomain>>> getEntries() async {
    if (entries.isNotEmpty) {
      return Result.success(entries);
    }
    final result = await data.getentry();
    if (result.isFailure()) {
      return Result.failure(result.error);
    }
    if (result.data == null || result.data!.isEmpty) return Result.success([]);

    final fetchedentries = result.data!.map((data) => data.todomain()).toList();
    entries = fetchedentries;
    return Result.success(entries);
  }

  @override
  Future<Result<void>> saveEntry(EntryDomain domain) async {
    final id = uuid.v4();

    final entry = EntryModel.fromdomain(domain).copyWith(id: id);
    entries.add(entry.todomain());
    return await data.saveEntry(entry);
  }
}
