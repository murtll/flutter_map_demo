import 'package:flutter/material.dart';

@immutable
class CustomButton extends StatelessWidget {
  final Icon icon;
  final Function onTap;

  CustomButton({@required this.onTap, @required this.icon});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
            width: 47,
            height: 47,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 2),
                  )
                ]),
            child: icon),
      );
}
