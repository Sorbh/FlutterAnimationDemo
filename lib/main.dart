import 'package:flutter/material.dart';
import 'package:test_app/CircularButtonWidget.dart';
import 'package:test_app/LinePainter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  GlobalKey _circularButtonKey;
  AnimationController _mainButtonController;
  AnimationController _secondaryButtonController;

  Animation<Alignment> _firstSecondaryButtonAnim;
  Animation<Alignment> _secondSecondaryButtonAnim;
  Animation<Alignment> _thirdSecondaryButtonAnim;

  MyHomePageState() {
    _mainButtonController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500), lowerBound: 1, upperBound: 1.2);

    _mainButtonController.addListener(() {
//      print('addListener ${_mainButtonController.value}');
      setState(() {});
    });
    _mainButtonController.addStatusListener((animationStatus) {
      print(animationStatus.toString());
      if (animationStatus == AnimationStatus.dismissed) {
        _secondaryButtonController.forward();
      }
    });

    _secondaryButtonController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _secondaryButtonController.addListener(() {
      print('addListener ${_secondaryButtonController.value}');
      setState(() {});
    });
    final anim = CurvedAnimation(parent: _secondaryButtonController, curve: Curves.linear);

    _firstSecondaryButtonAnim = Tween<Alignment>(begin: Alignment.center, end: Alignment.topLeft).animate(anim);
    _secondSecondaryButtonAnim = Tween<Alignment>(begin: Alignment.center, end: Alignment.topCenter).animate(anim);
    _thirdSecondaryButtonAnim = Tween<Alignment>(begin: Alignment.center, end: Alignment.topRight).animate(anim);

    _secondaryButtonController.addStatusListener((animationStatus) {
      print(animationStatus.toString());
      if (animationStatus == AnimationStatus.completed) {
//        _secondaryButtonController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        alignment: AlignmentDirectional.center,
        color: Colors.white,
        child: Container(
          width: 300,
          height: 300,
          color: Colors.blue,
          alignment: AlignmentDirectional.center,
          child: Stack(
            children: <Widget>[
              CustomPaint(
                child: Container(),
                painter: LinePainter(delta: _secondaryButtonController.value),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Align(
                  alignment: _firstSecondaryButtonAnim.value,
                  child: CircularButtonWidget(
                    radius: 37.5 * _secondaryButtonController.value,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(),
                child: Align(
                  alignment: _secondSecondaryButtonAnim.value,
                  child: CircularButtonWidget(
                    radius: 37.5 * _secondaryButtonController.value,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20, top: 20),
                child: Align(
                  alignment: _thirdSecondaryButtonAnim.value,
                  child: CircularButtonWidget(
                    radius: 37.5 * _secondaryButtonController.value,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  child: CircularButtonWidget(
                    radius: 50 * _mainButtonController.value,
                    key: _circularButtonKey,
                  ),
                  onTap: () {
                    print('onTap');
                  },
                  onTapUp: (details) {
                    print('onTapUp');
                    _mainButtonController.reverse();
                  },
                  onTapDown: (details) {
                    print('onTapDown');
                    _mainButtonController.forward();
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
