import 'package:flutter/material.dart';
import 'constants.dart';
class RoundButtons extends StatelessWidget {
  RoundButtons({this.label,this.colour, this.onpressed});
  final String label;
  final Color colour;
  final Function onpressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: colour
      ),
      child: FlatButton(
        onPressed: onpressed,
        child: Text(
          label,
          style: buttontextstyle,
        ),
      ),
    );
  }
}
