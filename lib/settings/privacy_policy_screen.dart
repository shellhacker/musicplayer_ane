// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:musicplayer/widgets/cmmn_background_color.dart';

// class PrivacyPolicyScreen extends StatefulWidget {
//   PrivacyPolicyScreen({Key? key,  this.radius =8, required this.mdFileName}) :assert(mdFileName.contains(".md"),'the file most contain the .md extension' ) ,super(key: key);


// final double radius;
// final String mdFileName;
//   @override
//   State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
// }

// class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return CmnBgdClor(child: Scaffold(
//       body: Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(44)),
//         child: Column(
//           children: [
//             Expanded(child: FutureBuilder(future:Future.delayed(Duration(milliseconds: 150)).then((value) => {
//               return rootBundle.loadString('asset/$mdFileName')
//             }) ,
//             builder: (context, snapshot){
//               if(snapshot.hasData){
//                  return Markdown(data: snapshot.data);
                
//               }
             
//             },)),
//             ElevatedButton(onPressed: (){}, child: Container(
//               child: Text('close'),
//             ))
//           ],
//         ),

        
//       ),
//     ));

//   }
//    void modalBottomSheetMenu(){
//         showModalBottomSheet(
//             context: context,
//             builder: (builder){
//               return new Container(
//                 height: 350.0,
//                 color: Colors.transparent, //could change this to Color(0xFF737373), 
//                            //so you don't have to change MaterialApp canvasColor
//                 child: new Container(
//                     decoration: new BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: new BorderRadius.only(
//                             topLeft: const Radius.circular(10.0),
//                             topRight: const Radius.circular(10.0))),
//                     child: new Center(
//                       child: new Text("This is a modal sheet"),
//                     )),
//               );
//             }
//         );
//       }
// }