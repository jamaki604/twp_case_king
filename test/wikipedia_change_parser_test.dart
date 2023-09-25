import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:twp_case_king/wikipedia_revision_parser.dart';

void main() {
  test('This is a test to see if we can read the Json file', () {
    final file = File("test/soup.json");
    final string = file.readAsStringSync();
    expect(string, startsWith('{"continue":{"rvcontinue":"20230607185704|1159023098","continue":"||"}'));
  });

  test('This is a test for word.', () {
    const string = ('word');
    expect(string, 'word');
  });

  test('This is a test to see if we can extract a user.', () {
    final file = File('test/soup.json');
    final string = file.readAsStringSync();

    final parser = WikipediaChangeParser();
    final user = parser.mostRecentUser(string);
    expect(user, 'OAbot');
  });

  test('This is a test to see if we can replicate extracting a user from different file.', () {
    final file = File('test/anime.json');
    final string = file.readAsStringSync();

    final parser = WikipediaChangeParser();
    final user = parser.mostRecentUser(string);
    expect(user, 'Squared.Circle.Boxing');
  });

  test('This is a test to see if we can replicate extracting a user from different file.', () {
    final file = File('test/disney.json');
    final string = file.readAsStringSync();

    final parser = WikipediaChangeParser();
    final user = parser.mostRecentUser(string);
    print(user);
    expect(user, 'Kline');
  });

  test('This is a test to see if we can extract a timestamp', (){
    final file = File('test/disney.json');
    final string = file.readAsStringSync();

    final parser = WikipediaChangeParser();
    final timestamp = parser.mostRecentTimestamp(string);
    print(timestamp);
    expect(timestamp, '2023-09-18T16:11:29Z');
  });

  test('This is a test to see if we can extract the second timestamp', (){
    final file = File('test/disney.json');
    final string = file.readAsStringSync();

    final parser = WikipediaChangeParser();
    final timestamp = parser.revisionUserTimestampList(string);
    print(timestamp);
    expect(timestamp, contains('2023-09-15T21:04:23Z'));
  });

  test('This is a test to see if we can handle redirects', () {
    final file = File('test/disney.json');
    final string = file.readAsStringSync();

    final parser = WikipediaChangeParser();
    final redirect = parser.didItRedirect(string);
    print(redirect);
    expect(redirect, startsWith('Redirected'));
  });

  test('This is a test to see if we can handle non-existent pages', () {
    final file = File('test/jacobking.json');
    final string = file.readAsStringSync();

    final parser = WikipediaChangeParser();
    final noPage = parser.pageDoesNotExist(string);
    print(noPage);
    expect(noPage, 'Page does not exist');
  });
}




