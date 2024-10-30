import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:infinite_scroll_view/core/constants/firebase_constants.dart';
import 'package:infinite_scroll_view/core/error/failure.dart';
import 'package:infinite_scroll_view/core/models/task_model.dart';
import 'package:infinite_scroll_view/core/providers/firebase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository(firestore: ref.read(firestoreProvider));
}

class HomeRepository {
  final FirebaseFirestore _firestore;
  HomeRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _tasks =>
      _firestore.collection(FirebaseConstants.tasks);

  Future<Either<AppFailure, void>> addTask(TaskModel taskModel) async {
    try {
      final query = await _tasks.add(taskModel.toMap());
      await query.update(
          (taskModel.copyWith(taskId: query.id, reference: query)).toMap());

      return right(null);
    } catch (e) {
      return left(AppFailure(e.toString()));
    }
  }

  Future<(List<TaskModel>, DocumentSnapshot?)> fetchUsers(
      {required int pageSize, required DocumentSnapshot? lastDoc}) async {
    final initialQuery = _tasks.limit(pageSize);
    final query = lastDoc != null
        ? initialQuery
            .orderBy('createdDate', descending: false)
            .startAfterDocument(lastDoc)
        : initialQuery.orderBy('createdDate', descending: false);

    final snapshots = await query.get();

    final docs = snapshots.docs;

    if (docs.isEmpty) {
      return (List<TaskModel>.empty(), null);
    }

    final result = docs
        .map(
          (e) => TaskModel.fromMap(e.data() as Map<String, dynamic>),
        )
        .toList();

    final users = result.whereType<TaskModel>().toList();
    return (users, docs.last);
  }
}
