import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/helper/cashHelper.dart';
import '../Auth/login/login.dart';
import '../HomeResponsable/cubit/home_cubit.dart';
import 'UpdateResponsableForm.dart';

class ProfileResponsable extends StatelessWidget {
  const ProfileResponsable({super.key});

  @override
  Widget build(BuildContext context) {
    // print(model.id);
    // HomeCubit.get(context).getUserDetail(id: model.id.toString());
    Size size = MediaQuery.of(context).size;
    return (BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
        // if (state is DeleteUserStateGood) {
        //   showToast(msg: 'Delete Successfully', state: ToastStates.success);
        //   CachHelper.removdata(key: "token").then((value) {
        //     HomeCubit.get(context).resetValueWhenelogout();
        //     navigatAndFinish(context: context, page: Login());
        //   });
        // }
      },
      builder: (context, state) {
        return Scaffold(
            body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: ConditionalBuilder(
              builder: (BuildContext context) {
                return SizedBox(
                  height:
                      size.height - defaultAppBar().preferredSize.height * 2.5,
                  // padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 80.0,
                        backgroundImage: NetworkImage(
                            HomeCubit.get(context).responsableModel!.image!),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        HomeCubit.get(context).responsableModel!.name!,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      // Text(
                      //   'Software Developer',
                      //   style: TextStyle(fontSize: 16.0),
                      // ),
                      // SizedBox(height: 16.0),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text('Email'),
                        subtitle: Text(
                            HomeCubit.get(context).responsableModel!.email!),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: const Text('Phone'),
                        subtitle: Text(
                            HomeCubit.get(context).responsableModel!.phone!),
                        onTap: () {},
                      ),

                      const SizedBox(height: 8.0),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     navigatAndReturn(
                      //         context: context, page: UpdateUserForm());
                      //   },
                      //   child: Text('Edit Profile'),
                      // ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          navigatAndReturn(
                              context: context, page: UpdateResponsableForm());
                        },
                        child: const Text('Edit Profile'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 40),
                        child: defaultSubmit2(
                            text: 'Logout',
                            background: Colors.grey.shade800,
                            onPressed: () {
                              CachHelper.removdata(key: "token").then((value) {
                                // _homeCubit.resetWhenLogout();
                                navigatAndFinish(
                                    context: context, page: Login());
                                HomeCubit.get(context).resetValueWhenelogout();
                              });
                            }),
                      ),
                      // TextButton(
                      //   onPressed: () async {
                      //     await showDialog(
                      //         context: context,
                      //         builder: (context) => AlertDialog(
                      //               title: const Text(
                      //                 "Are you Sure ?",
                      //                 style: TextStyle(),
                      //               ),
                      //               actions: [
                      //                 TextButton(
                      //                     onPressed: () {
                      //                       Navigator.pop(context);
                      //                     },
                      //                     child: const Text(
                      //                       "Cancel",
                      //                       // style: TextStyle(color: Colors.green),
                      //                     )),
                      //                 TextButton(
                      //                     onPressed: () {
                      //                       HomeCubit.get(context).deleteUser(
                      //                           id: HomeCubit.get(context)
                      //                               .userModel!
                      //                               .id!);
                      //                       Navigator.pop(context);
                      //                     },
                      //                     child: const Text(
                      //                       "Delete",
                      //                       style: TextStyle(color: Colors.red),
                      //                     ))
                      //               ],
                      //             ));
                      //   },
                      //   child: Text(
                      //     "Delete Account ",
                      //     style: TextStyle(
                      //         color: Colors.red,
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.w600),
                      //   ),
                      // )
                    ],
                  ),
                );
              },
              condition: state is! LodinGetCurrentResponsableDetailState,
              //  && state is! LodinDeleteUserState,
              fallback: (BuildContext context) {
                return SizedBox(
                    height:
                        size.height - defaultAppBar().preferredSize.height * 2,
                    width: size.width,
                    child: const Center(child: CircularProgressIndicator()));
              },
            ),
          ),
        ));
      },
    ));
  }
}
