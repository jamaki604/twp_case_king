import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('This is a test to see if we can read the Json file', (){
    final file = File("test/soup.json");
    final string = file.readAsStringSync();
    expect(string, startsWith('{"continue":{"rvcontinue":"20230607185704|1159023098","continue":"||"}'));
  });
}