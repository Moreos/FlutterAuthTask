import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_auth/logic/blocs/auth/auth_bloc.dart';
import 'package:test_task_auth/tools/app_router.gr.dart';

@RoutePage()
class LoadScreen extends StatelessWidget {
  const LoadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthComplete) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            AutoRouter.of(context).replace(const MainRoute());
          });
          return const LoadIndicator();
        } else {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            AutoRouter.of(context).replace(const AuthRoute());
          });
          return const LoadIndicator();
        }
      },
    ),);
  }
}

class LoadIndicator extends StatelessWidget {
  const LoadIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

