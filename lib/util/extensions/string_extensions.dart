extension StringExtensions on String {
  int parseInt() {
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }

  bool isNumeric() {
    return double.tryParse(this) != null;
  }
}
