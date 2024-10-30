import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinite_scroll_view/core/models/task_model.dart';
import 'package:infinite_scroll_view/features/home/repository/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final listOfTasksViewModelProvider =
    AsyncNotifierProvider<ListOfTasksViewModel, List<TaskModel>>(
  () => ListOfTasksViewModel(),
);

class ListOfTasksViewModel extends AsyncNotifier<List<TaskModel>> {
  final pageSize = 8;
  bool _hasMore = true;
  DocumentSnapshot? lastDoc;
  bool get hasMore => _hasMore;
  late HomeRepository _homeRepository;

  Future<void> fetchUsers() async {
    if (state.value != null && state.value!.isNotEmpty) {
      if (_hasMore) {
        state = const AsyncLoading();
        await Future.delayed(const Duration(milliseconds: 1000));
        final res = await _homeRepository.fetchUsers(
            pageSize: pageSize, lastDoc: lastDoc);
        lastDoc = res.$2;

        if (res.$1.length < pageSize) {
          _hasMore = false;
        }

        final oldUsers = [...state.value!];

        state = await AsyncValue.guard(
          () => Future.value(oldUsers + res.$1),
        );
      }
    } else {
      state = const AsyncLoading();

      await Future.delayed(const Duration(milliseconds: 1000));
      final res = await _homeRepository.fetchUsers(
          pageSize: pageSize, lastDoc: lastDoc);
      lastDoc = res.$2;
      state = await AsyncValue.guard(
        () => Future.value(res.$1),
        );
   
    }
  }

  @override
  FutureOr<List<TaskModel>> build() async {
    _homeRepository = ref.watch(homeRepositoryProvider);
    return [];
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:infinite_scroll_view/core/models/task_model.dart';
// import 'package:infinite_scroll_view/features/home/repository/home_repository.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// final listOfTasksViewModelProvider =
//     AsyncNotifierProvider<ListOfTasksViewModel, List<TaskModel>>(
//   () => ListOfTasksViewModel(),
// );

// class ListOfTasksViewModel extends AsyncNotifier<List<TaskModel>> {
//   final pageSize = 10;
//   bool _hasMore = true;
//   DocumentSnapshot? lastDoc;
//   bool get hasMore => _hasMore;
  

//   Future<List<TaskModel>> _fetchUsers() async {
//     await Future.delayed(const Duration(milliseconds: 1000));
//     final result = await ref
//         .read(homeRepositoryProvider)
//         .fetchUsers(pageSize: pageSize, lastDoc: lastDoc);
//     _hasMore = result.$1.isNotEmpty;
//     final lastDocument = result.$2;
//     if (lastDocument != null) {
//       lastDoc = lastDocument;
//     }
//     return result.$1;
//   }

//   Future<void> fetchMore() async {
//     if (state.isLoading || !_hasMore || lastDoc == null) return;

//     state = const AsyncValue.loading();
//     final newState = await AsyncValue.guard(
//       () async {
//         final newUsers = await _fetchUsers();
//         return [...?state.value, ...newUsers];
//       },
//     );
//     state = newState;
//   }

//   @override
//   FutureOr<List<TaskModel>> build() async {
//     state = const AsyncLoading();
//     final newState = await AsyncValue.guard(_fetchUsers);
//     state = newState;
//     return newState.value ?? [];
//   }
// }
