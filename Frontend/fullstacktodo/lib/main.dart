import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstacktodo/Modules/Authentication/View/AuthPage.dart';
import 'package:fullstacktodo/Modules/Authentication/data/repo/authRepo.dart';
import 'package:fullstacktodo/Modules/Authentication/model_View/Bloc/bloc/auth_bloc.dart';
import 'package:fullstacktodo/Modules/Authentication/model_View/Services/AuthenticatedClientService.dart';
import 'package:fullstacktodo/Modules/Home/data/repo/todoRepo.dart';
import 'package:fullstacktodo/Modules/Home/model_View/bloc/todo_bloc.dart';

void main() => runApp(
  DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Todorepo repo = Todorepo();
    Authrepo authrepo = Authrepo();
    AuthenticatedClientService authenticatedClientService =
        AuthenticatedClientService();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthBloc(authrepo, authenticatedClientService)
                ..add(AuthAppStarted()),
        ),
        BlocProvider<TodoBloc>(
          create: (context) {
            final authBloc = context.read<AuthBloc>();
            return TodoBloc(repo, authBloc)..add(LoadTodoEvent());
          },
        ),
      ],

      child: MaterialApp(
        title: 'Flutter Demo',
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: Authpage(),
      ),
    );
  }
}
