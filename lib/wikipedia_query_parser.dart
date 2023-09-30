import 'dart:convert';

import 'package:twp_case_king/parse_result.dart';
import 'package:twp_case_king/redirect.dart';
import 'package:twp_case_king/revision.dart';

class WikipediaRevisionParser {

  ParseResult parseQuery(String jsonData) {
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
      final Revision revision = new Revision(object['user'], DateTime.parse(object['timestamp']));
      Revisions.add(revision);
    }

    return ParseResult(Revisions, redirect, pageExists);
  }






}



