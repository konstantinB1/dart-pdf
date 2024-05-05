import 'package:pdf_parser/char_tables.dart';

base class Parser {
  List<int>? bytes;
  int? offset;
  bool expecingObj = true;
  Map<String, Runes> obj = {};
  bool isFirstByte = true;

  Parser({required this.bytes, this.offset = 0}) {
    _start();
  }

  _start() {
    if (expecingObj) {
      _getByte(bytes![offset!]);
    }
  }

  void _getByte(int byte) {
    if (PDFWhitespaceCharTable.isWhiteSpace(byte) && isFirstByte) {
      isFirstByte = false;
      return;
    }
  }
}
