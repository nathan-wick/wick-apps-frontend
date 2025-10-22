class WickModelPaginatedResponse<T> {
  final List<T> instances;
  final int totalInstances;

  WickModelPaginatedResponse({
    required this.instances,
    required this.totalInstances,
  });
}
