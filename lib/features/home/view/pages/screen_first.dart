import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_view/core/constants/firebase_constants.dart';
import 'package:infinite_scroll_view/core/models/task_model.dart';
import 'package:infinite_scroll_view/core/widgets/loader.dart';
import 'package:infinite_scroll_view/features/home/view/pages/screen_add.dart';
import 'package:infinite_scroll_view/features/home/view/widgets/custom_floating_action.dart';
import 'package:infinite_scroll_view/features/home/view/widgets/custom_user_card.dart';
import 'package:infinite_scroll_view/features/home/viewmodel/list_of_tasks_viewmodel.dart';

class ScreenFirst extends ConsumerStatefulWidget {
  const ScreenFirst({super.key});

  @override
  ConsumerState<ScreenFirst> createState() => _ScreenFirstState();
}

class _ScreenFirstState extends ConsumerState<ScreenFirst> {
  late ScrollController _controller;
  bool _isFetching = false; // Track fetching state
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(listOfTasksViewModelProvider.notifier).fetchUsers();
      },
    );

    _controller = ScrollController()
      ..addListener(() {
        final isBottom =
            _controller.offset >= _controller.position.maxScrollExtent &&
                !_controller.position.outOfRange;

        if (isBottom && !_isFetching) {
          _isFetching = true; // Set fetching state to true
          ref
              .read(listOfTasksViewModelProvider.notifier)
              .fetchUsers()
              .then((_) {
            _isFetching = false; // Reset fetching state
          });
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller directly here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GestureDetector(
          onTap: () async {
        
          },
          child: Text(
            "All Users ",
            style: GoogleFonts.poppins(),
          ),
        ),
      ),
      floatingActionButton: CustomFloatingAction(
        icon: CupertinoIcons.add,
        onPress: () {
          // FirebaseFirestore
          Navigator.push(context, ScreenAdd.route());
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Consumer(builder: (context, ref, child) {
          final taskValue = ref.watch(listOfTasksViewModelProvider);
          final taskNotifier = ref.watch(listOfTasksViewModelProvider.notifier);
          return (taskValue.value == null || taskValue.isLoading) &&
                  (taskValue.value != null && taskValue.value!.isEmpty)
              ? const Loader()
              : taskValue.value!=null&& taskValue.value!.isEmpty
                  ? Center(
                      child: Text(
                        "No Tasks",
                        style: GoogleFonts.poppins(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    )
                  : ListView.builder(
                      controller: _controller,
                      itemCount: taskValue.value == null
                          ? 0
                          : (taskValue.isLoading)
                              ? taskValue.value!.length + 1
                              : (!taskNotifier.hasMore)
                                  ? taskValue.value!.length + 1
                                  : taskValue.value!.length,
                      itemBuilder: (context, index) {
                        return index == taskValue.value!.length &&
                                !taskNotifier.hasMore
                            ? Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  child: Text(
                                    "All tasks listed",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            : (index == taskValue.value!.length &&
                                    taskNotifier.hasMore)
                                ? const Loader()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18),
                                    child: CustomUserCard(
                                        age: taskValue.value![index].status
                                            .toString(),
                                        name: taskValue.value![index].taskName,
                                        height: 80),
                                  );
                      },
                    );
        }),
      ),
    );
  }
}
