import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_reminder_app/http_service.dart';
import 'package:news_reminder_app/package_model.dart';
import 'package:news_reminder_app/scraper_service.dart';
import 'package:news_reminder_app/test_data.dart';

import 'app bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  List<PackageModel> packageModels = [];
  PackageModel model = PackageModel(title: "loading...", datePosted: "loading...");

  initState() {
    super.initState();
    _fetchWebsiteHeader();
    _fetchWebsitePreviousPosts();
  }

  Future<void> _fetchWebsiteHeader() async {
    setState(() {
      isLoading = true;
    });
    final baseHTML = await HttpService().get();
    if (baseHTML != null) {
      final _packageModel = ScraperService.getHeader(html: baseHTML);
      setState(() {
        this.model = _packageModel;
        isLoading = false;
      });
    }
  }

  Future<void> _fetchWebsitePreviousPosts() async {
    setState(() {
      packageModels.clear();
      isLoading = true;
    });
    final basePostsHTML = await HttpService().get();
    if (basePostsHTML != null) {
      final _posts = ScraperService().getPreviousPosts(html_doc: basePostsHTML);
      setState(() {
        this.packageModels = _posts;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(context, widget.title),
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.7),
                        BlendMode.darken,
                      ),
                      image: NetworkImage(
                        headerImage,
                        // testNewsImages[0]
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.005,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Breaking News",
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          model.title,
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          model.datePosted,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.transparent,
                            side: const BorderSide(color: Colors.red),
                          ),
                          onPressed: () {},
                          child: const Text("Read More"),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(20),
                    //   topRight: Radius.circular(20),
                    // ),
                    color: Colors.black,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: const Text(
                            "Previous Posts",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.sort_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: packageModels.isNotEmpty
                              ? packageModels
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        title: Text(
                                          e.title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        subtitle: Text(
                                          e.datePosted,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.black12,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                testNewsImages[Random()
                                                    .nextInt(testNewsImages.length)],
                                                // testNewsImages[0],
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList()
                              : const [
                                  Text(
                                    'No posts found',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: isLoading
              ? () {}
              : () async {
                  await _fetchWebsiteHeader();
                  await _fetchWebsitePreviousPosts();
                },
          child: const Icon(Icons.refresh),
        ));
  }
}
