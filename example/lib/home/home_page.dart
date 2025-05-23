// ignore_for_file: unused_import
// ignore_for_file: duplicate_import

// GOOD: package `src` import from the same directory
import 'package:app/home/src/settings_tab/settings_tab.dart';
// expect_lint: no_unrelated_src_imports
import 'package:app/home/src/settings_tab/src/privacy_section.dart';
// GOOD: package `src` import from the same directory
import 'package:app/home/src/social_tab/social_tab.dart';
// expect_lint: no_unrelated_src_imports
import 'package:app/home/src/social_tab/src/posts_list.dart';

// GOOD: relative `src` import from the same directory
import 'src/settings_tab/settings_tab.dart';
// expect_lint: no_unrelated_src_imports
import 'src/settings_tab/src/privacy_section.dart';
// GOOD: relative `src` import from the same directory
import 'src/social_tab/social_tab.dart';
// expect_lint: no_unrelated_src_imports
import 'src/social_tab/src/posts_list.dart';
