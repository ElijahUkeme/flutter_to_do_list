import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/utils/themes.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const AppButton({Key? key,required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bluishColor
        ),
        child: Center(
          child: Text(
            label,style: TextStyle(
            color: Colors.white
          ),
          ),
        ),
      ),
    );
  }
}
