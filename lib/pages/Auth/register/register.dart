import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../Home/cubit/home_cubit.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/helper/cashHelper.dart';
import 'cubit/register_cubit.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<RegisterCubit, RegisterState>(
      builder: (BuildContext context, state) {
        RegisterCubit _RegisterCubit = BlocProvider.of(context);

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
                        height: size.height * 0.2,
                      ),
                      const Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultForm(
                          type: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          label: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email Must Be Not Empty";
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultForm(
                          controller: nameController,
                          type: TextInputType.text,
                          label: 'Name',
                          textInputAction: TextInputAction.next,
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
                          textInputAction: TextInputAction.next,
                          label: "Phone",
                          controller: phoneController,
                          type: TextInputType.phone,
                          prefixIcon: const Icon(Icons.phone),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Phone Must Be Not Empty";
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultForm(
                          suffixIcon: IconButton(
                              onPressed: () {
                                _RegisterCubit.showPassword();
                              },
                              icon: _RegisterCubit.isvisibility
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility)),
                          controller: passwordController,
                          textInputAction: TextInputAction.done,
                          prefixIcon: const Icon(Icons.password),
                          obscureText: !_RegisterCubit.isvisibility,
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
                          const Text('Have an account'),
                          const SizedBox(
                            width: 5,
                          ),
                          TextButton(
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const Spacer(),
                          ConditionalBuilder(
                            builder: (BuildContext context) {
                              return defaultSubmit1(
                                  formKey: formKey,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      // RegisterCubit.get(context).registerUser(
                                      //     name: nameController.text,
                                      //     email: emailController.text,
                                      //     phone: phoneController.text,
                                      //     password: passwordController.text);
                                    }
                                  });
                            },
                            condition: state is! LodinRegisterUserState,
                            fallback: (BuildContext context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ],
                      )
                    ]),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        // if (state is RegisterUserStateGood) {
        //   showToast(msg: "Succesffuly Registered", state: ToastStates.success);
        //   // sleep(const Duration(seconds: 1));
        //   CachHelper.putcache(key: 'token', value: state.token)
        //       .then((value) async {
        //     TOKEN = await CachHelper.getData(key: 'token');
        //     DECODEDTOKEN = JwtDecoder.decode(state.token);
        //     HomeCubit.get(context).getCurrentUserInfo();
        //     HomeCubit.get(context).getOtherUsers();
        //     navigatAndFinish(context: context, page: const Home());
        //   });
        // } else if (state is RegisterUserStateBad) {
        //   showToast(msg: 'Something Went Wrong', state: ToastStates.error);
        // }
      },
    );
  }
}
