import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:test_app/video.dart';

class VideoListPage extends StatefulWidget {
  final String token;

  const VideoListPage({
    super.key,
    required this.token
  });

  @override
  State<VideoListPage> createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {

  final authUrl = Uri.https('cabinet.komiesc.ru', 'misc/test_data/videoList.json');
  final client = RetryClient(http.Client());

  late List<Map<String, dynamic>> videoList;
  late List<Map<String, dynamic>> viewVideoList;

  bool loading = true;
  String linkVideo = '';

  void tap(index, context) {
    if (index == 0) {
      Navigator.pop(context);
    }
  }
  
  @override
  void initState() {
    super.initState();
     getVideoList();
  }

  void getVideoList () async {
    videoList = [
      {'name': 'sample.mp4', 'date': '03-04-2024', 'link': 'http://media.tehnologia.com/sample.mp4?token='},
      {'name': 'sample10mb.mp4', 'date': '03-04-2024', 'link': 'http://media.tehnologia.com/sample10mb.mp4?token='},
      {'name': 'sample25mb.mp4', 'date': '04-04-2024', 'link': 'http://media.tehnologia.com/sample25mb.mp4?token='},
      {'name': 'sample100mb.mp4', 'date': '05-04-2024', 'link': 'http://media.tehnologia.com/sample100mb.mp4?token='},
      {'name': 'sample200mb.mp4', 'date': '05-04-2024', 'link': 'http://media.tehnologia.com/sample200mb.mp4?token='},
      {'name': 'sample.mp4', 'date': '03-04-2024', 'link': 'http://media.tehnologia.com/sample.mp4?token='},
      {'name': 'sample10mb.mp4', 'date': '03-04-2024', 'link': 'http://media.tehnologia.com/sample10mb.mp4?token='},
      {'name': 'sample25mb.mp4', 'date': '04-04-2024', 'link': 'http://media.tehnologia.com/sample25mb.mp4?token='},
      {'name': 'sample100mb.mp4', 'date': '05-04-2024', 'link': 'http://media.tehnologia.com/sample100mb.mp4?token='},
      {'name': 'sample200mb.mp4', 'date': '05-04-2024', 'link': 'http://media.tehnologia.com/sample200mb.mp4?token='},
      {'name': 'sample.mp4', 'date': '03-04-2024', 'link': 'http://media.tehnologia.com/sample.mp4?token='},
      {'name': 'sample10mb.mp4', 'date': '03-04-2024', 'link': 'http://media.tehnologia.com/sample10mb.mp4?token='},
      {'name': 'sample25mb.mp4', 'date': '04-04-2024', 'link': 'http://media.tehnologia.com/sample25mb.mp4?token='},
      {'name': 'sample100mb.mp4', 'date': '05-04-2024', 'link': 'http://media.tehnologia.com/sample100mb.mp4?token='},
      {'name': 'sample200mb.mp4', 'date': '05-04-2024', 'link': 'http://media.tehnologia.com/sample200mb.mp4?token='},
      {'name': 'sample.mp4', 'date': '03-04-2024', 'link': 'http://media.tehnologia.com/sample.mp4?token='},
      {'name': 'sample10mb.mp4', 'date': '03-04-2024', 'link': 'http://media.tehnologia.com/sample10mb.mp4?token='},
      {'name': 'sample25mb.mp4', 'date': '04-04-2024', 'link': 'http://media.tehnologia.com/sample25mb.mp4?token='},
      {'name': 'sample100mb.mp4', 'date': '05-04-2024', 'link': 'http://media.tehnologia.com/sample100mb.mp4?token='},
      {'name': 'sample200mb.mp4', 'date': '05-04-2024', 'link': 'http://media.tehnologia.com/sample200mb.mp4?token='},
      {'name': 'sample.mp4', 'date': '03-04-2024', 'link': 'http://media.tehnologia.com/sample.mp4?token='},
      {'name': 'sample10mb.mp4', 'date': '03-04-2024', 'link': 'http://media.tehnologia.com/sample10mb.mp4?token='},
      {'name': 'sample25mb.mp4', 'date': '04-04-2024', 'link': 'http://media.tehnologia.com/sample25mb.mp4?token='},
      {'name': 'sample100mb.mp4', 'date': '05-04-2024', 'link': 'http://media.tehnologia.com/sample100mb.mp4?token='},
      {'name': 'sample200mb.mp4', 'date': '05-04-2024', 'link': 'http://media.tehnologia.com/sample200mb.mp4?token='},
    ];

    viewVideoList = videoList;
    loading = false;
  }

  void redirect(String link, String title) async {
    Navigator.push(context,  MaterialPageRoute(builder: (BuildContext context) => VideoPage(link: link, title: title, token: widget.token)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video List'),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: loading ?
        const CircularProgressIndicator() :
        Column (
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: TextFormField (
                decoration: const InputDecoration (
                  hintText: 'Введите название видео',
                  icon: Icon(Icons.search),
                ),
                onChanged: ((data) {
                  setState(() {
                    if (data != '') {
                      viewVideoList =
                          videoList.where((element) => element['name'].toString().toLowerCase().contains(data.toLowerCase()))
                              .toList();
                    } else {
                      viewVideoList = videoList;
                    }
                  });
                }),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height - 190,
              child: ListView.builder(
                itemCount: viewVideoList.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (() {
                      redirect(viewVideoList[index]['link'], viewVideoList[index]['name']);
                    }),
                    child: Card(
                      margin: const EdgeInsets.only(top: 5),
                      child: SizedBox(
                        height:  50,
                        width: 400,
                        child:
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                viewVideoList[index]['name'],
                                style: const TextStyle(fontSize: 15)
                              ),
                              Text(
                                viewVideoList[index]['date'],
                                style: const TextStyle(fontSize: 15)
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
