import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String link;
  final String title;
  final String token;

  const VideoPage({
    super.key,
    required this.link,
    required this.title,
    required this.token
  });

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {

  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    double _aspectRatio = 16 / 9;

    final token = widget.token.split('"')[1];


    // .asset(
    // 'images/butterfly.mp4',
    // )
    // .networkUrl( Uri.parse(
    //           '${widget.link}$token',
    //         ))

    _controller = VideoPlayerController.asset('assets/images/butterfly.mp4');
      // ..initialize()
      //     .then((value) => {
      //       setState((){
      //         _controller.setLooping(true);
      //         _controller.play();
      //       })
      //     });

    _chewieController = ChewieController(
      allowedScreenSleep: false,
      allowFullScreen: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ],
      videoPlayerController: _controller,
      aspectRatio: _aspectRatio,
      autoInitialize: true,
      autoPlay: true,
      showControls: true
    );
    _chewieController.addListener(() {
      if (_chewieController.isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft
        ]);

      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // _controller.dispose();
    super.dispose();
  }

  bool showControls = false;




  getFullTime(int seconds) {

    String time = '';
    var minutes = 0;
    if (seconds > 60) {
      minutes = (seconds / 60).truncate();
      seconds = seconds - minutes * 60;

    }
    time = '${minutes > 9 ? minutes : '0$minutes'}:${seconds > 9 ? seconds : '0$seconds'}';

    return time;
  }

  void setShowControls () {
    setState(() {
      showControls = false;
    });
  }

  late Timer _timer;
  Duration duration = const Duration(seconds: 1);

  timer () {
    _timer = Timer(duration, setShowControls);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Chewie(controller: _chewieController)
        // _controller.value.isInitialized
        // ?

        // Column (
        //   children: [
        //     AspectRatio(
        //       aspectRatio: _controller.value.aspectRatio,
        //       child: InkWell(
        //         onTap: ((){
        //           showControls = true;
        //           setState(() {
        //             if (_controller.value.isPlaying) {
        //               timer();
        //             } else {
        //               if (_timer.isActive) {
        //                 _timer.cancel();
        //               }
        //             }
        //           });
        //         }),
        //         child: Stack(
        //           alignment: Alignment.bottomCenter,
        //           children: [
        //             IgnorePointer(
        //               child: VideoPlayer(_controller),
        //             ),
        //             showControls ?
        //                 Column (
        //                   children: [
        //                     AspectRatio(
        //                       aspectRatio: _controller.value.aspectRatio,
        //                       child: ColoredBox(
        //                         color: Colors.black26,
        //                         child: Column(
        //                           mainAxisAlignment: MainAxisAlignment.end,
        //                           children: [
        //                             Row(
        //                               mainAxisAlignment: MainAxisAlignment.center,
        //                               children: [
        //                                 InkWell(
        //                                   child:  const Icon(
        //                                     Icons.rotate_left,
        //                                     size: 70,
        //                                     color: Colors.white,
        //                                   ),
        //                                   onTap: () {
        //                                     setState(() {
        //                                       _controller
        //                                           .seekTo(Duration(
        //                                           seconds: _controller.value.position.inSeconds - 10
        //                                       ));
        //                                     });
        //                                   },
        //                                 ),
        //                                 InkWell(
        //                                   child:  Icon(
        //                                     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        //                                     size: 70,
        //                                     color: Colors.white,
        //                                   ),
        //                                   onTap: () {
        //                                     if (_timer.isActive) {
        //                                       _timer.cancel();
        //                                     }
        //                                     setState(() {
        //                                       if (_controller.value.isPlaying) {
        //                                         _controller.pause();
        //                                         showControls = true;
        //                                       } else {
        //                                         _controller.play();
        //                                         Timer(duration, () {
        //                                           setState(() {
        //                                             showControls = false;
        //                                           });
        //                                         });
        //                                       }
        //                                     });
        //                                   },
        //                                 ),
        //                                 InkWell(
        //                                   child:  const Icon(
        //                                     Icons.rotate_right,
        //                                     size: 70,
        //                                     color: Colors.white,
        //                                   ),
        //                                   onTap: () {
        //                                     setState(() {
        //                                       _controller.seekTo(Duration(seconds: _controller.value.position.inSeconds + 10));
        //                                     });
        //                                   },
        //                                 ),
        //
        //                               ],
        //                             ),
        //                             const SizedBox(height: 50),
        //                             VideoProgressIndicator(
        //                               _controller,
        //                               allowScrubbing: true,
        //                               padding: const EdgeInsets.symmetric(horizontal: 10),
        //                             ),
        //                             Padding(
        //                               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        //                               child: Row(
        //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                                 children: [
        //                                   Row(
        //                                     children: [
        //                                       ValueListenableBuilder<VideoPlayerValue>(
        //                                         valueListenable: _controller,
        //                                         builder: (_, videoPlayerValue, __) {
        //                                           return Text(
        //                                             getFullTime(videoPlayerValue.position.inSeconds),
        //                                             style: const TextStyle(color: Colors.white),
        //                                           );
        //                                         },
        //                                       ),
        //                                       Text(
        //                                         '/${getFullTime(_controller.value.duration.inSeconds)}',
        //                                         style: const TextStyle(color: Colors.white),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                   IconButton(
        //                                       onPressed: () {
        //                                       },
        //                                       icon:  const Icon(Icons.fullscreen, color: Colors.white)
        //                                   )
        //
        //                                 ],
        //                               ),
        //                             ),
        //                           ],
        //                         )
        //
        //                       ),
        //                     ),
        //                   ],
        //                 ) :
        //                 const SizedBox(height: 0),
        //
        //           ],
        //         )
        //       ),
        //     ),
        //   ],
        // )
        // : const Center(
        //   child: CircularProgressIndicator(),
        // ) ,
      ),
    );
  }
}


