import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstacktodo/Modules/Authentication/model_View/Bloc/bloc/auth_bloc.dart';
import 'package:fullstacktodo/Modules/Home/model_View/bloc/todo_bloc.dart';
import 'package:fullstacktodo/Modules/Home/view/Pages/Hompage.dart';

Widget authPage(bool isLogin, VoidCallback onPressed, BuildContext context) {
  final String emailRegex = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
  final String passwordRegex = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  return Form(
    key: formkey,
    child: Column(
      children: [
        const SizedBox(height: 20),
        Center(
          child: isLogin
              ? Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                  ),
                )
              : Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                  ),
                ),
        ),
        const SizedBox(height: 22),
        isLogin
            ? Text("Sign In to enjoy Best Todo Expreience:)")
            : Text("Create a account for better Service"),

        const SizedBox(height: 25),
        if (!isLogin)
          customTitleAndTextFiled(
            "Name",
            "Ritek Abhishek Pillai",
            Icons.person,
            (value) {
              if (value!.isEmpty) {
                return "User Name can not be empty";
              }
              return null;
            },
            nameController,
          ),

        const SizedBox(height: 15),
        customTitleAndTextFiled(
          "Email",
          "example@gmail.com",
          Icons.email_outlined,
          (value) {
            if (value!.isEmpty) {
              return "Email Can Not Be Empty";
            } else if (!RegExp(emailRegex).hasMatch(value)) {
              return "Email Should Be Vaild";
            }
            return null;
          },
          EmailController,
        ),
        const SizedBox(height: 15),
        customTitleAndTextFiled("Password", "password", Icons.lock, (value) {
          if (value!.isEmpty) {
            return "Password Can not be Empty";
          } else if (!RegExp(passwordRegex).hasMatch(value)) {
            return 'Password must be at least 8 characters, with an uppercase letter and a number.';
          }
          return null;
        }, PasswordController),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSignUpSucess) {
                onPressed();
              }
              if (state is Authauthenticated) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Hompage()),
                );
                //     context.read<TodoBloc>().add(LoadTodoEvent());
              }
              if (state is AuthUnauthenticated) {
                final String errorMessage = state.authException.errorMessage;
                debugPrint("Error Got:$errorMessage");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: $errorMessage'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(350, 50),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    !isLogin
                        ? BlocProvider.of<AuthBloc>(context).add(
                            AuthAppSignUpRequest(
                              username: nameController.text,
                              email: EmailController.text,
                              password: PasswordController.text,
                            ),
                          )
                        : BlocProvider.of<AuthBloc>(context).add(
                            AuthAppLoginRequest(
                              username: nameController.text,
                              email: EmailController.text,
                              password: PasswordController.text,
                            ),
                          );
                  } else {
                    print('Validation Failed!');
                  }
                },
                child: Text(
                  !isLogin ? "Sign Up" : "Login",
                  style: TextStyle(color: Colors.amber),
                ),
              );
            },
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              isLogin ? "Don't Have an account?" : "Already have an account",
              style: TextStyle(color: Colors.black),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                isLogin ? "Sign Up" : "Sign in",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget customTitleAndTextFiled(
  String title,
  String hintext,
  IconData icon,
  String? Function(String?)? validator,
  TextEditingController controller,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),

      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          controller: controller,

          validator: validator,
          obscureText: title == "Password" ? true : false,
          decoration: InputDecoration(
            errorMaxLines: 2,
            prefixIcon: Icon(icon, color: Colors.grey),
            hintText: "| $hintext",

            contentPadding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 20.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey, width: 0.1),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey, width: 0.9),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    ],
  );
}
