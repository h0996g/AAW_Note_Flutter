import 'package:affichage/pages/Auth/login/cubit/login_cubit.dart';
import 'package:affichage/pages/Auth/login/login.dart';
import 'package:affichage/pages/HomeEtudiant/HomeEtudiant.dart';
import 'package:affichage/pages/HomeEtudiant/cubit/etudiant_cubit.dart';
import 'package:affichage/pages/HomeResponsable/HomeResponsable.dart';
import 'package:affichage/pages/HomeResponsable/cubit/home_cubit.dart';
import 'package:affichage/pages/Responsable/cubit/register_cubit.dart';

import 'package:affichage/shared/blocObserver/observer.dart';
import 'package:affichage/shared/components/constants.dart';
import 'package:affichage/shared/helper/cashHelper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dio/dioHalper.dart';
import 'firebase_options.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DioHelper.init();
  Widget startWidget;
  TOKEN = await CachHelper.getData(key: 'token') ?? '';
  LOGINTYPE = await CachHelper.getData(key: 'loginType') ?? '';
  // CachHelper.removdata(key: "token");
  if (TOKEN != '') {
    DECODEDTOKEN = JwtDecoder.decode(TOKEN);
    print(DECODEDTOKEN['_id']);
  }
  if (TOKEN != '') {
    if (LOGINTYPE == 'Etudiant') {
      startWidget = const HomeEtudiant();
    } else if (LOGINTYPE == 'Responsable') {
      startWidget = const HomeResponsable();
    } else {
      startWidget = Login();
    }
  } else {
    startWidget = Login();
  }
  runApp(MyApp(
    startwidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;

  const MyApp({super.key, required this.startwidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => RegisterCubit())),
        BlocProvider(
            lazy: false,
            create: ((context) => EtudiantCubit()
              ..getCurrentEtudiantInfo()
              ..getAllReclamationById())),
        BlocProvider(create: ((context) => LoginCubit())),
        BlocProvider(
            lazy: false,
            create: ((context) => HomeCubit()
              ..getAllReclamation()
              ..getCurrentResponsableInfo()
              ..getEtudiants())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: startwidget,
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
