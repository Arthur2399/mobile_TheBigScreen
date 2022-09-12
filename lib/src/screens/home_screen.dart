import 'package:cinema_mobile/src/core/api_connector.dart';
import 'package:cinema_mobile/src/models/api_response.dart';
import 'package:cinema_mobile/src/models/movies_model.dart';
import 'package:cinema_mobile/src/models/survey_get_model.dart';
import 'package:cinema_mobile/src/models/top5movies_model.dart';
import 'package:cinema_mobile/src/screens/home/drawer_widget.dart';
import 'package:cinema_mobile/src/util/local_object_util.dart';
import 'package:flutter/material.dart';
import 'package:cinema_mobile/src/widgets/libs/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiConnector _apiConnector = ApiConnector();

  List<Movie> arrayMovies = [];

  List<Top5Movies> arrayTop5Movies = [];

  List<Surveys> arraySurvey = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(
          selectedOption: MenuOptions.home,
        ),
        appBar: AppBar(
          title: const Text('Películas en cines'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: _apiConnector.fetchMovies(),
              builder: (context, AsyncSnapshot<ApiResponse> snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  arrayMovies = snapshot.data!.response;
                } else if (snapshot.hasError) {
                  ApiResponse error = snapshot.error as ApiResponse;
                  return Center(
                    child: Text("${error.message}"),
                  );
                }
                return Column(
                  children: [
                    // Tarjetas principales
                    MoviesCardSwiper(movies: arrayMovies),

                    // Slider de películas
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Column(
                        children: [
                          FutureBuilder(
                              future: _apiConnector.fetchTop5Movies(),
                              builder:
                                  (context, AsyncSnapshot<ApiResponse> snapshot) {
                                if (snapshot.connectionState !=
                                    ConnectionState.done) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (snapshot.hasData) {
                                  arrayTop5Movies = snapshot.data!.response;
                                  if (arrayTop5Movies.isNotEmpty) {
                                    return Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: SizedBox(
                                            height: 300,
                                            width: 275,
                                            child: MovieSlider(
                                              movies:
                                                  arrayTop5Movies, // populares,
                                              title: 'La Mas Popular', // opcional
                                            
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: SizedBox(
                                            width: 200,
                                            child: Card(
                                              child: Column(
                                                children: [
                                                  const Text('Top 5'),
                                                  Column(
                                                    children: getTop5ListWidget(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return _getNoDataWidget();
                                  }
                                } else if (snapshot.hasError) {
                                  ApiResponse error =
                                      snapshot.error as ApiResponse;
                                  return Center(
                                    child: Text("${error.message}"),
                                  );
                                }
                                return _getNoDataWidget();
                              }),
                        ],
                      ),
                    )
                  ],
                );
              }),
        ));
  }

  List<Widget> getTop5ListWidget() {
    List<Widget> childrenWidgets = arrayTop5Movies.map((e) {
      return Column(
        children: [
          ListTile(
            title: Text(e.nameMovie!,
                overflow: TextOverflow.ellipsis, maxLines: 5),
            trailing: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                child: Text(e.stars.toString()),
              ),
            ),
          ),
        ],
      );
    }).toList();
    return childrenWidgets;
  }

  Widget _getNoDataWidget() {
    return const Center(
      child: Text("No existen Datos en Top 5"),
    );
  }
}
