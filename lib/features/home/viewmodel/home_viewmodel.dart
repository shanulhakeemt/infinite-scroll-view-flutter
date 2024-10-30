import 'package:fpdart/fpdart.dart';
import 'package:infinite_scroll_view/core/models/task_model.dart';
import 'package:infinite_scroll_view/features/home/repository/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_viewmodel.g.dart';

@riverpod
class HomeViewmodel extends _$HomeViewmodel {
  late HomeRepository _homeRepository;

  Future<void> addTask(TaskModel taskModel) async {
    state = const AsyncValue.loading();
    final res = await _homeRepository.addTask(taskModel);
  
    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right() =>state=const AsyncValue.data(null),
    };
  }

  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    return null;
  }
}
