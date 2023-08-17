import 'package:flutter/material.dart';
import 'package:news_reminder_app/http_service.dart';
import 'package:news_reminder_app/package_model.dart';
import 'package:news_reminder_app/scraper_service.dart';

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
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: Center(
          child: ListView(
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      model.title,
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      model.datePosted,
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
                            (e) => ListTile(
                              title: Text(e.title),
                              subtitle: Text(e.datePosted),
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
