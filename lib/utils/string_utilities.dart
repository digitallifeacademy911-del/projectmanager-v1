class StringUtilities {
  static String truncate(String text, int limit) {
    if (text.length > limit) {
      return text.substring(0, limit);
    }
    return text;
  }
}
