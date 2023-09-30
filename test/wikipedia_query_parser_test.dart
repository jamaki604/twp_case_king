import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:twp_case_king/parse_result.dart';
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

    expect(revision[0].username, 'OAbot');
  });

  test('The redirect can be parsed from the json.', () {
    final file = File('test/disney.json');
    final string = file.readAsStringSync();

    final parser = WikipediaRevisionParser();
    final ParseResult result = parser.parseQuery(string);
    final Redirect? redirect = result.redirect;

    expect(redirect?.to, "The Walt Disney Company");
  });

  test("This page does not exist", () {
    final file = File('test/jacobking.json');
    final string = file.readAsStringSync();

    final parser = WikipediaRevisionParser();
    final ParseResult result = parser.parseQuery(string);

    expect(result.pageExists, false);
  });


}




