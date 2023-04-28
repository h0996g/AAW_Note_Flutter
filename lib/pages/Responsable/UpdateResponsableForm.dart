import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/components/components.dart';
import '../Home/cubit/home_cubit.dart';

class UpdateResponsableForm extends StatefulWidget {
  final emailController = TextEditingController();

  UpdateResponsableForm({super.key});

  @override
  State<UpdateResponsableForm> createState() => _UpdateResponsableFormState();
}

class _UpdateResponsableFormState extends State<UpdateResponsableForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement setState
    _emailController.text = HomeCubit.get(context).responsableModel!.email!;
    _nameController.text = HomeCubit.get(context).responsableModel!.name!;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is UpdateUserStateGood) {
          showToast(msg: 'Updated Successfully', state: ToastStates.success);
          HomeCubit.get(context).resetValueWheneUpdate();

          Navigator.pop(context);
        }
//         if (state is DeleteUserStateGood) {
//           showToast(msg: 'Delete Successfully', state: ToastStates.success);
//           CachHelper.removdata(key: "token").then((value) {
//             HomeCubit.get(context).resetValueWhenelogout();
//             navigatAndFinish(context: context, page: Login());
//           });

//         }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (state is LodinUpdateResponsableState) {
              return false;
            }
            HomeCubit.get(context).resetValueWheneUpdate();

            return true;
          },
          child: Scaffold(
            appBar: defaultAppBar(
                title: const Text('Update User'),
                canreturn: true,
                onPressed: () {
                  if (state is LodinUpdateResponsableState) {
                    return null;
                  }
                  Navigator.pop(context);
                  HomeCubit.get(context).resetValueWheneUpdate();
                }),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: size.height -
                        defaultAppBar().preferredSize.height * 2.5,
                    child: Column(children: [
                      if (state is LodinUpdateResponsableState)
                        const Column(
                          children: [
                            LinearProgressIndicator(),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: HomeCubit.get(context)
                                        .imageCompress !=
                                    null
                                ? Image.file(
                                        HomeCubit.get(context).imageCompress!)
                                    .image
                                : NetworkImage(HomeCubit.get(context)
                                    .responsableModel!
                                    .image!),
                            radius: 60,
                          ),
                          IconButton(
                            splashRadius: double.minPositive,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title:
                                            const Text("Choose the source :"),
                                        actions: [
                                          TextButton(
                                              onPressed: () async {
                                                if (state
                                                    is LodinUpdateResponsableState) {
                                                  return null;
                                                }
                                                await HomeCubit.get(context)
                                                    .imagePickerProfile(
                                                        ImageSource.camera)
                                                    .then((value) {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: const Text("Camera")),
                                          TextButton(
                                              onPressed: () async {
                                                if (state
                                                    is LodinUpdateResponsableState) {
                                                  return null;
                                                }
                                                await HomeCubit.get(context)
                                                    .imagePickerProfile(
                                                        ImageSource.gallery)
                                                    .then((value) {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: const Text("Gallery"))
                                        ],
                                      ));
                            },
                            icon: const CircleAvatar(
                              child: Icon(
                                Icons.camera,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultForm(
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                          label: 'Name',
                          prefixIcon: const Icon(Icons.person),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name Must Be Not Empty";
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultForm(
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          label: 'Phone',
                          prefixIcon: const Icon(Icons.email),
                          type: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email Must Be Not Empty";
                            }
                          }),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: defaultSubmit2(
                            text: 'Update',
                            background: Colors.grey,
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                if (state is LodinUpdateResponsableState) {
                                  return null;
                                }
                                HomeCubit.get(context).updateResponsable(
                                    id: HomeCubit.get(context)
                                        .responsableModel!
                                        .id!,
                                    name: _nameController.text,
                                    email: _emailController.text);
                              }
                            }),
                      ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
