import 'package:password_manager/src/core/result_wrapper/result.dart';
import 'package:password_manager/src/features/entries/domain/entry_domain.dart';
import 'package:password_manager/src/features/entries/domain/entry_repo.dart';

class EntryUseCases {
  final AddNewEntry addNewEntry;
  final GetEntries getEntries;
  final DeleteEntry deleteEntry;
  final SearchEntry searchEntry;

  EntryUseCases(EntryRepo repo)
    : addNewEntry = AddNewEntry(repo),
      getEntries = GetEntries(repo),
      deleteEntry = DeleteEntry(repo),
      searchEntry = SearchEntry(repo);
}

class AddNewEntry {
  final EntryRepo repo;
  const AddNewEntry(this.repo);
  Future<Result<void>> call(EntryDomain entry) async {
    return await repo.saveEntry(entry);
  }
}

class GetEntries {
  final EntryRepo repo;
  const GetEntries(this.repo);
  Future<Result<Map<EntryCategory, List<EntryDomain>>>> call() async {
    final result = await repo.getEntries();
    if (result.isFailure()) {
      return Result.failure(result.error);
    }
    if (result.data == null || result.data!.isEmpty) {
      return Result.success({});
    }
    Map<EntryCategory, List<EntryDomain>> grouped = {};
    for (var i in result.data!) {
      grouped.putIfAbsent(i.entryCategory, () => []).add(i);
    }
    return Result.success(grouped);
  }
}

class DeleteEntry {
  final EntryRepo repo;
  const DeleteEntry(this.repo);
  Future<Result<void>> call(String id) async {
    return await repo.deleteEntry(id);
  }
}

class SearchEntry {
  final EntryRepo repo;
  const SearchEntry(this.repo);
  Future<Result<List<EntryDomain>>> call(String query) async {
    final result = await repo.getEntries();

    if (result.isFailure()) {
      return Result.failure(result.error);
    }
    if (result.data == null || result.data!.isEmpty) {
      return Result.success([]);
    }
    final queryresult = result.data
        ?.where(
          (v) =>
              v.userNameOrEmail.toLowerCase().contains(query.trim().toLowerCase()) &&
              v.userNameOrEmail.toLowerCase().startsWith(query[0].toLowerCase().trim()),
        )
        .toList();

    if (queryresult == null || queryresult.isEmpty) {
      return Result.success([]);
    }

    return Result.success(queryresult);
  }
}
