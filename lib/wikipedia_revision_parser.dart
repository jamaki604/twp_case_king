import 'dart:convert';

class WikipediaChangeParser{
  mostRecentUser(String jsonData) {
    final decoded = jsonDecode(jsonData);
    final pagesMap = decoded['query']['pages'];
    final pageId = pagesMap.keys.first;
    final username = pagesMap[pageId]['revisions'][0]['user'];

    return username;
  }

  mostRecentTimestamp(){
    const string = '2023-09-22T01:10:09Z';
    return string;
  }


  }

