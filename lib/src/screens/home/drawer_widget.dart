import 'package:cinema_mobile/src/core/api_connector.dart';
import 'package:cinema_mobile/src/core/app_config.dart';
import 'package:cinema_mobile/src/core/connection/preferences_manager.dart';
import 'package:cinema_mobile/src/models/api_response.dart';
import 'package:cinema_mobile/src/models/survey_get_model.dart';
import 'package:cinema_mobile/src/models/user.dart';
import 'package:cinema_mobile/src/screens/login_screen.dart';
import 'package:cinema_mobile/src/screens/rewards_screen.dart';
import 'package:cinema_mobile/src/screens/settings_screen.dart';
import 'package:cinema_mobile/src/providers/main_provider.dart';
import 'package:cinema_mobile/src/widgets/libs/screens.dart';
import 'package:cinema_mobile/src/screens/surveys_screen.dart';
import 'package:cinema_mobile/src/util/local_object_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
   const DrawerWidget({Key? key, required this.selectedOption}) : super(key: key);
  final MenuOptions selectedOption;


   @override
   State<DrawerWidget>  createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  User user = User.getDefaultUser();
  late MenuOptions selectedOption;



  @override
  void initState() {
    super.initState();

    selectedOption = widget.selectedOption;
   // loadUser();

  }

  List<Surveys> arraySurvey = [];
  final ApiConnector _apiConnector = ApiConnector();
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return Drawer(
        child: FutureBuilder(
            future: _apiConnector.fetchUser(),
            builder: (context, AsyncSnapshot<ApiResponse> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child:  CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData) {
                user = snapshot.data!.response;
              } else if (snapshot.hasError) {
                ApiResponse error = snapshot.error as ApiResponse;
                return Column(
                  children: [
                    Center(
                      child: Text("${error.message}"),
                      
                    ),
                       Container(
                            alignment: FractionalOffset.bottomRight,
                            child: ListTile(
                              onTap: () {
                                mainProvider.token = "";
                                onClickLogout(context);
                              },
                              leading: const Icon(Icons.exit_to_app),
                              title: const Text("Cerrar Seción"),
                            ),
                          ),
                  ],
                );
              }
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).hintColor, width: 1.0),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              horizontalTitleGap: 10,
                              minVerticalPadding: 25.0,
                              minLeadingWidth: 40.0,
                              leading: SizedBox(
                                height: 80,
                                width: 80,
                                child: CircleAvatar(
                                  foregroundImage: NetworkImage(
                                      AppConfig.CONFIG_API_URL +
                                          "" +
                                          user.image.toString()),
                                ),
                              ),
                              title: Text(
                                  user.first_name! + " " + user.last_name!),
                              subtitle:
                                  Text(user.credit.toString() + " créditos"),
                            ),
                          ),
                            Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: () {
                                 onClickMenuOption(context, MenuOptions.home);
                              },
                              leading: const Icon(Icons.home),
                              title: const Text("Regresar al Inicio"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: () {
                                onClickMenuOption(
                                    context, MenuOptions.settings);
                              },
                              leading: const Icon(Icons.settings),
                              title: const Text("Mi Perfil"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: () {
                                onClickMenuOption(context, MenuOptions.rewards);
                              },
                              leading: const Icon(Icons.workspace_premium),
                              title: const Text("Premios"),
                            ),
                          ),
                          FutureBuilder(
                              future: _apiConnector.fetchSurveys(),
                              builder: (context,
                                  AsyncSnapshot<ApiResponse> snapshot) {
                                if (snapshot.hasData) {
                                  arraySurvey = snapshot.data!.response;
                                } else if (snapshot.hasError) {
                                  ApiResponse error =
                                      snapshot.error as ApiResponse;
                                  return Center(
                                    child: Text("${error.message}"),
                                  );
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    onTap: () {
                                      onClickMenuOption(
                                          context, MenuOptions.surveys);
                                    },
                                    leading: const Icon(
                                        Icons.document_scanner_sharp),
                                    title: const Text("Encuestas"),
                                    trailing: (arraySurvey.isEmpty)
                                        ? CircleAvatar(
                                            backgroundColor:
                                                Theme.of(context).cardColor,
                                          )
                                        : CircleAvatar(
                                            child: Text(
                                                arraySurvey.length.toString()),
                                          ),
                                  ),
                                );
                              }),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: const Icon(Icons.mobile_friendly),
                              title: const Text("Modo Oscuro"),
                              trailing: Switch(
                                  value: mainProvider.mode,
                                  onChanged: (bool value) async {
                                    mainProvider.mode = value;
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setBool("mode", value);
                                  }),
                            ),
                          ),
                         
                          Container(
                            alignment: FractionalOffset.bottomRight,
                            child: ListTile(
                              onTap: () {
                                mainProvider.token = "";
                                onClickLogout(context);
                              },
                              leading: const Icon(Icons.exit_to_app),
                              title: const Text("Cerrar Seción"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }));
  }

  void loadUser() async {
    PreferenceManager.getLogin().then((value) {
      setState(() => user = value!);
    });
  }

  onClickMenuOption(BuildContext context, MenuOptions selectedOption) {
    Navigator.pop(context);

    if (this.selectedOption != selectedOption) {
      setState(() {
        this.selectedOption = selectedOption;
      });

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        switch (this.selectedOption) {
          case MenuOptions.settings:
            return const SettingsPage();
          case MenuOptions.rewards:
            return const RewardsPage();
          case MenuOptions.surveys:
            return const SurveysScreen();
          case MenuOptions.home:
          return const HomeScreen();
        }
      }));
    }
  }

  onClickLogout(BuildContext context) async {

    await PreferenceManager.clearAll();

    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
  }
}
