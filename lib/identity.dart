import 'package:pdf_parser/char_tables.dart';
import 'package:pdf_parser/utils.dart';

final class PDFIdentity {
  List<int>? bytes;
  final _initialOffset = 8;
  int? offset = 0;
  final List<int> identity = [];
  bool hasSignature = false;

  PDFIdentity({required this.bytes}) {
    offset = _initialOffset;
    _parse();
  }

  void _validateAtLeast4Bytes() {
    if (identity.isEmpty) {
      return;
    }

    if (identity.length < 4) {
      throw Exception('Invalid PDF file');
    }
  }

  void _parse() {
    List<int> curOffset = bytes!.sublist(_initialOffset);
    int identityOffset = _initialOffset;
    int i = 0;

    for (; i < curOffset.length; i++) {
      int byte = curOffset[i];

      if (PDFWhitespace.isWhiteSpace(curOffset[i]) ||
          PDFDelimiterChar.isPercent(curOffset[i])) {
        continue;
      }

      if (byte < 128) {
        _validateAtLeast4Bytes();
        break;
      }

      identity.add(byte);
      identityOffset + i;
    }

    if (identity.length >= 4) {
      hasSignature = true;
    }

    offset = identityOffset;
  }
}
