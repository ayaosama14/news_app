import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/features/presentation/views/other_screens/login_screen.dart';
import 'package:news_app/features/presentation/views/other_screens/phone_screen.dart';
import '../../manager/auth/signup/signup_cubit.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class signupView extends StatefulWidget {
  const signupView({super.key});

  @override
  State<signupView> createState() => _signupViewState();
}

class _signupViewState extends State<signupView> {
  final _formKey = GlobalKey<FormState>();
  final _signupCubit = signupCubit();

  TextEditingController? fullNameController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? rePasswordController = TextEditingController();
  bool visiblePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(children: [
                  Text(
                    "Sign Up",
                    style: GoogleFonts.lobster(
                      fontWeight: FontWeight.bold,
                      fontSize: 54,
                      color: const Color.fromARGB(255, 7, 48, 214),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultTextFormField(
                    controller: fullNameController,
                    lText: 'Full Name',
                    prefixIconName: Icons.person,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultTextFormField(
                    controller: emailController,
                    lText: 'Email',
                    prefixIconName: Icons.email_rounded,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultTextFormField(
                    controller: passwordController,
                    lText: 'Enter your Password',
                    obscureText: !visiblePassword,
                    prefixIconName: Icons.lock_outline_rounded,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultTextFormField(
                    controller: rePasswordController,
                    lText: 'ReEnter your Password',
                    obscureText: !visiblePassword,
                    prefixIconName: Icons.lock_outline_rounded,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginView(),
                      ),
                    ),
                    child: const Text(
                      'Already Have an Account! Sign in ',
                      style: TextStyle(
                        color: Colors.grey, fontSize: 14,
                        // decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<signupCubit, signupState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is signupLoadingState) {
                        return const CircularProgressIndicator();
                      }
                      return CustomButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _signupCubit.userRegister(
                              fullName: fullNameController!.text.trim(),
                              email: emailController!.text.trim(),
                              password: passwordController!.text.trim(),
                              // phone: phoneController!.text.trim(),
                            );
                            // _signupCubit.phoneAuthentication(
                            //     phoneController!.text.trim());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PhoneScreen(),
                              ),
                            );
                          }
                        },
                        text: 'Register',
                      );
                    },
                  ),
                ]),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
