
import 'dart:developer';


import 'package:cinema_mobile/src/bloc/signup_bloc.dart';

import 'package:cinema_mobile/src/core/connection/login_connection.dart';
import 'package:cinema_mobile/src/custom/progress_hud.dart';

import 'package:cinema_mobile/src/screens/login_screen.dart';
import 'package:cinema_mobile/src/util/dialog_util.dart';

import 'package:flutter/material.dart';

class ForgetClientPage extends StatefulWidget {
  const ForgetClientPage({Key? key}) : super(key: key);

  @override
  State<ForgetClientPage> createState() => _ForgetClientPageState();
}

class _ForgetClientPageState extends State<ForgetClientPage> {
  late ProgressHUD2 loading;
  bool isClientCreated = false;
  final LoginConnector loginConnector = LoginConnector();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    loading = initializeLoading('Registrando Usuario...');
  }



  final email = TextEditingController();

  final SignUpBloc _signUpBloc = SignUpBloc();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Stack(children: [
        Container(
          color: Theme.of(context).primaryColorDark,
          height: size * 0.4,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 35.0, right: 35.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text("Recuperar Contraseña",
                    style: Theme.of(context).textTheme.headline4!.apply(
                        color: Theme.of(context).scaffoldBackgroundColor)),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).hintColor, width: 2.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder<String>(
                          stream: _signUpBloc.emailStream,
                          builder: (context, snapshot) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                        width: 1.0,
                                        color:
                                            Theme.of(context).highlightColor)),
                                child: TextField(
                                    controller: email,
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: _signUpBloc.changeEmail,
                                    decoration: InputDecoration(
                                        errorText: snapshot.error?.toString(),
                                        icon: const Icon(Icons.email),
                                        labelText: "Correo electrónico",
                                        hintText: "usuario@cinema.com")),
                              ),
                            );
                          }),
                      Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: StreamBuilder<bool>(
                            stream: _signUpBloc.formEmailSignUpStream,
                            builder: (context, snapshot) {
                              return ElevatedButton.icon(
                                  onPressed: snapshot.hasData ? () async {
                                    try {
                                      await onClickSendNewPassword(context);
                          
                                      setState(() {});
                                    } catch (e) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  "Error: Al Registrar al Usuario ${e.toString()} "),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(Colors
                                                                        .black87)),
                                                        child: const Text(
                                                          'Regresar',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    const ForgetClientPage()),
                                                          );
                                                        }),
                                                  ],
                                                )
                                              ],
                                            );
                                          });
                                    }
                                  } : null,
                                  icon: const Icon(Icons.account_box),
                                  label: const Text("Recuperar"));
                            }
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ])),
    ));
  }

  onClickSendNewPassword(BuildContext contex) {
    loginConnector.resetPasswort(email.text).then((value) async {
      showAlert(context, value.response);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false);
    }).catchError((e) {
      log(e.toString());
      showAlert(context, e.toString());
    }).whenComplete(() {
      log('complete');

      setState(() => isLoading = false);
    });
  }

  void showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('The Big Screen'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
