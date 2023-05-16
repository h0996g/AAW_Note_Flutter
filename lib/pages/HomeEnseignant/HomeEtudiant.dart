import 'package:affichage/pages/HomeEtudiant/cubit/etudiant_cubit.dart';
import 'package:affichage/pages/HomeEtudiant/cubit/etudiant_state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/helper/cashHelper.dart';
import '../Auth/login/login.dart';

class HomeEtudiant extends StatelessWidget {
  const HomeEtudiant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EtudiantCubit _etudiantCubit = BlocProvider.of(context);
    return BlocConsumer<EtudiantCubit, EtudiantState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              _etudiantCubit.changeButtonNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                label: 'Affichage',
                icon: Icon(Icons.line_style_outlined),
              ),
              BottomNavigationBarItem(
                label: 'AddReclamation',
                icon: Icon(Icons.add),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.person),
              ),
            ],
            currentIndex: _etudiantCubit.currentIndex,
          ),
          // floatingActionButton: FloatingActionButton(onPressed: () {
          //   CachHelper.removdata(key: "token").then((value) {
          //     // _homeCubit.resetWhenLogout();
          //     navigatAndFinish(context: context, page: Login());
          //     HomeCubit.get(context).resetValueWhenelogout();
          //   });
          // }),
          appBar: AppBar(
            title:
                Text(_etudiantCubit.appbarScreen[_etudiantCubit.currentIndex]),
          ),
          body: ConditionalBuilder(
            builder: (BuildContext context) {
              return _etudiantCubit.userScreen[_etudiantCubit.currentIndex];
            },
            condition: EtudiantCubit.get(context).etudiantModel != null,
            //  &&
            // HomeCubit.get(context).etudiantModelList != null,
            fallback: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        // if (state is ChangeButtonNavStateToAddPostsGood) {
        //   navigatAndReturn(context: context, page: const AddPost());
        // }
      },
    );
  }
}
