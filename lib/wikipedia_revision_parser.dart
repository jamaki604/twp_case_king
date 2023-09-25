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
    final maybeThirtyRevisionList = revisionsList.take(30).toList();

    final formattedList = maybeThirtyRevisionList.map((revision) {
      final user = revision['user'];
      final timestamp = revision['timestamp'];
      return 'User: $user Timestamp: $timestamp';
    }).toList();

    final formattedString = formattedList.join('\n'); // Join with line breaks

    return formattedString;
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
        return null;
      }
    } catch (e) {
      return "Error decoding JSON: $e";
    }
  }

  pageDoesNotExist(String jsonData) {
    final decoded = jsonDecode(jsonData);
    final pagesMap = decoded['query']['pages'];
    final pageId = pagesMap.keys.first;

    if (pageId == '-1'){
      return  'Page does not exist';
    }else {
      return 'page exists';
    }
  }
}


