// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cinema_mobile/src/bloc/signup_bloc.dart';
import 'package:cinema_mobile/src/core/api_connector.dart';
import 'package:cinema_mobile/src/custom/progress_hud.dart';
import 'package:cinema_mobile/src/models/api_response.dart';
import 'package:cinema_mobile/src/models/userRegister.dart';

import 'package:cinema_mobile/src/util/dialog_util.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

String imagestr = "";

class _SignUpPageState extends State<SignUpPage> {
  late ProgressHUD2 loading;
  bool isClientCreated = false;
  bool isAvaliable = false;

  @override
  void initState() {
    super.initState();
    loading = initializeLoading('Registrando Usuario...');
    
  }

  final ApiConnector _apiConnector = ApiConnector();

  bool _obscureText = true;

  final first_name = TextEditingController();
  final last_name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  final SignUpBloc _signUpBloc = SignUpBloc();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;

    Future _selectImage(ImageSource source) async {
      final imageCamera = await ImagePicker().pickImage(source: source);
      if (imageCamera == null) return;

      var value = await imageCamera.readAsBytes();
      Uint8List bytes = Uint8List.fromList(value);
      String imageString = base64.encode(bytes);
      imagestr = imageString;

      setState(() {});
    }

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
                child: Text("Registro de usuario",
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
                          stream: _signUpBloc.usernameStream,
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
                                    controller: first_name,
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: _signUpBloc.changeUsername,
                                    decoration: InputDecoration(
                                        errorText: snapshot.error?.toString(),
                                        icon: const Icon(Icons.person),
                                        labelText: "Nombre",
                                        hintText: "Escriba su Nombre")),
                              ),
                            );
                          }),
                      StreamBuilder<String>(
                          stream: _signUpBloc.usernameStream,
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
                                    controller: last_name,
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: _signUpBloc.changeUsername,
                                    decoration: InputDecoration(
                                        errorText: snapshot.error?.toString(),
                                        icon: const Icon(Icons.person),
                                        labelText: "Apellido",
                                        hintText: "Escriba su Apellido")),
                              ),
                            );
                          }),
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
                      StreamBuilder<String>(
                          stream: _signUpBloc.passwordStream,
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
                                    controller: password,
                                    onChanged: _signUpBloc.changePassword,
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                        errorText: snapshot.error?.toString(),
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              _obscureText = !_obscureText;
                                              setState(() {});
                                            },
                                            icon: Icon(
                                              _obscureText
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                            )),
                                        icon: const Icon(Icons.lock),
                                        labelText: "Contraseña")),
                              ),
                            );
                          }),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 72,
                                    child: ImagenBotonones(
                                        isAvalible: isAvaliable,
                                        icon: Icons.image_search,
                                        onClicked: () =>
                                            _selectImage(ImageSource.gallery)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 72,
                                    child: ImagenBotonones(
                                        isAvalible: isAvaliable,
                                        icon: Icons.camera_alt,
                                        onClicked: () =>
                                            _selectImage(ImageSource.camera)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: StreamBuilder<bool>(
                             stream: _signUpBloc.formSignUpStream,
                            builder: (context, snapshot) {
                              return ElevatedButton.icon(
                          
                                  onPressed:snapshot.hasData ? ()  async  {
                                    try {
                                      await onClickCreateClient();
                          
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
                                                                    const SignUpPage()),
                                                          );
                                                        }),
                                                  ],
                                                )
                                              ],
                                            );
                                          });
                                    }
                                  } : null ,
                                  icon: const Icon(Icons.login_outlined),
                                  label: const Text("Registrarse"));
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

  Widget ImagenBotonones({
    required bool isAvalible,
    required IconData icon,
    required VoidCallback onClicked,
  }) {
    return ElevatedButton(

      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(10),
          primary: Colors.white,
          onPrimary: Colors.black,
          textStyle: const TextStyle(fontSize: 20)),
      child: Row(
        children: [
          Icon(icon, size: 30),
        ],
      ),
      onPressed: onClicked,
    );
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  onClickCreateClient() async {
    userRegister user = userRegister(
        first_name.text, last_name.text, email.text, email.text, password.text);

    user.image = imagestr.toString();

    _apiConnector.createUsers(user).then((value) {
      showSuccessAlert(context, value);
      isClientCreated = true;
    }).catchError((error) {
      ApiResponse response = error as ApiResponse;
      showErrorAlert(context, response);
    }).whenComplete(() {
      //loading.state.dismiss();
    });
    //Navigator.pop(context);
  }

  void showSuccessAlert(BuildContext context, ApiResponse response) {
    DialogUtils.showAlert(context, response.message!, <Widget>[
      TextButton(
        onPressed: () {
          Navigator.pop(context, 'OK');
          Navigator.pop(context, isClientCreated);
        },
        child: const Text('Aceptar'),
      ),
    ]);
  }

  void showErrorAlert(BuildContext context, ApiResponse error) {
    DialogUtils.showAlert(context, error.message!, <Widget>[
      TextButton(
        onPressed: () {
          Navigator.pop(context, 'OK');
        },
        child: const Text('Aceptar'),
      ),
    ]);
  }
}
