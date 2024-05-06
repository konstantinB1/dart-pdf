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

int findSequence(
    {required List<int> source,
    required List<int> sequence,
    bool nextLine = true,
    bool withLastIndex = false}) {
  if (sequence.length > source.length) {
    return -1;
  }

  if (sequence.isEmpty) {
    return -1;
  }

  int len = sequence.length;
  int search = 0;

  for (int i = 0; i < source.length; i++) {
    int cur = sequence[search];

    if (source[i] == cur) {
      search++;
    } else {
      search = 0;
    }

    int? ret;

    if (search == len) {
      ret = withLastIndex ? i + 1 : i - len + 1;
    }

    if (ret != null) {
      if (nextLine) {
        while (PDFWhitespace.isWhiteSpace(source[ret!])) {
          ret = ret + 1;
        }
      }

      return ret;
    }
  }

  return -1;
}

int findSequenceByString(List<int> source, String sequence) {
  return findSequence(
      source: source,
      sequence: sequence.codeUnits,
      withLastIndex: true,
      nextLine: true);
}
