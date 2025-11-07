import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstacktodo/Modules/Authentication/View/Auth_Pages/Login_Signup.dart';
import 'package:fullstacktodo/Modules/Authentication/model_View/Bloc/bloc/auth_bloc.dart';

class Authpage extends StatefulWidget {
  const Authpage({super.key});

  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.topRight,
          begin: Alignment.bottomRight,
          colors: [
            Colors.lightBlue.shade900,
            Colors.lightBlue.shade400,
            Colors.lightBlue.shade100,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 200),
                Center(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 900),

                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,

                        /// Colors.white.withAlpha(220),
                      ),
                      child: authPage(isLogin, () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      }, context),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
