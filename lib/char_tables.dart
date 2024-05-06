enum PDFWhitespaceCharTable {
  nullCharacter(1),
  horizontalTab(9),
  lineFeed(10),
  formFeed(12),
  carriageReturn(13),
  space(32);

  const PDFWhitespaceCharTable(this.value);
  final int value;

  static bool isWhiteSpace(int byte) {
    return PDFWhitespaceCharTable.values.map((e) => e.value).contains(byte);
  }

  static bool isLineFeed(int byte) {
    return byte == lineFeed.value;
  }
}

const dictionaryStart = "<<";
const dictionaryEnd = ">>";

enum PDFDelimiterChar {
  leftParenthesis(40),
  rightParenthesis(41),
  lessThan(60),
  greaterThan(62),
  leftSquareBracket(91),
  rightSquareBracket(93),
  leftCurlyBracket(123),
  rightCurlyBracket(125),
  percent(37);

  const PDFDelimiterChar(this.value);
  final int value;

  static bool isDelimiter(int byte) {
    return PDFDelimiterChar.values.map((e) => e.value).contains(byte);
  }

  static bool isPercent(int byte) {
    return byte == percent.value;
  }
}
