import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CmnBgdClor extends StatelessWidget {
  Widget? child;
   CmnBgdClor({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      Container(width: double.infinity,height: double.infinity,
    decoration:const BoxDecoration(gradient: LinearGradient(
      colors:[Color.fromARGB(255, 213, 143, 255),
       Color.fromARGB(255, 30, 4, 47),],
      begin:Alignment.topCenter,
      end: Alignment.bottomCenter,
     
      ),
      ),
      child: child,
    );
  }
}