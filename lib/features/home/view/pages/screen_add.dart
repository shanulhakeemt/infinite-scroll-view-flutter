import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_view/core/models/task_model.dart';
import 'package:infinite_scroll_view/core/utils.dart';
import 'package:infinite_scroll_view/core/widgets/loader.dart';
import 'package:infinite_scroll_view/features/home/view/widgets/custom_button.dart';
import 'package:infinite_scroll_view/features/home/view/widgets/custom_field.dart';
import 'package:infinite_scroll_view/features/home/viewmodel/home_viewmodel.dart';

class ScreenAdd extends ConsumerStatefulWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => const ScreenAdd(),
    );
  }

  const ScreenAdd({super.key});

  @override
  ConsumerState<ScreenAdd> createState() => _ScreenAddState();
}

class _ScreenAddState extends ConsumerState<ScreenAdd> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    nameController.dispose();
    statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                "Create +",
                style: GoogleFonts.poppins(fontSize: 50),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomField(hintText: "Name", controller: nameController),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                hintText: "Status",
                controller: statusController,
                isNumberInputType: true,
              ),
              const SizedBox(
                height: 40,
              ),
              Consumer(builder: (context, ref, child) {
                final isLoading = ref.watch(homeViewmodelProvider.select(
                  (value) => value?.isLoading == true,
                ));

                ref.listen(
                  homeViewmodelProvider,
                  (_, next) {
                    next?.when(
                      data: (data) {
                        showSnackBar(context, "Succeccfully added task");
                        Navigator.pop(context);
                      },
                      error: (error, stackTrace) {
                        showSnackBar(context, error.toString());
                      },
                      loading: () {},
                    );
                  },
                );

                return isLoading
                    ? const Loader()
                    : CustomButton(
                        height: 50,
                        width: 250,
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            print("taped");
                            ref.read(homeViewmodelProvider.notifier).addTask(
                                TaskModel(
                                    createdDate: DateTime.now(),
                                    taskId: '',
                                    taskName: nameController.text,
                                    status: int.tryParse(
                                            statusController.text.trim()) ??
                                        0));
                          }
                        },
                        text: "Create",
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
