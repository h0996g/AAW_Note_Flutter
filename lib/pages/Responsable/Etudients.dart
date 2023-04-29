import 'package:affichage/pages/Responsable/EtudiantProfile.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/userModel.dart';
// import '../../shared/components/components.dart';
import '../../shared/components/components.dart';
import '../Home/cubit/home_cubit.dart';

class Etudiants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          // floatingActionButton: defaultSubmit1(
          //   background: Colors.orangeAccent,
          //   onPressed: () {
          //     navigatAndReturn(context: context, page: AddUser());
          //   },
          //   isothericon: true,
          //   icon: const Icon(Icons.add),
          // ),

          body: RefreshIndicator(
              edgeOffset: 0,
              onRefresh: () {
                HomeCubit.get(context).getEtudiants();
                return Future.delayed(const Duration(seconds: 3));
              },
              child: HomeCubit.get(context).etudiantModelList!.isNotEmpty
                  ? ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      itemBuilder: (context, index) => defaultTask(
                          context,
                          HomeCubit.get(context).etudiantModelList![index],
                          index),
                      itemCount:
                          HomeCubit.get(context).etudiantModelList!.length)
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "EMPTY",
                            style: TextStyle(fontSize: 50),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: MaterialButton(
                                splashColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                minWidth: double.minPositive,
                                child: const Icon(
                                  Icons.refresh,
                                  size: 50,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  HomeCubit.get(context).getEtudiants();
                                },
                              ))
                        ],
                      ),
                    )),
        );
      },
      listener: (BuildContext context, Object? state) async {
        // if (state is DeleteUserStateGood) {
        //   showToast(msg: 'Deleted Successfully', state: ToastStates.success);

        //   Navigator.pop(context); //! hadi t3 showdialog
        // } else if (state is DeleteUserStateBad) {
        //   showToast(msg: "Something Went Wrong", state: ToastStates.error);
        // }
      },
    );
  }
}

Widget defaultTask(context, UserModel model, int id) => Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        onTap: () {
          navigatAndReturn(
              context: context,
              page: EtudiantProfile(
                model: model,
              ));
        },
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                HomeCubit.get(context)
                                    .deleteEtudiant(id: model.id!);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ))
                  ],
                );
              });
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
            backgroundImage: NetworkImage(
              model.image!,
            ),
            backgroundColor: Colors.transparent,
            radius: 20,
            // child: Image.network(model.image!, fit: BoxFit.cover),
          ),
        ),
        title: Text(
          model.name!,
          maxLines: 2,
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
              model.email!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        trailing: Icon(
          Icons.messenger_outline_outlined,
          size: 30,
          color: Colors.pink[800],
        ),
      ),
    );
