import 'package:pdf_parser/char_tables.dart';
import 'package:pdf_parser/trailer.dart';
import 'package:pdf_parser/utils.dart';

base class Parser {
  List<int>? bytes;
  int? offset;

  Parser({required this.bytes, this.offset = 0}) {
    PDFTrailer t = getTrailer();
  }

  String _getLine(List<int> bytes, int start) {
    List<int> seq = [];
    for (int i = start; i < bytes.length; i++) {
      if (PDFWhitespaceCharTable.isLineFeed(bytes[i])) {
        break;
      }

      seq.add(bytes[i]);
      offset = i;
    }

    return String.fromCharCodes(seq).trim();
  }

  List<String> _getLines({
    required int initialOffset,
    required bool Function(String line) cond,
  }) {
    List<String> lines = [];
    int curOffset = initialOffset;

    for (int i = offset!; i < bytes!.length; i++) {
      var line = _getLine(bytes!, curOffset);

      if (cond(line)) {
        break;
      }

      curOffset += line.length + 1;
      lines.add(line);
    }

    return lines;
  }

  PDFTrailer getTrailer() {
    PDFTrailer t = PDFTrailer();
    int index = findSequenceByString(bytes!, 'trailer');

    for (String line in _getLines(
      initialOffset: index + 3,
      cond: (line) => line == dictionaryEnd,
    )) {
      if (line.startsWith("/Root")) {
        t.rootRef = line.substring(6);
      } else if (line.startsWith("/Size")) {
        t.size = int.parse(line.substring(6));
      } else if (line.startsWith("/Info")) {
        t.infoRef = line.substring(6);
      }
    }

    return t;
  }
}
