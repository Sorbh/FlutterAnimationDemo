import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircularButtonWidget extends StatelessWidget {
  double radius;
  Key key;

  CircularButtonWidget({this.radius = 50, this.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      key: key,
      height: radius * 2,
      width: radius * 2,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
    );
  }
}
