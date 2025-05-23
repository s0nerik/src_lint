import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:path/path.dart' as path;

class NoUnrelatedSrcImportsRule extends DartLintRule {
  const NoUnrelatedSrcImportsRule()
    : super(
        code: const LintCode(
          name: 'no_unrelated_src_imports',
          problemMessage:
              'Imports from unrelated "src" directories are not allowed.',
          correctionMessage:
              'Ensure the imported file is exported from outside the "src" directory.',
          errorSeverity: ErrorSeverity.ERROR,
        ),
      );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addImportDirective((node) {
      final importUri = node.uri.stringValue;
      if (importUri == null) return;

      late String importPath;
      if (importUri.startsWith('package:')) {
        // Handle package imports
        final packagePath = importUri.substring('package:'.length);
        // Remove the package name part (e.g., 'app/' from 'app/auth/src/file.dart')
        final parts = packagePath.split('/');
        if (parts.length > 1) {
          importPath = parts.sublist(1).join('/'); // Remove package name
        } else {
          return; // Skip malformed package imports
        }
      } else if (importUri.startsWith('dart:')) {
        // Skip dart core imports
        return;
      } else {
        // Handle relative imports
        importPath = importUri;
      }

      // Check if the import path contains 'src'
      final importParts = importPath.split('/');
      final importSrcIndex = importParts.indexOf('src');
      if (importSrcIndex == -1) return; // Not importing from src directory

      // Get the current file's path relative to the lib directory
      final currentPath = resolver.path;
      final libIndex = currentPath.indexOf('/lib/');
      if (libIndex == -1) return; // Not in lib directory

      final currentRelativePath = currentPath.substring(
        libIndex + 5,
      ); // Remove '/lib/' prefix
      final currentParts = currentRelativePath.split('/');

      // For relative imports, resolve them first
      if (!importUri.startsWith('package:')) {
        // Resolve relative import path
        final currentDir = path.dirname(currentRelativePath);
        final resolvedImportPath = path.normalize(
          path.join(currentDir, importPath),
        );
        importPath = resolvedImportPath;
      }

      // Re-parse the import path after potential resolution
      final finalImportParts = importPath.split('/');
      final finalImportSrcIndex = finalImportParts.indexOf('src');
      if (finalImportSrcIndex == -1)
        return; // Not importing from src after resolution

      // Determine the hierarchies
      final currentSrcIndex = currentParts.indexOf('src');

      // For the current file: get the path up to the directory containing src or the file itself
      List<String> currentHierarchy;
      if (currentSrcIndex != -1) {
        // Current file is inside a src directory
        currentHierarchy = currentParts.sublist(0, currentSrcIndex);
      } else {
        // Current file is outside any src directory
        // Remove the filename to get the directory path
        currentHierarchy = currentParts.sublist(0, currentParts.length - 1);
      }

      // For the imported file: get the path up to the src directory
      final importHierarchy = finalImportParts.sublist(0, finalImportSrcIndex);

      // Check if the import is from the same hierarchy
      // Files can only import from src directories in the exact same hierarchy
      bool isRelated = _listEquals(currentHierarchy, importHierarchy);

      // Additional check: if both files are in src directories, they must be in the same src subtree
      if (isRelated && currentSrcIndex != -1) {
        // Both files are in src directories and in the same parent hierarchy
        // Check if they're in the same src subtree
        final currentSrcSubtree = currentParts.sublist(0, currentSrcIndex + 2);
        final importSrcSubtree = finalImportParts.sublist(
          0,
          finalImportSrcIndex + 2,
        );

        // They must be in the same src subtree (e.g., both in home/src/social_tab)
        if (!_listEquals(currentSrcSubtree, importSrcSubtree)) {
          isRelated = false;
        }
      }

      // Special handling for files like home_page.dart:
      // If current file is outside any src directory but trying to import from nested src,
      // it should only be allowed to import from direct child src directories,
      // not from nested src directories within those child directories
      if (isRelated && currentSrcIndex == -1) {
        // Current file is outside src, check if import is from nested src
        final remainingImportParts = finalImportParts.sublist(
          finalImportSrcIndex + 1,
        );
        if (remainingImportParts.contains('src')) {
          // The import contains another 'src' after the first one, making it nested
          isRelated = false;
        }
      }

      if (!isRelated) {
        reporter.atNode(node, code);
      }
    });
  }

  @override
  List<Fix> getFixes() => const [];
}

bool _listEquals(List<String> a, List<String> b) {
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
