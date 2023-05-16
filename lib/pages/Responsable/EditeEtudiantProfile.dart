import 'package:affichage/pages/Responsable/EtudiantProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/components/components.dart';
import '../HomeResponsable/cubit/home_cubit.dart';

class EditeEtudiantProfile extends StatefulWidget {
  // final UserModel model;

  final emailController = TextEditingController();

  EditeEtudiantProfile({super.key});

  @override
  State<EditeEtudiantProfile> createState() => _EditeEtudiantProfileState();
}

class _EditeEtudiantProfileState extends State<EditeEtudiantProfile> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imathController = TextEditingController();
  final TextEditingController _cmathController = TextEditingController();
  final TextEditingController _iphysiqueController = TextEditingController();
  final TextEditingController _cphysiqueController = TextEditingController();
  final TextEditingController _ialgoController = TextEditingController();
  final TextEditingController _calgoController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement setState
    _emailController.text = HomeCubit.get(context).etudiantModel!.data!.email!;
    _nameController.text = HomeCubit.get(context).etudiantModel!.data!.name!;
    _imathController.text =
        HomeCubit.get(context).etudiantModel!.math!.intero.toString();
    _cmathController.text =
        HomeCubit.get(context).etudiantModel!.math!.controle.toString();
    _iphysiqueController.text =
        HomeCubit.get(context).etudiantModel!.physique!.intero.toString();
    _cphysiqueController.text =
        HomeCubit.get(context).etudiantModel!.physique!.controle.toString();
    _ialgoController.text =
        HomeCubit.get(context).etudiantModel!.algo!.intero.toString();
    _calgoController.text =
        HomeCubit.get(context).etudiantModel!.algo!.controle.toString();
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
          // HomeCubit.get(context)
          //     .getEtudiantDetail(id: HomeCubit.get(context).etudiantModel!.id!)
          //     .then((value) {
          // Navigator.pop(context);
          // });
          navigatAndFinish(
              context: context,
              page: EtudiantProfile(
                  model: HomeCubit.get(context).etudiantModel!.data!));
        }
        if (state is UpdateUserNoteStateGood) {
          showToast(
              msg: 'Note Updated Successfully', state: ToastStates.success);
          HomeCubit.get(context).resetValueWheneUpdate();
        }
        // if (state is DeleteUserStateGood) {
        //   showToast(msg: 'Delete Successfully', state: ToastStates.success);
        //   CachHelper.removdata(key: "token").then((value) {
        //     HomeCubit.get(context).resetValueWhenelogout();
        //     navigatAndFinish(context: context, page: Login());
        //   });

        // }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (state is LodinUpdateUserState) {
              return false;
            }
            HomeCubit.get(context).resetValueWheneUpdate();
            navigatAndFinish(
                context: context,
                page: EtudiantProfile(
                    model: HomeCubit.get(context).etudiantModel!.data!));
            return false;
          },
          child: Scaffold(
            appBar: defaultAppBar(
                title: const Text('Update User'),
                canreturn: true,
                onPressed: () {
                  if (state is LodinUpdateUserNoteState) {
                    return null;
                  }
                  Navigator.pop(context);
                  HomeCubit.get(context).resetValueWheneUpdate();
                }),
            body: Padding(
              padding: EdgeInsets.all(10.0),
              child: Form(
                key: formkey,
                child: SizedBox(
                  height:
                      size.height - defaultAppBar().preferredSize.height * 2.5,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          if (state is LodinUpdateUserNoteState)
                            const Column(
                              children: [
                                LinearProgressIndicator(),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          Center(
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      HomeCubit.get(context).imageCompress !=
                                              null
                                          ? Image.file(HomeCubit.get(context)
                                                  .imageCompress!)
                                              .image
                                          : NetworkImage(HomeCubit.get(context)
                                              .etudiantModel!
                                              .data!
                                              .image!),
                                  radius: 60,
                                ),
                                IconButton(
                                  splashRadius: double.minPositive,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text(
                                                  "Choose the source :"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () async {
                                                      if (state
                                                          is LodinUpdateUserNoteState) {
                                                        return;
                                                      }
                                                      await HomeCubit.get(
                                                              context)
                                                          .imagePickerProfile(
                                                              ImageSource
                                                                  .camera)
                                                          .then((value) {
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child:
                                                        const Text("Camera")),
                                                TextButton(
                                                    onPressed: () async {
                                                      if (state
                                                          is LodinUpdateUserNoteState) {
                                                        return;
                                                      }
                                                      await HomeCubit.get(
                                                              context)
                                                          .imagePickerProfile(
                                                              ImageSource
                                                                  .gallery)
                                                          .then((value) {
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child:
                                                        const Text("Gallery"))
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
                              label: 'Email',
                              prefixIcon: const Icon(Icons.email),
                              type: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email Must Be Not Empty";
                                }
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  HomeCubit.get(context).mathchangeVisibility();
                                },
                                child: const Text(
                                  'Math ',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                ),
                              ),
                              const Spacer(),
                              Visibility(
                                visible: HomeCubit.get(context).mathVisibility,
                                child: TextButton(
                                  onPressed: () {
                                    HomeCubit.get(context)
                                        .updateEtudiantNote(
                                            module: '/math',
                                            id: HomeCubit.get(context)
                                                .etudiantModel!
                                                .data!
                                                .id!,
                                            intero: _imathController.text,
                                            controle: _cmathController.text)
                                        .then((value) {
                                      HomeCubit.get(context)
                                          .mathchangeVisibility();
                                    });
                                  },
                                  child: const Text(
                                    'update',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: HomeCubit.get(context).mathVisibility,
                            child: Row(
                              children: [
                                Expanded(
                                  child: defaultForm(
                                      controller: _imathController,
                                      textInputAction: TextInputAction.next,
                                      label: 'Intero',
                                      prefixIcon:
                                          const Icon(Icons.calculate_outlined),
                                      type: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Note Must Be Not Empty";
                                        }
                                      }),
                                ),
                                Expanded(
                                  child: defaultForm(
                                      controller: _cmathController,
                                      textInputAction: TextInputAction.next,
                                      label: 'Controle',
                                      prefixIcon:
                                          const Icon(Icons.calculate_outlined),
                                      type: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Note Must Be Not Empty";
                                        }
                                      }),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  HomeCubit.get(context).algochangeVisibility();
                                },
                                child: const Text(
                                  'Algo ',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                ),
                              ),
                              Spacer(),
                              Visibility(
                                visible: HomeCubit.get(context).algoVisibility,
                                child: TextButton(
                                    onPressed: () {
                                      HomeCubit.get(context)
                                          .updateEtudiantNote(
                                              module: '/algo',
                                              id: HomeCubit.get(context)
                                                  .etudiantModel!
                                                  .data!
                                                  .id!,
                                              intero: _ialgoController.text,
                                              controle: _calgoController.text)
                                          .then((value) {
                                        HomeCubit.get(context)
                                            .algochangeVisibility();
                                      });
                                    },
                                    child: const Text('update',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue))),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: HomeCubit.get(context).algoVisibility,
                            child: Row(
                              children: [
                                Expanded(
                                  child: defaultForm(
                                      controller: _ialgoController,
                                      textInputAction: TextInputAction.next,
                                      label: 'Intero',
                                      prefixIcon:
                                          const Icon(Icons.calculate_outlined),
                                      type: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Note Must Be Not Empty";
                                        }
                                      }),
                                ),
                                Expanded(
                                  child: defaultForm(
                                      controller: _calgoController,
                                      textInputAction: TextInputAction.next,
                                      label: 'Controle',
                                      prefixIcon:
                                          const Icon(Icons.calculate_outlined),
                                      type: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Note Must Be Not Empty";
                                        }
                                      }),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  HomeCubit.get(context)
                                      .physiquechangeVisibility();
                                },
                                child: const Text(
                                  'Physique ',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54),
                                ),
                              ),
                              Spacer(),
                              Visibility(
                                visible:
                                    HomeCubit.get(context).physiqueVisibility,
                                child: TextButton(
                                    onPressed: () {
                                      HomeCubit.get(context)
                                          .updateEtudiantNote(
                                              module: '/physique',
                                              id: HomeCubit.get(context)
                                                  .etudiantModel!
                                                  .data!
                                                  .id!,
                                              intero: _iphysiqueController.text,
                                              controle:
                                                  _cphysiqueController.text)
                                          .then((value) {
                                        HomeCubit.get(context)
                                            .mathchangeVisibility();
                                      });
                                    },
                                    child: const Text('update',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue))),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: HomeCubit.get(context).physiqueVisibility,
                            child: Row(
                              children: [
                                Expanded(
                                  child: defaultForm(
                                      controller: _iphysiqueController,
                                      textInputAction: TextInputAction.next,
                                      label: 'Intero',
                                      prefixIcon:
                                          const Icon(Icons.calculate_outlined),
                                      type: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Note Must Be Not Empty";
                                        }
                                      }),
                                ),
                                Expanded(
                                  child: defaultForm(
                                      controller: _cphysiqueController,
                                      textInputAction: TextInputAction.next,
                                      label: 'Controle',
                                      prefixIcon:
                                          const Icon(Icons.calculate_outlined),
                                      type: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Note Must Be Not Empty";
                                        }
                                      }),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: defaultSubmit2(
                                text: 'Update info',
                                background: Colors.grey,
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    if (state is LodinUpdateUserNoteState) {
                                      return null;
                                    }
                                    HomeCubit.get(context)
                                        .updateEtudiantResponsable(
                                            email: _emailController.text,
                                            name: _nameController.text,
                                            id: HomeCubit.get(context)
                                                .etudiantModel!
                                                .data!
                                                .id!);
                                  }
                                }),
                          ),
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
