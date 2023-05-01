import 'package:affichage/pages/Etudiant/ReclamationDetail.dart';
import 'package:affichage/pages/Etudiant/addReclamation.dart';
import 'package:affichage/pages/HomeEtudiant/HomeEtudiant.dart';
import 'package:affichage/pages/HomeEtudiant/cubit/etudiant_cubit.dart';
import 'package:affichage/pages/HomeEtudiant/cubit/etudiant_state.dart';
import 'package:affichage/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/reclamationModel.dart';

class Reclamation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<EtudiantCubit, EtudiantState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          body: RefreshIndicator(
            edgeOffset: 0,
            onRefresh: () {
              EtudiantCubit.get(context).getAllReclamationById();
              return Future.delayed(const Duration(seconds: 3));
            },
            child: Column(
              children: [
                Expanded(
                  child: ConditionalBuilder(
                    builder: (BuildContext context) {
                      return ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          itemBuilder: (context, index) => defaultReclamation(
                              context,
                              EtudiantCubit.get(context)
                                  .reclamationByIdModelList![index],
                              index),
                          itemCount: EtudiantCubit.get(context)
                              .reclamationByIdModelList!
                              .length);
                    },
                    condition:
                        EtudiantCubit.get(context).reclamationByIdModelList !=
                                null &&
                            state is! LodinGetAllReclamationByIdState,
                    fallback: (BuildContext context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultSubmit2(
                    onPressed: () {
                      navigatAndReturn(
                          context: context, page: AddReclamation());
                    },
                    text: 'Add Reclamation',
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is DeleteReclamationStateGood) {
          showToast(msg: 'delete Successfuly', state: ToastStates.success);
        }
      },
    );
  }
}

Widget defaultReclamation(context, ReclamationModel model, int index) => Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        onTap: () {
          navigatAndReturn(
              context: context,
              page: ReclamationDetails(
                index: index,
              ));
        },
        onLongPress: () async {
          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text(
                      "Are you Sure ?",
                      style: TextStyle(),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cancel",
                            // style: TextStyle(color: Colors.green),
                          )),
                      TextButton(
                          onPressed: () {
                            EtudiantCubit.get(context)
                                .deleteReclamation(id: model.id!);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ))
                    ],
                  ));
        },
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(width: 1.0),
            ),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 20,
            child: Image.asset(
              model.done!
                  ? 'assets/images/done2.png'
                  : 'assets/images/cancel.png',
            ),
          ),
        ),
        title: Text(
          model.title!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.linear_scale,
              color: Colors.pink.shade800,
            ),
            Text(
              model.text!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Colors.pink[800],
        ),
      ),
    );
