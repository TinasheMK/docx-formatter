import 'dart:io';

import 'package:docx_template/docx_template.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../../providers/Memo.dart';
import '../../providers/registration/Company.dart';
import '../../providers/registration/Invoice.dart';

///
/// Read file template.docx, produce it and save
///
Future <String> invoiceGenerator(Invoice invoice, String code) async {
  try {
    // final f = File("assets/templates/invoicetemplate1.docx");

    final data = await rootBundle.load('assets/templates/invoicetemplate1.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);


    // final docx = await DocxTemplate.fromBytes(await f.readAsBytes());

    final invoiceItems = invoice.invoiceitems != null ? invoice.invoiceitems! : [];
    final payments = invoice.payments != null ? invoice.payments! : [];

    final paymentList = <RowContent>[];
    final invoiceItemList = <RowContent>[];


    Content content = Content();

    for (var n in invoiceItems) {
      final c = RowContent()
        ..add(TextContent("unit",n.units))
        ..add(TextContent("description", n.description))
        ..add(TextContent("uprice", n.unitPrice))
        ..add(TextContent("amount", n.total))
      ;
      invoiceItemList.add(c);
    }
    for (var n in payments) {
      final c = RowContent()
        ..add(TextContent("pdate",n.paymentDate))
        ..add(TextContent("pref", n.ref))
        ..add(TextContent("pamount", n.total))
      ;
      paymentList.add(c);
    }




    content
      ..add(TextContent("fromcompany", invoice.companyFull?.companyName))
      ..add(TextContent("fromaddress", invoice.companyFull?.street ?? "N/A"))
      ..add(TextContent("fromcity", invoice.companyFull?.city ?? "N/A"))
      ..add(TextContent("fromcountry", invoice.companyFull?.country ?? "N/A"))
      ..add(TextContent("fromphone", invoice.companyFull?.telephone ?? "N/A"))

      ..add(TextContent("tocompany", invoice.clientFull?.companyName))
      ..add(TextContent("toaddress", invoice.clientFull?.street ?? "N/A"))
      ..add(TextContent("tocity", invoice.clientFull?.city ?? "N/A"))
      ..add(TextContent("tocountry", invoice.clientFull?.country ?? "N/A"))

      ..add(TextContent("idate", invoice.invoiceDate.toString().split(" ")[0]))
      ..add(TextContent("idue", invoice.dueDate.toString().split(" ")[0]))
      ..add(TextContent("sub", invoice.subTotalAmount))
      ..add(TextContent("credit", 0))
      ..add(TextContent("tdue", invoice.totalAmount))
      ..add(TextContent("invoice", invoice.id))

      ..add(TableContent("table", invoiceItemList,))
      ..add(TableContent("table2", paymentList,))
    ;


    final docGen = await docx.generate(content);

    final directory = await getDownloadPath();
    print(directory);

    new File("${directory}${invoice
        .id}_invoice.docx").create(recursive: true)
        .then((File file) async {
      if (docGen != null) await file.writeAsBytes(docGen);
    });

    return "Invoice created successfully. Check your downloads folder in invoices folder.";
  }catch(e){
    return e.toString();
  }

}


Future<String?> getDownloadPath() async {
  Directory? directory;
  String directoryStr;
  try {
    if (Platform.isIOS ) {
      directory = await getApplicationDocumentsDirectory();
    } else if (Platform.isWindows) {
      directory = await getApplicationDocumentsDirectory();
      directoryStr =  "${directory.path}\\Invoices\\";
      directory = Directory(directoryStr);

    } else {
      directory = Directory('/storage/emulated/0/Download/Invoices/');
      // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
      // ignore: avoid_slow_async_io
      if (!await directory.exists()) directory = await getExternalStorageDirectory();
    }
  } catch (err, stack) {
    print("Cannot get download folder path");
  }
  return directory?.path;
}
