import 'dart:io';

import 'package:docx_template/docx_template.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../types/Memo.dart';
import '../models/Business.dart';
import '../models/Invoice.dart';

///
/// Read file template.docx, produce it and save
///
Future <String> invoiceGenerator(Invoice invoice) async {
  // try {
    // final f = File("assets/templates/invoicetemplate1.docx");

    final data = await rootBundle.load('assets/templates/invoicetemplate1.docx');
    final bytes = data.buffer.asUint8List();

    final docx = await DocxTemplate.fromBytes(bytes);

    String? logoPath;

    final directory2 = await getDownloadPath2();
    if(invoice.business!.logo!=null) logoPath = "${directory2}${invoice.business!.logo}";

    var testFileContent;
    var img;
    if(logoPath !=null) {
      var imgFile = await File(logoPath!);
      testFileContent  = imgFile.readAsBytesSync();
      // print("hello img");
      // print(testFileContent);
    }else{
      img = await rootBundle.load('assets/images/logo.png');
      testFileContent = img.buffer.asUint8List();

      // print(testFileContent);
    }



    final invoiceItems = invoice.invoiceItems != null ? invoice.invoiceItems! : [];
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
        ..add(TextContent("pdate",n.paymentDate.toString().split(" ")[0]))
        ..add(TextContent("pref", n.id ?? ""))
        ..add(TextContent("pamount", n.total))
      ;
      paymentList.add(c);
    }

    Content invoiceStatus =
    invoice.invoiceStatus == 'PAID' ? TextContent("paid", 'PAID')
        : invoice.invoiceStatus == 'CANCELLED' ? TextContent("cancelled", 'CANCELLED')
        : invoice.invoiceStatus == 'UNPAID' ? TextContent("unpaid", 'UNPAID')
        : TextContent("draft", 'DRAFT');




    content
      ..add(TextContent("frombusiness", invoice.business?.name))
      ..add(TextContent("fromaddress", invoice.business?.street ?? "N/A"))
      ..add(TextContent("fromcity", invoice.business?.city ?? "N/A"))
      ..add(TextContent("fromcountry", invoice.business?.country ?? "N/A"))
      ..add(TextContent("fromphone", invoice.business?.telephone ?? "N/A"))

      ..add(TextContent("tobusiness", invoice.client?.name))
      ..add(TextContent("toaddress", invoice.client?.street ?? "N/A"))
      ..add(TextContent("tocity", invoice.client?.city ?? "N/A"))
      ..add(TextContent("tocountry", invoice.client?.country ?? "N/A"))

      ..add(TextContent("idate", invoice.invoiceDate.toString().split(" ")[0]))
      ..add(TextContent("idue", invoice.dueDate.toString().split(" ")[0]))
      ..add(TextContent("sub", invoice.subTotalAmount))
      ..add(TextContent("credit", 0))
      ..add(TextContent("tdue", invoice.totalAmount))
      ..add(TextContent("invoice", invoice.id))
      ..add(ImageContent('img', testFileContent))

      ..add(TableContent("table", invoiceItemList,))
      ..add(TableContent("table2", paymentList,))
      ..add(invoiceStatus)

    ;


    final docGen = await docx.generate(content);

    final directory = await getDownloadPath();
    print(directory);

    new File("${directory}${invoice
        .id}_invoice.docx").create(recursive: true)
        .then((File file) async {
      if (docGen != null) await file.writeAsBytes(docGen);
    });

    //Load the existing docx document.
    // final PdfDocument document = PdfDocument(inputBytes: docGen);


// //Save the document.
//   File("${invoice.id}_invoice.pdf").writeAsBytes(await document.save());
// //Dispose the document.
//   document.dispose();


    return "Invoice printed. Check your downloads folder in invoices folder.";
  // }catch(e){
  //   return e.toString();
  // }

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
      directory = Directory('/storage/emulated/0/Documents/Invoices/');
      // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
      // ignore: avoid_slow_async_io

      // if (!await directory.exists()) directory = await getExternalStorageDirectory();
    }
  } catch (err, stack) {
    print("Cannot get download folder path");
  }
  return directory?.path;
}


Future<String?> getDownloadPath2() async {
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
      // directory = Directory('/storage/emulated/0/Download/Invoices/');
      // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
      // ignore: avoid_slow_async_io

      directory = await getExternalStorageDirectory();
    }
  } catch (err, stack) {
    print("Cannot get download folder path");
  }
  return directory?.path;
}