// ignore_for_file: unused_import
// ignore_for_file: duplicate_import

// expect_lint: no_unrelated_src_imports
import 'package:app/auth/src/sign_in_section.dart';
// expect_lint: no_unrelated_src_imports
import 'package:app/home/src/settings_tab/src/privacy_section.dart';
// GOOD: package `src` import from the same directory
import 'package:app/home/src/social_tab/src/posts_list.dart';

// expect_lint: no_unrelated_src_imports
import '../../../../auth/src/sign_in_section.dart';
// expect_lint: no_unrelated_src_imports
import '../settings_tab/src/privacy_section.dart';
// GOOD: relative `src` import from the same directory
import 'src/posts_list.dart';
