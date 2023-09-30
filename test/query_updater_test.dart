import 'package:flutter_test/flutter_test.dart';
import 'package:twp_case_king/parse_result.dart';
import 'package:twp_case_king/query_updater.dart';
import 'package:twp_case_king/redirect.dart';
import 'package:twp_case_king/wikipedia_query_parser.dart';

void main(){
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