import 'package:affichage/pages/Auth/login/cubit/login_cubit.dart';
import 'package:affichage/pages/Auth/login/login.dart';
import 'package:affichage/pages/Auth/register/cubit/register_cubit.dart';
import 'package:affichage/pages/Home/cubit/home_cubit.dart';
import 'package:affichage/shared/blocObserver/observer.dart';
import 'package:affichage/shared/helper/cashHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dio/dioHalper.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => RegisterCubit())),
        BlocProvider(create: ((context) => LoginCubit())),
        BlocProvider(create: ((context) => HomeCubit()..getEtudiants())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Login(),
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              titleSpacing: 20,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark),
              backgroundColor: Colors.white,
              // shadowColor: Colors.white,
              elevation: 0),
          scaffoldBackgroundColor: Colors.white,
        ),
      ),
    );
  }
}
