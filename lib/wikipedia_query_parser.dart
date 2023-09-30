import 'dart:convert';

import 'package:twp_case_king/parse_result.dart';
import 'package:twp_case_king/redirect.dart';
import 'package:twp_case_king/revision.dart';

class WikipediaRevisionParser {

  ParseResult mostRecentRevision(String jsonData) {
    final decoded = jsonDecode(jsonData);
    final pagesMap = decoded['query']['pages'];
    final pageId = pagesMap.keys.first;
    final bool pageExists = pageId != "-1";

    if(!pagesMap.containsKey(pageId)) {
      return ParseResult([], null, false);
    }

    final revisionJson = pagesMap[pageId]['revisions'];

    if(revisionJson == null || revisionJson.isEmpty) {
      return ParseResult([], null, pageExists);
    }

    final redirects = decoded['query']['redirects'];
    Redirect? redirect;
    if (redirects != null && redirects.isNotEmpty) {
      final redirectData = redirects[0];
      redirect = new Redirect(redirectData['from'], redirectData['to']);
    }

    List<Revision> Revisions = [];

    for (int i = 0; i < revisionJson.length; i++) {
      final object = revisionJson[i];
      final Revision revision = new Revision(object['user'], object['timestamp']);
      Revisions.add(revision);
    }

    return ParseResult(Revisions, redirect, pageExists);
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

    final formattedList = maybeThirtyRevisionList
        .asMap()
        .entries
        .map((entry) {
      final lineNumber = entry.key + 1;
      final revision = entry.value;
      final user = revision['user'];
      final timestamp = revision['timestamp'];
      final formattedTimestamp = DateTime.parse(timestamp).toUtc().toIso8601String();

      return '\n$lineNumber. User: $user \n     Timestamp: $formattedTimestamp';
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
        return 'There was no redirect';
      }
    } catch (e) {
      return "Error decoding JSON: $e";
    }
  }

  pageDoesNotExist(String jsonData) {
    final decoded = jsonDecode(jsonData);
    final pagesMap = decoded['query']['pages'];
    final pageId = pagesMap.keys.first;

    if (pageId == '-1') {
      return 'Page does not exist';
    } else {
      return 'page exists';
    }
  }

  allTogetherNow(String jsonData) {
    final decoded = jsonDecode(jsonData);
    final pagesMap = decoded['query']['pages'];
    final pageId = pagesMap.keys.first;

    if (pageId == '-1') {
      return 'Page does not exist';
    }else if (pageId != '1'){
    final result = didItRedirect (jsonData);
    final userTimestampList = revisionUserTimestampList(jsonData);
    return result + '\n' + userTimestampList;
  }else {
    final userTimestampList = revisionUserTimestampList(jsonData);
    return userTimestampList;
    }
  }




}



