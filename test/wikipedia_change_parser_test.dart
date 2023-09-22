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

  test('This is a test to see if we can extract a word.', () {
    final parser = WikipediaChangeParser();
    final user = parser.getUser();
    expect(user, 'OAbot');
  });
}




