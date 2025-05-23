// ignore_for_file: unused_import
// ignore_for_file: duplicate_import

// GOOD: no `src` in the import path
import 'package:app/auth/auth_page.dart';
// expect_lint: no_unrelated_src_imports
import 'package:app/auth/src/sign_in_section.dart';
// GOOD: no `src` in the import path
import 'package:app/home/home_page.dart';
// expect_lint: no_unrelated_src_imports
import 'package:app/home/src/settings_tab/settings_tab.dart';
// expect_lint: no_unrelated_src_imports
import 'package:app/home/src/settings_tab/src/privacy_section.dart';
// expect_lint: no_unrelated_src_imports
import 'package:app/home/src/social_tab/social_tab.dart';
// expect_lint: no_unrelated_src_imports
import 'package:app/home/src/social_tab/src/posts_list.dart';

// GOOD: no `src` in the import path
import 'auth/auth_page.dart';
// expect_lint: no_unrelated_src_imports
import 'auth/src/sign_in_section.dart';
// GOOD: no `src` in the import path
import 'home/home_page.dart';
// expect_lint: no_unrelated_src_imports
import 'home/src/settings_tab/settings_tab.dart';
// expect_lint: no_unrelated_src_imports
import 'home/src/settings_tab/src/privacy_section.dart';
// expect_lint: no_unrelated_src_imports
import 'home/src/social_tab/social_tab.dart';
// expect_lint: no_unrelated_src_imports
import 'home/src/social_tab/src/posts_list.dart';
