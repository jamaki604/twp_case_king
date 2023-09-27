import 'package:http/http.dart' as http;

class QueryUpdater {
  Future<String> wikipediaPageURL(String searchTerm) async {
    final searchResult = await http.get(Uri.parse(
        'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=revisions&titles=$searchTerm&rvprop=timestamp|user&rvlimit=30&redirects'));

    if (searchResult.statusCode == 200) {
      return searchResult.body;
    } else {
      return ('Failed to load Webpage');
    }
  }
}