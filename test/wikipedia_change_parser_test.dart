import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:twp_case_king/wikipedia_revision_parser.dart';

void main() {
  test('This is a test to see if we can read the Json file', () {
    final file = File("test/soup.json");
    final string = file.readAsStringSync();
    expect(
        string,
        startsWith(
            '{"continue":{"rvcontinue":"20230607185704|1159023098","continue":"||"}'));
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
    final parser = WikipediaChangeParser();
    final timestamp = parser.mostRecentTimestamp();
    expect(timestamp, '2023-09-22T01:10:09Z');
  });
}




