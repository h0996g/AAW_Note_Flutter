import 'package:affichage/pages/HomeEtudiant/HomeEtudiant.dart';
import 'package:affichage/pages/HomeEtudiant/cubit/etudiant_cubit.dart';
import 'package:affichage/pages/HomeEtudiant/cubit/etudiant_state.dart';
import 'package:affichage/pages/HomeResponsable/cubit/home_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';

class AddReclamation extends StatelessWidget {
  AddReclamation({Key? key}) : super(key: key);
  final titleController = TextEditingController();
  final textController = TextEditingController();
  final moduleController = TextEditingController();
  // final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<EtudiantCubit, EtudiantState>(
      builder: (BuildContext context, state) {
        EtudiantCubit _EtudiantCubit = BlocProvider.of(context);

        return Scaffold(
          appBar: defaultAppBar(onPressed: () {
            Navigator.pop(context);
            // navigatAndFinish(context: context, page: HomeEtudiant());
          }),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.08,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultForm(
                          type: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          label: 'Module',
                          prefixIcon: const Icon(Icons.book),
                          controller: moduleController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Module Must Be Not Empty";
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultForm(
                          controller: titleController,
                          type: TextInputType.text,
                          label: 'Title',
                          textInputAction: TextInputAction.next,
                          prefixIcon: const Icon(Icons.title),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Title Must Be Not Empty";
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.description,
                            size: 23,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "Description",
                            style: TextStyle(fontSize: 23),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      defaultForm(
                          type: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          // prefixIcon: const Icon(Icons.description),
                          controller: textController,
                          maxLines: 3,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Description Must Be Not Empty";
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      // Align(
                      //   alignment: Alignment.bottomRight,
                      //   child: ConditionalBuilder(
                      //     builder: (BuildContext context) {
                      //       return defaultSubmit1(
                      //           formKey: formKey,
                      //           onPressed: () {
                      //             if (formKey.currentState!.validate()) {
                      //               EtudiantCubit.get(context).addreclamation(
                      //                   title: titleController.text,
                      //                   text: textController.text,
                      //                   module: moduleController.text,
                      //                   id: HomeCubit.get(context)
                      //                       .etudiantModel!
                      //                       .data!
                      //                       .id!);
                      //             }
                      //           });
                      //     },
                      //     condition: state is! LodinAddReclamationState,
                      //     fallback: (BuildContext context) {
                      //       return const Center(
                      //         child: CircularProgressIndicator(),
                      //       );
                      //     },
                      //   ),
                      // ),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: ConditionalBuilder(
                          builder: (BuildContext context) {
                            return defaultSubmit2(
                                // formKey: formKey,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    EtudiantCubit.get(context).addreclamation(
                                      title: titleController.text,
                                      text: textController.text,
                                      module: moduleController.text,
                                    );
                                  }
                                },
                                text: 'Add Reclamation');
                          },
                          condition: state is! LodinAddReclamationState,
                          fallback: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      )
                    ]),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is AddReclamationStateGood) {
          showToast(msg: "Succesffuly Registered", state: ToastStates.success);

          navigatAndFinish(context: context, page: const HomeEtudiant());
        }
      },
    );
  }
}
