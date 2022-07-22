// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:video_player/video_player.dart';

// import 'main.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     _controller = VideoPlayerController.asset(
//       'assets/appop.mp4',
//     )
//       ..initialize().then((_){
//         setState(() {
//         });
//       })
//       ..setVolume(0.0);

//     _playVideo();
//   }

//   void _playVideo() async {
//     _controller.play();

//     await Future.delayed(const Duration(seconds: 4));

//     // Navigator.pushNamed(context, '/main/');
//     Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage(title: 'Hangover Tomorrow...')));
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(68, 66, 64, 0.9),
//       body: Container(
//         alignment: Alignment.center,
//         // width: MediaQuery.of(context).size.width,
//         // height: MediaQuery.of(context).size.height,
//         child: _controller.value.isInitialized
//             ? AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(
//                   _controller,
//                 ),
//               )
//             : Container(),
//       ),
//     );
//   }
// }