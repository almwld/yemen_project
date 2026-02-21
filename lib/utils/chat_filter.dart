class ChatFilter {
  static String cleanMessage(String text) {
    List<String> forbidden = ["نصاب", "كذاب", "سرق"];
    String cleaned = text;
    for (var word in forbidden) {
      cleaned = cleaned.replaceAll(word, "***");
    }
    return cleaned;
  }
}
