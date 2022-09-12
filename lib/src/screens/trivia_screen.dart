import 'package:cinema_mobile/src/models/api_response.dart';
import 'package:cinema_mobile/src/providers/main_provider.dart';
import 'package:cinema_mobile/src/util/dialog_util.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class TriviaScreen extends StatefulWidget {
  const TriviaScreen({Key? key}) : super(key: key);

  @override
  State<TriviaScreen> createState() => _TriviaScreenState();
}

int _remaining = 0;
const int _duration = 10;
int _numpregunta = 0;
final CountDownController _controller = CountDownController();
bool isTriviaEnded = false;

class _TriviaScreenState extends State<TriviaScreen> {
  _setRemaining() async {
    _remaining = (MainProvider.prefs.getInt("remaining"))!;
  }

  @override
  Widget build(BuildContext context) {
    if(_numpregunta < 5){
          _numpregunta++;
    }else{
       _controller.pause();
                  
    }

    @override
    void initState() {
      super.initState();

      _setRemaining();
    }

    final TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Pregunta ${_numpregunta.toString()}",
                  style: textTheme.headline4,
                )),
          ),
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 150,
                width: 150,
                child: Card(
                  child: ListTile(
                    title: CircleAvatar(
                      child: Text("B"),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 350.0),
            child: Align(
              alignment: Alignment.center,
              child: CircularCountDownTimer(
                duration: _duration,
                initialDuration: _remaining,
                controller: _controller,
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                ringColor: Colors.grey[300]!,
                ringGradient: null,
                fillColor: Colors.purpleAccent[100]!,
                fillGradient: null,
                backgroundColor: Colors.purple[500],
                backgroundGradient: null,
                strokeWidth: 20.0,
                strokeCap: StrokeCap.round,
                textStyle: const TextStyle(
                    fontSize: 33.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textFormat: CountdownTextFormat.S,
                isReverse: false,
                isReverseAnimation: false,
                isTimerTextShown: true,
                autoStart: true,
                onStart: () {
                  debugPrint('Countdown Started');
                },
                onComplete: () {
                  debugPrint('Countdown Ended');

                  setState(() {
                    _controller.restart();
                  
                    if (_numpregunta == 5) {
                      isTriviaEnded = true;
                      showSuccessAlert(
                          context, "Juego Terminado !Gracias Por Jugar!");
                    }
                  });
                },
                onChange: (String timeStamp) {
                  debugPrint('Countdown Changed $timeStamp');
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 150,
                width: 150,
                child: Card(
                  child: ListTile(
                    title: CircleAvatar(
                      child: Text("A"),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 25.0, bottom: 125),
            child: Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 150,
                width: 150,
                child: Card(
                  child: ListTile(
                    title: CircleAvatar(
                      child: Text("D"),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 25.0, bottom: 125),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                height: 150,
                width: 150,
                child: Card(
                  child: ListTile(
                    title: CircleAvatar(
                      child: Text("C"),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void showSuccessAlert(BuildContext context, String response) {

    
    DialogUtils.showAlert(context, response, <Widget>[
      TextButton(
        onPressed: () {
          Navigator.pop(context, 'OK');
          Navigator.pop(context, isTriviaEnded);
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
