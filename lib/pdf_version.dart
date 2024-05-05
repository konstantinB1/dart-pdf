import 'dart:convert';
import 'dart:typed_data';

// Major, Minor
typedef Version = (int?, int?);

const versionMatcherRE = r'^[%PDF-]+(\d+).(\d+)$';

final class PDFVersion {
  static Version get(Uint8List bytes, Converter d) {
    String head = d.convert(bytes.sublist(0, 8));
    final matches = RegExp(versionMatcherRE).allMatches(head);

    if (matches.isEmpty) {
      throw Exception('Not a valid PDF signature');
    }

    String? major = matches.first.group(1);
    String? minor = matches.first.group(2);

    if (major == null || minor == null) {
      throw Exception('Unable to get valid PDF version');
    }

    return (int.parse(major), int.parse(minor));
  }
}
