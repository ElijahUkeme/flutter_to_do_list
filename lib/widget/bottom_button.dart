import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  final Color color;
  bool? isClosed = false;
   BottomButton({Key? key,
  required this.label, required this.onTap, required this.color,this.isClosed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        height: 55,
        margin: EdgeInsets.symmetric(vertical: 4),
        width: MediaQuery.of(context).size.width*0.9,

        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClosed==true?Colors.grey:color
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClosed==true?Colors.white:color,
        ),
        child: Center(
          child: Text(
            label,
            style: isClosed==true?
            TextStyle(
            fontWeight: FontWeight.w600,
    fontSize: 16,
    color: Colors.black54,
          ):TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: Colors.white,
      ),
    ),
        )));
  }
}
