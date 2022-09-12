import 'package:cinema_mobile/src/core/api_connector.dart';
import 'package:cinema_mobile/src/models/answersurvey.dart';
import 'package:cinema_mobile/src/models/api_response.dart';
import 'package:cinema_mobile/src/models/survey_get_model.dart';

import 'package:cinema_mobile/src/screens/surveys_screen.dart';
import 'package:cinema_mobile/src/util/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({Key? key, required this.currentSurvey}) : super(key: key);
  final Surveys currentSurvey;
  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

ApiConnector _apiConnector = ApiConnector();

class _SurveyPageState extends State<SurveyPage> {
  int currentStep = 0;
  double _answer1 = 3;
  double _answer2 = 3;
  double _answer3 = 3;
  double _answer4 = 3;

  bool isSurveyCreated = false;
  // ignore: unused_field
  late bool? _success;
  late int cont;

  // ignore: unused_field

  final _answer5 = TextEditingController();

  final List<GlobalKey<FormState>> _listKeys = [
    GlobalKey(),
    GlobalKey(),
  ];

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: const Icon(Icons.person),
          content: Form(
            key: _listKeys[0],
            autovalidateMode: AutovalidateMode.disabled,
            child: formUser1(),
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          title: const Icon(Icons.contact_mail_outlined),
          content: Form(
            key: _listKeys[1],
            autovalidateMode: AutovalidateMode.disabled,
            child: formUser2(),
          ),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 800,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Encuensta " + widget.currentSurvey.movies!),
          centerTitle: true,
        ),
        body: Theme(
          data: Theme.of(context).copyWith(),
          child: Stepper(
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white70)),
                      onPressed: details.onStepCancel,
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white70)),
                      onPressed: details.onStepContinue,
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ],
              );
            },
            type: StepperType.vertical,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () async {
              final isLastStep = currentStep == getSteps().length - 1;
              if (_listKeys[currentStep].currentState!.validate()) {
                if (isLastStep) {
                 await onClickSendAnswer();
                } else {
                  setState(() => currentStep += 1);
                }
              }
            },
            onStepCancel: currentStep == 0
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SurveysScreen()),
                    );
                  }
                : () {
                    setState(() => currentStep -= 1);
                  },
          ),
        ),
      ),
    );
  }

  Widget formUser1() {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 15,
        child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.currentSurvey.question1!,
                    overflow: TextOverflow.ellipsis, maxLines: 2),
              ),
              SfSlider(
                stepSize: 1,
                min: 0.0,
                max: 5.0,
                value: _answer1,
                interval: 1,
                showTicks: true,
                showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                onChanged: (dynamic value) {
                  setState(() {
                    _answer1 = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.currentSurvey.question2!,
                    overflow: TextOverflow.ellipsis, maxLines: 2),
              ),
              SfSlider(
                stepSize: 1,
                min: 0.0,
                max: 5.0,
                value: _answer2,
                interval: 1,
                showTicks: true,
                showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                onChanged: (dynamic value) {
                  setState(() {
                    _answer2 = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.currentSurvey.question3!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              SfSlider(
                stepSize: 1,
                min: 0.0,
                max: 5.0,
                value: _answer3,
                interval: 1,
                showTicks: true,
                showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                onChanged: (dynamic value) {
                  setState(() {
                    _answer3 = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.currentSurvey.question4!,
                    overflow: TextOverflow.ellipsis, maxLines: 2),
              ),
              SfSlider(
                stepSize: 1,
                min: 0,
                max: 5,
                value: _answer4,
                interval: 1,
                showTicks: true,
                showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                onChanged: (dynamic value) {
                  setState(() {
                    _answer4 = value;
                  });
                },
              ),
            ])));
  }

  Widget formUser2() {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 15,
        child: Column(
          children: [
            Text(widget.currentSurvey.question5!,
                overflow: TextOverflow.ellipsis, maxLines: 2),
            Padding(
                padding: const EdgeInsets.all(11.0),
                child: Column(children: <Widget>[
                  TextFormField(
                    maxLines: 4,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    controller: _answer5,
                    maxLength: 200,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    validator: (value) {
                      return null;
                    },
                  ),
                ])),
          ],
        ));
  }

  onClickSendAnswer() {
    AnswerSurvey answers = AnswerSurvey(_answer1.toInt(), _answer2.toInt(),
        _answer3.toInt(), _answer4.toInt(), _answer5.text);

    _apiConnector.sendAnswers(widget.currentSurvey.id!, answers).then((value) {
      showSuccessAlert(context, value);
      isSurveyCreated = true;
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
          Navigator.pop(context, isSurveyCreated);
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
