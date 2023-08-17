import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:news_reminder_app/package_model.dart';

class ScraperService {
  List<PackageModel> extractPosts(List<dynamic> postsColumn) {
    List<PackageModel> posts = [];

    for (var element in postsColumn) {
      var postTitles = element.findAll("h2", class_: "post-title");
      var postTimestamps = element.findAll("time", class_: "entry-date published");

      for (int i = 0; i < postTitles.length && i < postTimestamps.length; i++) {
        var postTitle = postTitles[i];
        var postTimestamp = postTimestamps[i];

        var title = postTitle.text;
        var timestamp = postTimestamp.text;

        PackageModel model = PackageModel(title: title, datePosted: timestamp);
        posts.add(model);
      }
    }

    return posts;
  }

  static PackageModel getHeader({required String html}) {
    PackageModel model = PackageModel(title: "loading...", datePosted: "loading...");
    try {
      final soup = BeautifulSoup(html);
      final item = soup.find('div', class_: 'post-heading');

      final postTitle = item?.find("h1")?.text;
      final datePosted = item?.find('time', class_: "entry-date published")?.text;

      model = PackageModel(title: postTitle ?? '', datePosted: datePosted ?? '');

      return model;
    } catch (e) {
      print('Failed to fetch website content');
      return model;
    }
    return model;
  }

  List<PackageModel> getPreviousPosts({required String html_doc}) {
    try {
      final soup = BeautifulSoup(html_doc);
      final postsColumn = soup.findAll('div',
          class_: "col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1");
      return extractPosts(postsColumn);
    } catch (error) {
      print('Failed to fetch website content');
      return [];
    }
    return [];
  }
}
