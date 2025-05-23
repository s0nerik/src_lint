# src_lint

This lint prevents imports from `src` directories of unrelated file hierarchies.

Basically, the same as the built-in [implementation_imports](https://dart.dev/tools/linter-rules/implementation_imports) lint, but for `src` imports within the same package.

So, given this project structure:

```bash
📁 lib
├── 📄 app.dart
├── 📁 auth
│   ├── 📄 auth_page.dart
│   └── 📁 src
│       └── 📄 sign_in_section.dart
└── 📁 home
    ├── 📄 home_page.dart
    └── 📁 src
        ├── 📁 social_tab
        │   ├── 📄 social_tab.dart
        │   └── 📁 src
        │       └── 📄 posts_list.dart
        └── 📁 settings_tab
            ├── 📄 settings_tab.dart
            └── 📁 src
                └── 📄 privacy_section.dart
```

**BAD**:
```dart
// 📄 app.dart

import 'auth/src/sign_in_section.dart';
import 'package:app/auth/src/sign_in_section.dart';

import 'home/src/social_tab/social_tab.dart';
import 'package:app/home/src/social_tab/social_tab.dart';

import 'home/src/social_tab/src/posts_list.dart';
import 'package:app/home/src/social_tab/src/posts_list.dart';

import 'home/src/settings_tab/settings_tab.dart';
import 'package:app/home/src/settings_tab/settings_tab.dart';

import 'home/src/settings_tab/src/privacy_section.dart';
import 'package:app/home/src/settings_tab/src/privacy_section.dart';
```

**BAD**:
```dart
// 📄 social_tab.dart

import '../settings_tab/src/privacy_section.dart';
import 'package:app/home/src/settings_tab/src/privacy_section.dart';

import '../../../../auth/src/sign_in_section.dart';
import 'package:app/auth/src/sign_in_section.dart';
```

**GOOD**:
```dart
// 📄 app.dart

import 'auth/auth_page.dart';
import 'package:app/auth/auth_page.dart';

import 'home/home_page.dart';
import 'package:app/home/home_page.dart';
```

**GOOD**:
```dart
// 📄 home_page.dart

import 'src/social_tab/social_tab.dart';
import 'package:app/home/src/social_tab/social_tab.dart';

import 'src/settings_tab/settings_tab.dart';
import 'package:app/home/src/settings_tab/settings_tab.dart';
```

**GOOD**:
```dart
// 📄 social_tab.dart

import 'src/posts_list.dart';
import 'package:app/home/src/social_tab/src/posts_list.dart';
```

## Installation

Add `src_lint` and `custom_lint` to your `pubspec.yaml`
```bash
flutter pub add --dev src_lint
flutter pub add --dev custom_lint
```
Update the `analysis_options.yaml` to include
```yaml
analyzer:
  plugins:
    - custom_lint
```

## Credits

This package is inspired by [subpackage_lint](https://pub.dev/packages/subpackage_lint) and solves the same problem, but with less ceremony required.