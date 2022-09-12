import 'package:cinema_mobile/src/core/api_connector.dart';
import 'package:cinema_mobile/src/models/api_response.dart';
import 'package:cinema_mobile/src/models/survey_get_model.dart';
import 'package:cinema_mobile/src/pages/survey_page.dart';
import 'package:cinema_mobile/src/screens/home/drawer_widget.dart';
import 'package:cinema_mobile/src/util/local_object_util.dart';
import 'package:flutter/material.dart';

class SurveysScreen extends StatefulWidget {
  const SurveysScreen({Key? key}) : super(key: key);

  @override
  _SurveysScreenState createState() => _SurveysScreenState();
}

class _SurveysScreenState extends State<SurveysScreen> {
  // Http
  final ApiConnector _apiConnector = ApiConnector();

  // Logical variables
  List<Surveys> arraySurvey = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(
          selectedOption: MenuOptions.surveys,
        ),
        appBar: AppBar(
          title: const Text('Encuestas'),
        ),
        body: FutureBuilder(
          future: _apiConnector.fetchSurveys(),
          builder: (context, AsyncSnapshot<ApiResponse> snapshot) =>
              buildContent(context, snapshot),
        ));
  }

  Widget buildContent(
      BuildContext context, AsyncSnapshot<ApiResponse> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (snapshot.hasData) {
      arraySurvey = snapshot.data!.response;
      if (arraySurvey.isNotEmpty) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: getCollectionsListWidget(),
          ),
        );
      } else {
        return _getNoDataWidget();
      }
    } else if (snapshot.hasError) {
      return Center(
        child: Text("${snapshot.error}"),
      );
    }

    return _getNoDataWidget();
  }

  Widget _getNoDataWidget() {
    return const Center(
      child: Text("No tiene Encuestas"),
    );
  }

  List<Widget> getCollectionsListWidget() {
    List<Widget> childrenWidgets = arraySurvey.map((survey) {
      return InkWell(
        onTap: () {
          onClickCreateThisCollections(survey);
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(survey.id.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(survey.movies!,
                        style: Theme.of(context).textTheme.headline5,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2),
                    const SizedBox(height: 2.5),
                    Text(survey.date!,
                        style: TextStyle(color: Colors.black.withOpacity(0.5))),
                  ],
                )),
              ],
            ),
            const Padding(
                padding: EdgeInsets.only(top: 10),
                child:
                    Divider(height: 1, thickness: 1, indent: 0, endIndent: 0))
          ],
        ),
      );
    }).toList();

    return childrenWidgets;
  }

  //////////////////////////////////////////////////////////////////////////////
  // OnClick Methods
  //////////////////////////////////////////////////////////////////////////////

  onClickCreateThisCollections(Surveys _currentSurvey) async {
    bool? isSurveyCreated = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SurveyPage(currentSurvey: _currentSurvey)),
    );

    if (isSurveyCreated == true) {
      setState(() {});
    }
  }
}
