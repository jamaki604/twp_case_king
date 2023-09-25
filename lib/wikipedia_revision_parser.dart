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

  String revisionUserTimestampList(String jsonData) {
    final decoded = jsonDecode(jsonData);
    final pagesMap = decoded['query']['pages'];
    final pageId = pagesMap.keys.first;
    final revisionsList = List.from(pagesMap[pageId]['revisions']);
    final maybeThirtyRevisionList = revisionsList.take(30).toList();

    final formattedList = maybeThirtyRevisionList.asMap().entries.map((entry) {
      final lineNumber = entry.key + 1;
      final revision = entry.value;
      final user = revision['user'];
      final timestamp = revision['timestamp'];
      return '\n$lineNumber. User: $user \n     Timestamp: $timestamp';
    }).toList();

    final formattedString = formattedList.join('\n');

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

  allTogetherNow(String jsonData){
    final decoded = jsonDecode(jsonData);
    final pagesMap = decoded['query']['pages'];
    final pageId = pagesMap.keys.first;

    if (pageId == '-1'){
      return  'Page does not exist';
    }else {
      final result = didItRedirect(jsonData);
      print(result);
    }
    final userTimestampList = revisionUserTimestampList(jsonData);
    return userTimestampList;
  }
}


