import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:smart_admin_dashboard/screens/invoice/print/templates/invoice4.dart';
import 'package:smart_admin_dashboard/screens/invoice/print/templates/invoice5.dart';

import '../../../core/models/Invoice.dart';
import 'data.dart';
import 'templates/invoice.dart';
import 'templates/invoice2.dart';

const examples = <Example>[
  Example('Wave', 'invoice.dart', generateInvoice),
  Example('Circles', 'invoice4.dart', generateInvoice4),
  Example('Plain', 'invoice5.dart', generateInvoice5),
  Example('Block', 'invoice2.dart', generateInvoice2),
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
