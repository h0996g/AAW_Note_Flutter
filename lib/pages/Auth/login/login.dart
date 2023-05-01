import 'package:affichage/pages/HomeEtudiant/HomeEtudiant.dart';
import 'package:affichage/pages/HomeEtudiant/cubit/etudiant_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../shared/components/components.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/helper/cashHelper.dart';
import '../../HomeResponsable/HomeResponsable.dart';
import '../../HomeResponsable/cubit/home_cubit.dart';
import '../register/register.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (BuildContext context, state) {
        LoginCubit _loginCubit = BlocProvider.of(context);

        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.16,
                    ),
                    const Text(
                      'Select One :',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildButton(0, context),
                          const SizedBox(width: 5),
                          _buildButton(1, context),
                          const SizedBox(width: 5),
                          _buildButton(2, context),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    defaultForm(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        label: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email Must Be Not Empty";
                          }
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultForm(
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {}
                        },
                        suffixIcon: IconButton(
                            onPressed: () {
                              _loginCubit.showPassword();
                            },
                            icon: _loginCubit.isvisibility
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                        controller: passwordController,
                        textInputAction: TextInputAction.none,
                        prefixIcon: const Icon(Icons.password),
                        obscureText: !_loginCubit.isvisibility,
                        label: "Password",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password Must Be Not Empty";
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              // navigatAndReturn(
                              //     context: context, page: ForgetPassword());
                            },
                            child: const Text('forget password ?')),
                        const Spacer(),
                        ConditionalBuilder(
                          builder: (BuildContext context) {
                            return defaultSubmit1(
                                formKey: formKey,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    print('dfdf');
                                    LoginCubit.get(context).loginUser(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                });
                          },
                          condition: state is! LodinLoginUserState,
                          fallback: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is LoginResponsableStateGood) {
          showToast(msg: "Logged in Successfully", state: ToastStates.success);
          // sleep(const Duration(seconds: 1));
          CachHelper.putcache(key: "token", value: state.token)
              .then((value) async {
            await CachHelper.putcache(
                key: "loginType", value: LoginCubit.get(context).pathLogin);
            // print(LoginCubit.get(context).pathLogin);
            print(value.toString());
            TOKEN = CachHelper.getData(key: 'token');
            DECODEDTOKEN = JwtDecoder.decode(state.token);
            print(DECODEDTOKEN['_id']);
            HomeCubit.get(context).getCurrentResponsableInfo();
            HomeCubit.get(context).getEtudiants();
            HomeCubit.get(context).getAllReclamation();
          });
          navigatAndFinish(context: context, page: const HomeResponsable());
        } else if (state is LoginResponsableStateBad) {
          showToast(msg: 'Something Went Wrong', state: ToastStates.error);
        } else if (state is LoginEtudiantStateGood) {
          showToast(msg: "Logged in Successfully", state: ToastStates.success);
          // sleep(const Duration(seconds: 1));
          CachHelper.putcache(key: "token", value: state.token)
              .then((value) async {
            await CachHelper.putcache(
                key: "loginType", value: LoginCubit.get(context).pathLogin);
            print(value.toString());
            TOKEN = CachHelper.getData(key: 'token');
            DECODEDTOKEN = JwtDecoder.decode(state.token);
            print(DECODEDTOKEN['_id']);
            EtudiantCubit.get(context).getCurrentEtudiantInfo();
            EtudiantCubit.get(context).getAllReclamationById();
            // HomeCubit.get(context).getEtudiants();
            // HomeCubit.get(context).getAllReclamation();
          });
          navigatAndFinish(context: context, page: const HomeEtudiant());
        } else if (state is LoginEtudientStateBad) {
          showToast(msg: 'Something Went Wrong', state: ToastStates.error);
        }
      },
    );
  }
}

Widget _buildButton(int index, context) {
  return Container(
    decoration: BoxDecoration(
      color: LoginCubit.get(context).selectedIndex == index
          ? Colors.blue
          : Colors.grey[200],
      borderRadius: BorderRadius.circular(16),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // toggle the selected button
          LoginCubit.get(context).changeTogel(index);
        },
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Text(
            index == 0
                ? 'Etudient'
                : index == 1
                    ? "Ensenient"
                    : "Encadror",
            style: TextStyle(
              color: LoginCubit.get(context).selectedIndex == index
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    ),
  );
}
