import 'dart:convert';

class WikipediaChangeParser{
  mostRecentUser(String jsonData) {
    final decoded = jsonDecode(jsonData);
    final pagesMap = decoded['query']['pages'];
    final pageId = pagesMap.keys.first;
    final username = pagesMap[pageId]['revisions'][0]['user'];

    return username;
  }

  mostRecentTimestamp(String jsonData){
    final decoded = jsonDecode(jsonData);
    final pagesMap = decoded['query']['pages'];
    final pageId = pagesMap.keys.first;
    final timestamp = pagesMap[pageId]['revisions'][0]['timestamp'];


    return timestamp;
  }


  }

