import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_auth/constants/paddings.dart';
import 'package:test_task_auth/constants/strings.dart';
import 'package:test_task_auth/logic/blocs/auth/auth_bloc.dart';
import 'package:test_task_auth/tools/app_router.gr.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingControllerEmail = TextEditingController();
    TextEditingController textEditingControllerPass = TextEditingController();

    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(Strings.authPage),
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthComplete) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              AutoRouter.of(context).replace(const MainRoute());
            });
          }
          if (state is AuthFailed) {
            textEditingControllerPass = TextEditingController();
          }
          return SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state is AuthFailed)
                    Text(
                      'Введены некорректные данные',
                      style: TextStyle(color: Colors.red),
                    ),
                  Container(
                    margin: Paddings.defaultPadding,
                    child: Column(
                      children: [
                        TextFieldWidget(
                          textEditingController: textEditingControllerEmail,
                          textHint: Strings.loginOrEmail,
                        ),
                        const Divider(
                          color: CupertinoDynamicColor.withBrightness(
                            color: Color(0x33000000),
                            darkColor: Color(0x33FFFFFF),
                          ),
                          thickness: 1,
                        ),
                        TextFieldWidget(
                          textEditingController: textEditingControllerPass,
                          textHint: Strings.password,
                          isPassword: true,
                        ),
                      ],
                    ),
                  ),
                  (state is AuthSendResponse)
                      ? const CircularProgressIndicator()
                      : ButtonWidget(
                          onTap: () {
                            authBloc.add(
                              AuthSendData(
                                email: textEditingControllerEmail.text,
                                password: textEditingControllerPass.text,
                              ),
                            );
                          },
                          text: Strings.login),
                  ButtonWidget(
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) => CupertinoActionSheet(
                            message: const Text('В данный момент эта опция не доступна'),
                            actions: <CupertinoActionSheetAction>[
                              CupertinoActionSheetAction(
                                isDefaultAction: true,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Понятно'),
                              ),
                            ],
                          ),
                        );
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //     content: Text('В данный момент не доступно!')));
                      },
                      text: Strings.registration),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    required this.textEditingController,
    required this.textHint,
    this.isPassword = false,
    super.key,
  });

  final TextEditingController textEditingController;
  final String textHint;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Paddings.defaultOnlyVertical,
      child: CupertinoTextField(
        controller: textEditingController,
        obscureText: isPassword,
        padding: EdgeInsets.zero,
        decoration: null,
        placeholder: textHint,
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, this.onTap, required this.text});

  final Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Paddings.defaultNotBottom,
      width: MediaQuery.of(context).size.width,
      child: CupertinoButton(
        padding: Paddings.defaultButtonPadding,
        color: CupertinoTheme.of(context).primaryColor,
        onPressed: onTap,
        child: Text(text),
      ),
    );
  }
}
