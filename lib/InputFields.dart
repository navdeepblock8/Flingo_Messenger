import 'package:flutter/material.dart';
class InputFields extends StatelessWidget {
  InputFields({this.bordercolour,this.labelText,this.labelTextColor,this.hintText,this.hidevalue});
  final String labelText;
  final String hintText;
  final Color bordercolour;
  final Color labelTextColor;
  final bool hidevalue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
      child: Theme(
        data: ThemeData(
            primaryColor: bordercolour,
            primaryColorDark: bordercolour
        ),
        child: TextField(
          textAlign: TextAlign.center,
          obscureText: hidevalue,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color:Colors.purple,
                    width: 5.0
                )
            ),
            labelText: labelText,
            hintText: hintText,
            labelStyle: TextStyle(
              color: labelTextColor,
            ),
          ),
          onChanged: (value){
            return(value);
          },
        ),
      ),
    );
  }
}
