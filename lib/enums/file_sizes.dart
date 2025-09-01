enum WickFileSize {
  small(2 * 1000000), // 2 MB
  medium(5 * 1000000), // 5 MB
  large(10 * 1000000); // 10 MB

  final int value;

  const WickFileSize(this.value);
}
