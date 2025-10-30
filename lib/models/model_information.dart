class WickModelModelInformation {
  final String modelName;
  final String importPath;
  final Map<String, String> attributes;
  final bool isAbstract;
  final String? parentModelName;
  final Set<String> attributeTypeDependencyImportPaths;
  final Set<String> constructorParameters;

  WickModelModelInformation({
    required this.modelName,
    required this.importPath,
    required this.attributes,
    required this.isAbstract,
    required this.parentModelName,
    required this.attributeTypeDependencyImportPaths,
    required this.constructorParameters,
  });
}
