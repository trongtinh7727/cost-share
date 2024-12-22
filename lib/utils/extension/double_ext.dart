extension DoubleExtension on double {
  String toCurrency() {
    return '\$${this.toStringAsFixed(2)}';
  }

String toVND({String currency = '₫'}) {
    if (this >= 1e6) {
      return '${(this / 1e6).toStringAsFixed(1)}M $currency'; // Convert to millions
    } else if (this >= 1e3) {
      return '${(this / 1e3).toStringAsFixed(0)}K $currency'; // Convert to thousands
    } else {
      return '${this.toStringAsFixed(0)} $currency'; // Use the full value
    }
  }
}