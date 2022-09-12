import 'dart:developer';

import 'package:cinema_mobile/src/bloc/login_bloc.dart';
import 'package:cinema_mobile/src/core/connection/login_connection.dart';
import 'package:cinema_mobile/src/core/connection/preferences_manager.dart';

import 'package:cinema_mobile/src/pages/forget_client_page.dart';
import 'package:cinema_mobile/src/pages/signup_page.dart';
import 'package:cinema_mobile/src/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:cinema_mobile/src/providers/main_provider.dart';

final TextEditingController _emailController =
    TextEditingController(); //Contenido de la caja de texto
final TextEditingController _passwordController = TextEditingController();
final LoginConnector loginConnector = LoginConnector();
bool isLoading = false;
final PreferenceManager prefs = PreferenceManager();

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc bloc;
  bool _obscureText = true;
// Logeo
  bool saveAccount = true;
  @override
  void initState() {
    bloc = LoginBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const String assetName = 'assets/tbs_logo.svg';
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: NetworkImage(""), fit: BoxFit.fill)),
        height: size.height * 0.35,
      ),
      SingleChildScrollView(
          child: Center(
              child: SizedBox(
                  width: size.width * 0.9,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: SvgPicture.asset(
                            assetName,
                            allowDrawingOutsideViewBox: true,
                            cacheColorFilter: true,
                            excludeFromSemantics: true,
                          ),
                        ),
                      ),
                      SafeArea(child: Container(height: 80.h)),
                      Column(
                        children: [
                          StreamBuilder(
                              stream: bloc.emailStream,
                              builder: (BuildContext context,
                                      AsyncSnapshot snapshot) =>
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                        controller: _emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onChanged: bloc.changeEmail,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            errorText:
                                                snapshot.error?.toString(),
                                            icon: Icon(Icons.email,
                                                color: Theme.of(context)
                                                    .primaryColorDark),
                                            hintText: 'usuario@cinema.com',
                                            labelText: 'Correo electrónico')),
                                  )),
                          StreamBuilder(
                              stream: bloc.passwordStream,
                              builder: (BuildContext context,
                                      AsyncSnapshot snapshot) =>
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                        controller: _passwordController,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        onChanged: bloc.changePassword,
                                        obscureText: _obscureText,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                _obscureText = !_obscureText;
                                                setState(() {});
                                              },
                                              icon: _obscureText
                                                  ? Icon(Icons.visibility,
                                                      color: Theme.of(context)
                                                          .primaryColorDark)
                                                  : Icon(Icons.visibility_off,
                                                      color: Theme.of(context)
                                                          .primaryColorDark)),
                                          errorText: snapshot.error?.toString(),
                                          icon: Icon(
                                            Icons.lock_outline,
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                                          labelText: 'Contraseña',
                                        )),
                                  )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              TextButton(
                                  onPressed: () {
                                    onClickOForgetClient();
                                  },
                                  child: Text("Olvide mi Contraseña",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColorLight))),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                          )))),
                              onPressed: () async {
                                await onClickLogin(context);

                                setState(() {});
                              },
                              icon: const Icon(Icons.login),
                              label: const Text("Ingresar")),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("¿No tiene una cuenta?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color:
                                          Theme.of(context).primaryColorDark)),
                          TextButton(
                              onPressed: () {
                                onClickCreateClient();
                              },
                              child: Text("Registrate",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .primaryColorLight))),
                        ],
                      )
                    ],
                  )))),
    ])));
  }

  onClickLogin(BuildContext context) {
    setState(() => isLoading = true);

    loginConnector
        .postLogin(_emailController.text, _passwordController.text)
        .then((value) async {
      // Store user logged in
      final mainProvider = Provider.of<MainProvider>(context, listen: false);
      log('token ' + value.token);
      await PreferenceManager.saveToken(value, saveAccount);
      mainProvider.token = value.token;

      // Show Main screen
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    }).catchError((e) {
      log(e.toString());
      showAlert(context, e.toString());
    }).whenComplete(() {
      log('complete');
      setState(() => isLoading = false);
    });
  }

  onClickCreateClient() async {
    bool? isUserCreated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );

    if (isUserCreated == true) {
      setState(() {});
    }
  }

  onClickOForgetClient() async {
    bool? isUserCreated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgetClientPage()),
    );

    if (isUserCreated == true) {
      setState(() {});
    }
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
