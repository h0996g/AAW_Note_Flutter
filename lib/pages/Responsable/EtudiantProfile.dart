import 'package:affichage/pages/Responsable/EditeEtudiantProfile.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/userModel.dart';
import '../../shared/components/components.dart';
import '../HomeResponsable/HomeResponsable.dart';
import '../HomeResponsable/cubit/home_cubit.dart';

class EtudiantProfile extends StatefulWidget {
  final UserModel model;
  EtudiantProfile({required this.model});

  @override
  State<EtudiantProfile> createState() => _EtudiantProfileState();
}

class _EtudiantProfileState extends State<EtudiantProfile> {
  List<Map<String, dynamic>>? data;
  @override
  void initState() {
    // TODO: implement initState
    HomeCubit.get(context)
        .getEtudiantDetail(id: widget.model.id.toString())
        .then((value) {
      data = [
        {
          'module': 'math',
          'note': HomeCubit.get(context).etudiantModel!.math.toString()
        },
        {
          'module': 'Algo',
          'note': HomeCubit.get(context).etudiantModel!.algo.toString()
        },
        {
          'module': 'physique',
          'note': HomeCubit.get(context).etudiantModel!.physique.toString()
        },
        {
          'module': 'moy',
          'note': HomeCubit.get(context).etudiantModel!.moy.toString()
        },
      ];
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(model.id);
    Size size = MediaQuery.of(context).size;
    return (BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is DeleteEtudiantStateGood) {
          showToast(msg: 'Deleted Successfully', state: ToastStates.success);

          navigatAndFinish(context: context, page: HomeResponsable());
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.canPop(context)
                ? Navigator.pop(context)
                : navigatAndFinish(
                    context: context, page: const HomeResponsable());
            return true;
          },
          child: Scaffold(
              appBar: defaultAppBar(
                  title: const Text('Profile'),
                  canreturn: true,
                  onPressed: () {
                    Navigator.canPop(context)
                        ? Navigator.pop(context)
                        : navigatAndFinish(
                            context: context, page: const HomeResponsable());

                    HomeCubit.get(context).resetValueWheneSeeDetailEtudiant();
                    // navigatAndFinish(context: context, page: Users());
                  }),
              body: SingleChildScrollView(
                child: Center(
                  child: ConditionalBuilder(
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: size.height -
                            defaultAppBar().preferredSize.height * 2.5,
                        // padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 80.0,
                              backgroundImage: NetworkImage(
                                  HomeCubit.get(context)
                                      .etudiantModel!
                                      .data!
                                      .image!),
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              HomeCubit.get(context).etudiantModel!.data!.name!,
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
                              subtitle: Text(HomeCubit.get(context)
                                  .etudiantModel!
                                  .data!
                                  .email!),
                              // onTap: () {},
                            ),
                            ListTile(
                              leading: const Icon(Icons.phone),
                              title: const Text('Phone'),
                              subtitle: Text(HomeCubit.get(context)
                                  .etudiantModel!
                                  .data!
                                  .phone!),
                              // onTap: () {},
                            ),
                            const SizedBox(height: 8.0),
                            Flexible(
                              child: DataTable(
                                border: TableBorder.all(),
                                columns: const [
                                  DataColumn(label: Text('Module')),
                                  DataColumn(label: Text('note')),
                                ],
                                rows: data!
                                    .map((item) => DataRow(cells: [
                                          DataCell(Text(item['module'])),
                                          DataCell(
                                              Text(item['note'].toString())),
                                        ]))
                                    .toList(),
                              ),
                            ),

                            SizedBox(
                              height: size.height * 0.1,
                            ),

                            ElevatedButton(
                              onPressed: () {
                                navigatAndReturn(
                                    context: context,
                                    page: EditeEtudiantProfile());
                              },
                              child: const Text('Edit Profile'),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextButton(
                                onPressed: () async {
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
                                                    HomeCubit.get(context)
                                                        .deleteEtudiant(
                                                            id: HomeCubit.get(
                                                                    context)
                                                                .etudiantModel!
                                                                .data!
                                                                .id!);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ))
                                            ],
                                          ));
                                },
                                child: const Text(
                                  "Delete Account ",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    condition:
                        state is! LodinGetUserDetailState && data != null,
                    fallback: (BuildContext context) {
                      return SizedBox(
                          height: size.height -
                              defaultAppBar().preferredSize.height * 2,
                          width: size.width,
                          child:
                              const Center(child: CircularProgressIndicator()));
                    },
                  ),
                ),
              )),
        );
      },
    ));
  }
}
