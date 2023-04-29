import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/home_cubit.dart';

// import '../Home/cubit/home_cubit.dart';

class HomeResponsable extends StatelessWidget {
  const HomeResponsable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit _homeCubit = BlocProvider.of(context);
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          // floatingActionButton: FloatingActionButton(onPressed: () {
          //   CachHelper.removdata(key: "token");
          //   navigatAndFinish(context: context, page: Login());
          // }),

          bottomNavigationBar: BottomNavigationBar(
            // type: BottomNavigationBarType.fixed,
            onTap: (index) {
              _homeCubit.changeButtonNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                label: 'Reclamations',
                icon: Icon(Icons.error),
              ),
              BottomNavigationBarItem(
                label: 'Etudients',
                icon: Icon(Icons.people),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.person),
              ),
            ],
            currentIndex: _homeCubit.currentIndex,
          ),
          // floatingActionButton: FloatingActionButton(onPressed: () {
          //   CachHelper.removdata(key: "token").then((value) {
          //     // _homeCubit.resetWhenLogout();
          //     navigatAndFinish(context: context, page: Login());
          //     HomeCubit.get(context).resetValueWhenelogout();
          //   });
          // }),
          appBar: AppBar(
            title: Text(_homeCubit.appbarScreen[_homeCubit.currentIndex]),
          ),
          body: ConditionalBuilder(
            builder: (BuildContext context) {
              return _homeCubit.userScreen[_homeCubit.currentIndex];
            },
            condition:
                //  HomeCubit.get(context).userModel != null &&
                HomeCubit.get(context).etudiantModelList != null,
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
