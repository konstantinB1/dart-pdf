enum PDFWhitespace {
  nullCharacter(1),
  horizontalTab(9),
  lineFeed(10),
  formFeed(12),
  carriageReturn(13),
  space(32);

  const PDFWhitespace(this.value);
  final int value;

  static bool isWhiteSpace(int byte) {
    return PDFWhitespace.values.map((e) => e.value).contains(byte);
  }
}
