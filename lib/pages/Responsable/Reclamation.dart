import 'package:affichage/models/reclamationModel.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../HomeResponsable/cubit/home_cubit.dart';
import 'ReclamationDetail.dart';

class Reclamation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          builder: (BuildContext context) {
            return Scaffold(
              body: RefreshIndicator(
                edgeOffset: 0,
                onRefresh: () {
                  HomeCubit.get(context).getAllReclamation();
                  return Future.delayed(const Duration(seconds: 3));
                },
                child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    itemBuilder: (context, index) => defaultReclamation(
                        context,
                        HomeCubit.get(context).reclamationModelList![index],
                        index),
                    itemCount:
                        HomeCubit.get(context).reclamationModelList!.length),
              ),
            );
          },
          condition: HomeCubit.get(context).reclamationModelList != null &&
              state is! LodinGetAllReclamationState,
          fallback: (BuildContext context) {
            return const Scaffold(
              // drawer: Drawer(),

              body: Center(child: CircularProgressIndicator()),
            );
          },
        );
      },
      listener: (BuildContext context, Object? state) {},
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
                            HomeCubit.get(context).deleteReclamation(
                                id: HomeCubit.get(context)
                                    .reclamationModelList![index]
                                    .id!);
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
