import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';

import '../../core/models/Invoice.dart';
import 'data.dart';
import 'templates/invoice.dart';
import 'templates/invoice2.dart';

const examples = <Example>[
  Example('Cars', 'invoice.dart', generateInvoice),
  Example('Pink', 'invoice2.dart', generateInvoice2),
];

typedef LayoutCallbackWithData = Future<Uint8List> Function(
    PdfPageFormat pageFormat, Invoice data);

class Example {
  const Example(this.name, this.file, this.builder, [this.needsData = false]);

  final String name;

  final String file;

  final LayoutCallbackWithData builder;

  final bool needsData;
}
