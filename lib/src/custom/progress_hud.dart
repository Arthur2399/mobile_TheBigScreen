import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProgressHUD2 extends StatefulWidget {
  final Color backgroundColor;
  final Color color;
  final Color containerColor;
  final double borderRadius;
  final String text;
  final bool loading;
  late ProgressHUDState2 state;

  ProgressHUD2(
      { Key? key,
        this.backgroundColor = Colors.black54,
        this.color = Colors.white,
        this.containerColor = Colors.transparent,
        this.borderRadius = 10.0,
        this.text = "",
        this.loading = true})
      : super(key: key);


  @override
  ProgressHUDState2 createState() {
    return  ProgressHUDState2();
  }
}

class ProgressHUDState2 extends State<ProgressHUD2> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();

    _visible = widget.loading;
  }

  void dismiss() {
    setState(() {
      _visible = false;
    });
  }

  void show() {
    setState(() {
      _visible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_visible) {
      return  Scaffold(
          backgroundColor: widget.backgroundColor,
          body:  Stack(
            children: <Widget>[
               Center(
                child:  Container(
                  width: 200.0,
                  height: 100.0,
                  decoration:  BoxDecoration(
                      color: widget.containerColor,
                      borderRadius:  BorderRadius.all(
                           Radius.circular(widget.borderRadius))),
                ),
              ),
               Center(
                child: _getCenterContent(),
              )
            ],
          ));
    } else {
      return  Container();
    }
  }

  Widget _getCenterContent() {
    if (widget.text.isEmpty) {
      return _getCircularProgress();
    }

    return  Center(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getCircularProgress(),
           Container(
            margin: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
            child:  Text(
              widget.text,
              style:  TextStyle(color: widget.color),
            ),
          )
        ],
      ),
    );
  }

  Widget _getCircularProgress() {
    return  CircularProgressIndicator(
        valueColor:  AlwaysStoppedAnimation(widget.color));
  }
}
