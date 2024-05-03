import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:test_app/video_list.dart';

class HomePage extends StatefulWidget {
  final String token;

  const HomePage({
    super.key,
    required this.token
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final authUrl = Uri.https('cabinet.komiesc.ru', 'misc/test_data/videoList.json');
  final client = RetryClient(http.Client());

  CarouselController buttonCarouselController = CarouselController();

   final List cameraList = [
     'camera 1',
     'camera 2',
     'camera 3',
     'camera 4',
     'camera 5',
   ];

  late List<Widget> viewCameraList = cameraList.map((item) => Container(
    child: GestureDetector(
      
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: [
              Image.asset('assets/images/camera.png', fit: BoxFit.cover, width: 1000.0,),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter
                      )
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0
                  ),
                  child: Text(
                    item,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => VideoListPage(token: widget.token)));
      },
    )
  )).toList();

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video List'),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          CarouselSlider(
            disableGesture: true,
            items: viewCameraList,
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
              initialPage: 0
            ),

          )
        ],
      )
    );
  }
}
