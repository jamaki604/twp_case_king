import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:twp_case_king/query_updater.dart';
import 'package:twp_case_king/revision.dart';
import 'package:twp_case_king/wikipedia_revision_parser.dart';

void main() {
  test('This is a test to see if we can read the Json file', () {
    final file = File("test/soup.json");
    final string = file.readAsStringSync();
    expect(string, startsWith(
        '{"continue":{"rvcontinue":"20230607185704|1159023098","continue":"||"}'));
  });

  test('This is a test for word.', () {
    const string = ('word');
    expect(string, 'word');
  });

  test('The first revision can be parsed from the json.', () {
    final file = File('test/soup.json');
    final string = file.readAsStringSync();

    final parser = WikipediaRevisionParser();
    final List<Revision> revision = parser.mostRecentRevision(string);

    for (Revision r in revision) {
      print('Username: ${r.username}, Timestamp: ${r.timeStamp}');
    }

    expect(revision[0].username, 'OAbot');
  });

  test(
      'This is a test to see if we can replicate extracting a user from different file.', () {
    final file = File('test/anime.json');
    final string = file.readAsStringSync();

    final parser = WikipediaRevisionParser();
    final user = parser.mostRecentRevision(string);
    expect(user, 'Squared.Circle.Boxing');
  });

  test(
      'This is a test to see if we can replicate extracting a user from different file.', () {
    final file = File('test/disney.json');
    final string = file.readAsStringSync();

    final parser = WikipediaRevisionParser();
    final user = parser.mostRecentRevision(string);
    print(user);
    expect(user, 'The Herald');
  });

  test('This is a test to see if we can extract a timestamp', () {
    final file = File('test/disney.json');
    final string = file.readAsStringSync();

    final parser = WikipediaRevisionParser();
    final timestamp = parser.mostRecentTimestamp(string);
    print(timestamp);
    expect(timestamp, '2023-09-23T14:29:10Z');
  });

  test(
      'This is a test to see if we can extract the user timestamp data and no more then 30', () {
    final file = File('test/1993.json');
    final string = file.readAsStringSync();

    final parser = WikipediaRevisionParser();
    final timestamp = parser.revisionUserTimestampList(string);
    print(timestamp);
    expect(timestamp, contains('2023-08-04T13:22:13Z'));
  });

  test('This is a test to see if we can handle redirects', () {
    final file = File('test/disney.json');
    final string = file.readAsStringSync();

    final parser = WikipediaRevisionParser();
    final redirect = parser.didItRedirect(string);
    print(redirect);
    expect(redirect, startsWith('Redirected'));
  });

  test('This is a test to see if we can handle non-existent pages', () {
    final file = File('test/jacobking.json');
    final string = file.readAsStringSync();

    final parser = WikipediaRevisionParser();
    final noPage = parser.pageDoesNotExist(string);
    print(noPage);
    expect(noPage, 'Page does not exist');
  });

  test(
      'This is a test to see if we can checkbox everything but network error', () {
    final file = File('test/soup.json');
    final string = file.readAsStringSync();

    final parser = WikipediaRevisionParser();
    final workPlease = parser.allTogetherNow(string);
    print(workPlease);
    expect(workPlease, isNotEmpty);
  });

  test('this is a test to see if url is working', () async{
    final urlThing = QueryUpdater();
    final string = await urlThing.wikipediaPageURL('disney');

    final parser = WikipediaRevisionParser();
    final workPleasee = parser.allTogetherNow(string);
    print(workPleasee);
    expect(workPleasee, contains('Kline'));
  });
}




