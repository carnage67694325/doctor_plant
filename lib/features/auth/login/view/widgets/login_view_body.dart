import 'dart:developer';

import 'package:doct_plant/core/utils/approuter.dart';
import 'package:doct_plant/core/utils/functions/error_snack.dart';
import 'package:doct_plant/core/utils/widgets/email_textfield.dart';
import 'package:doct_plant/core/utils/widgets/dr_plant_background.dart';
import 'package:doct_plant/core/utils/widgets/password_textfield.dart';
import 'package:doct_plant/features/auth/login/view/view_model.dart/cubit/login_cubit.dart';
import 'package:doct_plant/features/home/view/widgets/custom_elvated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DrPlantBackground(
          child: SingleChildScrollView(
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              GoRouter.of(context).push(AppRouter.kDrHub);
            } else if (state is LoginFaiulre) {
              errorSnackBar(context, state.erroMessage);
              log(state.erroMessage);
            }
          },
          builder: (context, state) {
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300.h,
                  ),
                  EmailTextField(
                    controller: _emailController,
                    hintText: 'Enter your email',
                    onChanged: (value) {
                      log('Email changed: $value');
                    },
                    labelText: "Email",
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  PasswordTextField(
                    controller: _passwordController,
                    hintText: 'Enter your password',
                    onChanged: (value) {
                      log('Password changed');
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomElvatedButton(
                    child: state is LoginLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                            ),
                          ),
                    onPressed: () async {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        await BlocProvider.of<LoginCubit>(context).login(
                            _emailController.text, _passwordController.text);
                      }
                    },
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 20.sp,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).push(AppRouter.kRegister);
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      )),
    );
  }
}
