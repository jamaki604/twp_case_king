import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:twp_case_king/parse_result.dart';
import 'package:twp_case_king/query_updater.dart';
import 'package:twp_case_king/redirect.dart';
import 'package:twp_case_king/revision.dart';
import 'package:twp_case_king/wikipedia_query_parser.dart';

void main() {
  test('The first revision can be parsed from the json.', () {
    final file = File('test/soup.json');
    final string = file.readAsStringSync();

    final parser = WikipediaRevisionParser();
    final ParseResult result = parser.parseQuery(string);
    final List<Revision> revision = result.revisions;

    for (Revision r in revision) {
      print('Username: ${r.username}, Timestamp: ${r.timeStamp}');
    }

    expect(revision[0].username, 'OAbot');
  });

  test('The redirect can be parsed from the json.', () {
    final file = File('test/disney.json');
    final string = file.readAsStringSync();

    final parser = WikipediaRevisionParser();
    final ParseResult result = parser.parseQuery(string);
    final Redirect? redirect = result.redirect;

    if (redirect != null) {
      print('Redirect From: ${redirect.from}, Redirect To: ${redirect.to}');
    }

    expect(redirect?.to, "The Walt Disney Company");
  });

  test("This page does not exist", () {
    final file = File('test/jacobking.json');
    final string = file.readAsStringSync();

    final parser = WikipediaRevisionParser();
    final ParseResult result = parser.parseQuery(string);

    expect(result.pageExists, false);
  });


  test('this is a test to see if url is working', () async{
    final urlThing = QueryUpdater();
    final string = await urlThing.wikipediaPageURL('disney');

    final parser = WikipediaRevisionParser();
    final ParseResult result = parser.parseQuery(string);
    final Redirect? redirect = result.redirect;

    if (redirect != null) {
      print('Redirect From: ${redirect.from}, Redirect To: ${redirect.to}');
    }

    expect(redirect?.to, "The Walt Disney Company");

  });
}




