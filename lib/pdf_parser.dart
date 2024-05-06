import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:pdf_parser/identity.dart';
import 'package:pdf_parser/parser.dart';
import 'package:pdf_parser/pdf_version.dart';

const versionMatcherRE = r'^[%PDF-]+(\d+).(\d+)$';

typedef Ref = Map<String, dynamic>;

final class PDFExtractor {
  Uint8List? bytes;
  PDFIdentity? identity;
  Version? version;
  int offset = 0;

  PDFExtractor({required this.bytes}) {
    version = PDFVersion.get(bytes!, Latin1Decoder());
    identity = PDFIdentity(bytes: bytes);

    _refs();
  }

  _refs() {
    if (identity!.hasSignature && identity!.offset != 0) {
      offset = identity!.offset!;
    }

    Parser p = Parser(bytes: bytes, offset: offset);
  }
}

void main() async {
  final file = File('lib/racun.pdf');
  final bytes = await file.readAsBytes();
  final extractor = PDFExtractor(bytes: bytes);
}
