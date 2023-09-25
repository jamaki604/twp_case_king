import 'dart:convert';

class WikipediaChangeParser {

  final i = 0;

  mostRecentUser(String jsonData) {
    final decoded = jsonDecode(jsonData);
    final pagesMap = decoded['query']['pages'];
    final pageId = pagesMap.keys.first;
    final username = pagesMap[pageId]['revisions'][0]['user'];

    return username;
  }

  mostRecentTimestamp(String jsonData) {
    final decoded = jsonDecode(jsonData);
    final pagesMap = decoded['query']['pages'];
    final pageId = pagesMap.keys.first;
    final timestamp = pagesMap[pageId]['revisions'][0]['timestamp'];


    return timestamp;
  }

  revisionUserTimestampList(String jsonData) {
    //this helped up figure out how to create list of users and timestamps
    final decoded = jsonDecode(jsonData);
    final pagesMap = decoded['query']['pages'];
    final pageId = pagesMap.keys.first;
    final revisionsList = List.from(pagesMap[pageId]['revisions']);

    //final revisionsLength = revisionsList.length;
    //final timestamp = pagesMap[pageId]['revisions'][i]['timestamp'];

    return revisionsList;
  }


  didItRedirect(String jsonData) {
    try {
      final decoded = jsonDecode(jsonData);
      final redirects = decoded['query']['redirects'];

      if (redirects != null && redirects.isNotEmpty) {
        final firstRedirect = redirects[0];
        final from = firstRedirect['from'];
        final to = firstRedirect['to'];

        return "Redirected From: $from \nTo: $to";
      } else {
        return null; // Return null when there are no redirects.
      }
    } catch (e) {
      return "Error decoding JSON: $e";
    }
  }
}


