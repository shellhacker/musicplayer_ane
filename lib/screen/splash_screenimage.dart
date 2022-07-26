import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/screen/list_screen.dart';
import 'package:musicplayer/widgets/cmmn_background_color.dart';

class SplashScreenImage extends StatefulWidget {
  const SplashScreenImage({Key? key}) : super(key: key);

  @override
  State<SplashScreenImage> createState() => _SplashScreenImageState();
}

class _SplashScreenImageState extends State<SplashScreenImage> {
  @override
 

  @override
  Widget build(BuildContext context) {
     return CmnBgdClor(
       child: Scaffold(
        backgroundColor: Colors.transparent,
         body: AnimatedSplashScreen(splash: 
           
           Image.asset('asset/splash .png',
          //  width: MediaQuery.of(context).size.width/2,
          // height:  MediaQuery.of(context).size.height/2
           ),
           backgroundColor: Colors.transparent,
           splashIconSize: 300,
           
           
           duration: 4000,
           splashTransition: SplashTransition.slideTransition,
            //  pageTransitionType: PageTransitionType.,
         nextScreen: const ListScreen()),
       ),
     );
  // Scaffold(
  //     body: Stack(
  //       children: [
  //         Container(
  //           width: double.infinity,
  //           height: double.infinity,
  //           decoration: const BoxDecoration(
  //             image: DecorationImage(
  //                 image: AssetImage('asset/entertime.jpg'), fit: BoxFit.cover),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(top: 705, left: 130),
  //           child: ElevatedButton(
  //             onPressed: () {},
  //             child: const Text('Feel The Vibe'),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Future<void> gotoLogin() async {
  //   await Future.delayed(const Duration(seconds: 3));
  //   // ignore: use_build_context_synchronously
  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(
  //       builder: (context) => const ListScreen(),
  //     ),
  //   );
  }
}
