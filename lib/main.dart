import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_auth/logic/blocs/auth/auth_bloc.dart';
import 'package:test_task_auth/tools/app_router.dart';

void main() {
  final AppRouter appRouter = AppRouter();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MainApp(appRouter: appRouter),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.appRouter,
  });

  final AppRouter appRouter;

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter();

    return CupertinoApp.router(
      title: 'Flutter Demo',
      theme: const CupertinoThemeData(
        primaryColor: Color.fromRGBO(70, 49, 210, 1.0),
      ),
      routerConfig: appRouter.config(),
      builder: (BuildContext context, Widget? widget) {
        return widget ?? const CircularProgressIndicator();
      },
    );
  }
}
