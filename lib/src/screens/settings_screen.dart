import 'package:cinema_mobile/src/core/api_connector.dart';
import 'package:cinema_mobile/src/core/app_config.dart';
import 'package:cinema_mobile/src/models/api_response.dart';

import 'package:cinema_mobile/src/models/user.dart';
import 'package:cinema_mobile/src/pages/qr_camera_page.dart';
import 'package:cinema_mobile/src/screens/home/drawer_widget.dart';

import 'package:cinema_mobile/src/util/local_object_util.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ApiConnector _apiConnector = ApiConnector();

  User user = User.getDefaultUser();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: _apiConnector.fetchUser(),
          builder: (context, AsyncSnapshot<ApiResponse> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              user = snapshot.data!.response;
            } else if (snapshot.hasError) {
              ApiResponse error = snapshot.error as ApiResponse;
              return Center(
                child: Text("${error.message}"),
              );
            }
            return Scaffold(
              drawer: const DrawerWidget(
                selectedOption: MenuOptions.settings,
              ),
              appBar: AppBar(
                title: const Text(
                  "Ajustes",
                  textAlign: TextAlign.center,
                ),
                centerTitle: true,
                backgroundColor: Theme.of(context).primaryColorDark,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: CircleAvatar(
                                    foregroundImage: NetworkImage(
                                        AppConfig.CONFIG_API_URL +
                                            "" +
                                            user.image.toString()),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                                user.first_name.toString() +
                                    " " +
                                    user.last_name.toString(),
                                style: Theme.of(context).textTheme.headline5!),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Card(
                                    child: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: ListTile(
                                        title: Text(
                                          user.count_movies.toString(),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!,
                                        ),
                                        subtitle: const Text("Peliculas",
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: SizedBox(
                                      width: 110,
                                      height: 100,
                                      child: ListTile(
                                        title: Text(
                                          user.count_survey.toString(),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!,
                                        ),
                                        subtitle: const Text("Encuestas",
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: SizedBox(
                                      width: 110,
                                      height: 100,
                                      child: ListTile(
                                        title: Text(
                                          user.credit.toString(),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!,
                                        ),
                                        subtitle: const Text("Creditos",
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Icon(Icons.movie_creation),
                                title: Text("¿Quieres Canjear Tus Creditos?"),
                                subtitle:
                                    Text("Haz que un empleado en caja escanee"),
                              ),
                            ),
                            Stack(
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 200.0),
                                      child: SizedBox(
                                          height: 150,
                                          width: 150,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(AppConfig
                                                            .CONFIG_API_URL +
                                                        "" +
                                                        user.qrprofile
                                                            .toString()),
                                                    fit: BoxFit.cover)),
                                          )),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 180.0),
                                      child: Column(
                                        children: [
                                          const ListTile(
                                            title: Text("¿Tienes un Boleto?"),
                                            subtitle: Text(
                                              "Escanealo Aqui",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.black,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              onTap: () async {
                                                await onClickCreateThisCollections();
                                              },
                                              leading: const Icon(
                                                  Icons.camera_alt_outlined),
                                              title: const Text("Qr Lector"),
                                              tileColor: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  onClickCreateThisCollections() async {
    bool? isQrScanned = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QrCameraPage()),
    );

    if (isQrScanned == true) {
      setState(() {});
    }
  }
}
