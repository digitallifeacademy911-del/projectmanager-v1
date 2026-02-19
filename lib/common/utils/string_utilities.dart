class StringUtilities {
  static String truncate(String text, int limit) {
    if (text.length > limit - 1) {
      return "${text.substring(0, limit)}...";
    }
    return text;
  }
}
