import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_auth/constants/paddings.dart';
import 'package:test_task_auth/constants/strings.dart';
import 'package:test_task_auth/logic/blocs/auth/auth_bloc.dart';
import 'package:test_task_auth/logic/model/user_model.dart';
import 'package:test_task_auth/tools/app_router.gr.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(Strings.profilePage),
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          User? user;
          if (state is! AuthComplete) {
            AutoRouter.of(context).replace(const AuthRoute());
            return const Center(child: CircularProgressIndicator());
          } else {
            user = state.user;
          }
          return SafeArea(
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Container(
                      margin: Paddings.defaultNotBottom,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 32,
                        child: Image.asset('assets/icons/default_avatar.png'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        user!.nickname,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                      margin: Paddings.defaultOnlyVertical,
                      width: MediaQuery.of(context).size.width,
                      child: CupertinoButton(
                        onPressed: () {
                          authBloc.add(AuthLogout());
                        },
                        alignment: Alignment.centerLeft,
                        padding: Paddings.defaultOnlyHorizontal,
                        // color: Colors.red,
                        child: const Text(
                          Strings.logout,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
