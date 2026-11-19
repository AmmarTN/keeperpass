import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/app_info.dart';

void main() {
  test('About shows the version pubspec.yaml builds', () {
    final RegExpMatch? version = RegExp(
      r'^version:\s*(\S+)\+(\d+)\s*$',
      multiLine: true,
    ).firstMatch(File('pubspec.yaml').readAsStringSync());

    expect(version, isNotNull);
    expect(AppInfo.version, version!.group(1));
    expect(AppInfo.build, int.parse(version.group(2)!));
  });
}
