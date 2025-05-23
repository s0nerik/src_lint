import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'src/no_unrelated_src_imports_lint.dart';

PluginBase createPlugin() => _SrcLint();

class _SrcLint extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
    NoUnrelatedSrcImportsRule(),
  ];
}
