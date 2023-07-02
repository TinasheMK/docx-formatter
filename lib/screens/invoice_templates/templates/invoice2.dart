
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart' as pdf;
import 'package:smart_admin_dashboard/providers/registration/Company.dart';
import 'package:smart_admin_dashboard/providers/registration/Currency.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' ;
import 'package:intl/intl.dart';
import '../../../core/providers/services/permissions.dart';
import 'package:flutter/material.dart';

import '../../../providers/registration/Client.dart';
import '../../../providers/registration/Invoice.dart';
import '../../generator/save_file_mobile.dart';
import '../data.dart';






var logoPath;
var invoice = Invoice.fromJson({});
Future<Uint8List> generateInvoice2(pdf.PdfPageFormat pageFormat, Invoice data) async {
  invoice = data;
  // invoice.currencyFull = Currency();
  // invoice.invoiceNumber = 'fetr';
  // invoice.currencyFull!.symbol = '\$';
  // invoice.client = Client();
  // invoice.client!.companyName = 'fgh';
  // invoice.company = Company();
  // invoice.company!.companyName = 'kl;';

  var _model = ImageModel();

  final directory = await getDownloadPath2();
  if(invoice.company?.logo!=null) logoPath = "${directory}${invoice.company!.logo!}";


  _model.requestFilePermission();
  //Create a PDF document.
  final PdfDocument document = PdfDocument();
  //Add page to the PDF
  final PdfPage page = document.pages.add();
  //Get page client size
  final Size pageSize = page.getClientSize();
  //Draw rectangle
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
      pen: PdfPen(PdfColor(142, 170, 219)));
  //Generate PDF grid.
  final PdfGrid grid = _getGrid();

  //Draw the header section by creating text element
  final PdfLayoutResult result = await _drawHeader(page, pageSize, grid);
  //Draw grid
  _drawGrid(page, grid, result);

  //Add invoice footer
  _drawFooter(page, pageSize);
  //Save and dispose the document.
  final List<int> bytes = await document.save();
  //Launch file.
  // await FileSaveHelper.saveAndLaunchFile(bytes, 'Invoice_'+invoice.id.toString()+'.pdf');
  
  Uint8List byte =  Uint8List.fromList(bytes);
  document.dispose();

  return byte;
}

//Draws the invoice header
Future<PdfLayoutResult> _drawHeader(PdfPage page, Size pageSize, PdfGrid grid) async {
  //Draw rectangle
  page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(91, 126, 215)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
  //Draw string
  page.graphics.drawString(
      'INVOICE', PdfStandardFont(PdfFontFamily.helvetica, 30),
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
      format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
      brush: PdfSolidBrush(PdfColor(65, 104, 205)));
  page.graphics.drawString(r''+invoice.currencyFull!.symbol! + _getTotalAmount(grid).toString(),
      PdfStandardFont(PdfFontFamily.helvetica, 18),
      bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
      brush: PdfBrushes.white,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);

  //Draw string
  page.graphics.drawString('Amount', contentFont,
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.bottom));

  print(logoPath);
  double height  =0;
  double width  =0;
  if(logoPath!=null) {
    var image = File(logoPath!).readAsBytesSync();
    var decodedImage = await decodeImageFromList(image);
    print(decodedImage.width);
    print(decodedImage.height);

    // var x = decodedImage.width/(pageSize.width - 400);


    if(decodedImage.width > decodedImage.height) {
      width = 108;
      height = 108 * decodedImage.height / decodedImage.width;
    }else {
      height = 80;
      width = (decodedImage.width / decodedImage.height) * 80;
    }

    page.graphics.drawImage(
        PdfBitmap(image),
        Rect.fromLTWH(
            400, 95, width , height));
  }

  //Create data foramt and convert it to text.
  final DateFormat format = DateFormat.yMMMMd('en_US');
  final String invoiceNumber = 'Invoice Number: '+invoice.invoiceNumber!+'\r\n\r\nDate: ' +
      invoice.invoiceDate.toString().split(" ")[0];
  // format.format(DateTime.now());
  final Size contentSize = contentFont.measureString(invoiceNumber);
  String addr = invoice.client!.street ?? '';
  String city = invoice.client!.city ?? '';
  String country = invoice.client!.country ?? '';
  String address =
      'Bill To: \r\n\r\n'+invoice.client!.companyName!+', \r\n\r\n'+addr +', \r\n\r\n'+city +', \r\n\r\n'+country ;
  PdfTextElement(text: invoiceNumber, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(400, 100 + height,
          contentSize.width + 30, pageSize.height - 120));



  return PdfTextElement(text: address, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(30, 120,
          pageSize.width - (contentSize.width + 30), pageSize.height - 120))!;
}

//Draws the grid
void _drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
  Rect? totalPriceCellBounds;
  Rect? quantityCellBounds;
  //Invoke the beginCellLayout event.
  grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
    final PdfGrid grid = sender as PdfGrid;
    if (args.cellIndex == grid.columns.count - 1) {
      totalPriceCellBounds = args.bounds;
    } else if (args.cellIndex == grid.columns.count - 2) {
      quantityCellBounds = args.bounds;
    }
  };
  //Draw the PDF grid and get the result.
  result = grid.draw(
      page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;
  //Draw grand total.
  page.graphics.drawString('Grand Total',
      PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(
          quantityCellBounds!.left,
          result.bounds.bottom + 10,
          quantityCellBounds!.width,
          quantityCellBounds!.height));
  page.graphics.drawString(_getTotalAmount(grid).toString(),
      PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(
          totalPriceCellBounds!.left,
          result.bounds.bottom + 10,
          totalPriceCellBounds!.width,
          totalPriceCellBounds!.height));


  page.graphics.drawString('Payments',
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: Rect.fromLTWH(
          25,
          result.bounds.bottom + 22 ,
          quantityCellBounds!.width,
          quantityCellBounds!.height));

  //Invoice payments
  final PdfGrid grid2 = _getGrid2(result, page);
}

//Draw the invoice footer data.
void _drawFooter(PdfPage page, Size pageSize) {
  final PdfPen linePen =
  PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
  linePen.dashPattern = <double>[3, 3];
  //Draw line
  page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
      Offset(pageSize.width, pageSize.height - 100));

  String addr = invoice.company!.street??"";
  String city = invoice.company!.city??"";
  String country = invoice.company!.country??"";
  String email = invoice.company!.email??"";
  String footerContent =
      invoice.company!.companyName!+'.\r\n\r\n'+ addr+', '+ city+', '+ country +'\r\n\r\nAny Questions? '+ email;
  //Added 30 as a margin for the layout
  page.graphics.drawString(
      footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
      format: PdfStringFormat(alignment: PdfTextAlignment.right),
      bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
}

//Create PDF grid and return
PdfGrid _getGrid() {
  //Create a PDF grid
  final PdfGrid grid = PdfGrid();
  //Secify the columns count to the grid.
  grid.columns.add(count: 5);
  //Create the header row of the grid.
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  //Set style
  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
  headerRow.style.textBrush = PdfBrushes.white;
  headerRow.cells[0].value = 'Units';
  headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[1].value = 'Code';
  headerRow.cells[2].value = 'Product Name';
  headerRow.cells[3].value = 'Price';
  headerRow.cells[4].value = 'Total';

  invoice.invoiceItems?.forEach((p) {
    _addProducts(p.units?.toString()??'','789RT' , p.description??'', p.unitPrice??0.0, p.total??0.0, grid);
  });


  // _addProducts(
  //     'LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 3, 149.97, grid);
  // _addProducts('So-B909-M', 'Mountain Bike Socks,M', 9.5, 2, 19, grid);
  // _addProducts(
  //     'LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 4, 199.96, grid);
  // _addProducts('FK-5136', 'ML Fork', 175.49, 6, 1052.94, grid);
  // _addProducts('HL-U509', 'Sports-100 Helmet,Black', 34.99, 1, 34.99, grid);
  grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
  grid.columns[2].width = 200;
  for (int i = 0; i < headerRow.cells.count; i++) {
    headerRow.cells[i].style.cellPadding =
        PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
  }
  for (int i = 0; i < grid.rows.count; i++) {
    final PdfGridRow row = grid.rows[i];
    for (int j = 0; j < row.cells.count; j++) {
      final PdfGridCell cell = row.cells[j];
      if (j == 0) {
        cell.stringFormat.alignment = PdfTextAlignment.center;
      }
      cell.style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
  }
  return grid;
}

PdfGrid _getGrid2(PdfLayoutResult res, PdfPage page) {
  //Create a PDF grid
  final PdfGrid grid = PdfGrid();
  //Secify the columns count to the grid.
  grid.columns.add(count: 3);
  //Create the header row of the grid.
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  //Set style
  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
  headerRow.style.textBrush = PdfBrushes.white;
  headerRow.cells[0].value = 'Reference';
  headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[1].value = 'Date';
  headerRow.cells[2].value = 'Amount';

  invoice.payments?.forEach((p) {
    _addPayments(p.ref?.toString()?? p.id?.toString() ?? '', p.paymentDate??'', p.total.toString()??'', p.total??0.0, grid);
  });


  // _addProducts(
  //     'LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 3, 149.97, grid);
  // _addProducts('So-B909-M', 'Mountain Bike Socks,M', 9.5, 2, 19, grid);
  // _addProducts(
  //     'LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 4, 199.96, grid);
  // _addProducts('FK-5136', 'ML Fork', 175.49, 6, 1052.94, grid);
  // _addProducts('HL-U509', 'Sports-100 Helmet,Black', 34.99, 1, 34.99, grid);
  grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
  grid.columns[2].width = 200;
  for (int i = 0; i < headerRow.cells.count; i++) {
    headerRow.cells[i].style.cellPadding =
        PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
  }
  for (int i = 0; i < grid.rows.count; i++) {
    final PdfGridRow row = grid.rows[i];
    for (int j = 0; j < row.cells.count; j++) {
      final PdfGridCell cell = row.cells[j];
      if (j == 0) {
        cell.stringFormat.alignment = PdfTextAlignment.center;
      }
      cell.style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
  }

  grid.draw(
      page: page, bounds: Rect.fromLTWH(0, res.bounds.bottom + 40, 0, 0))!;

  return grid;
}

//Create and row for the grid.
void _addProducts(String units,String code, String productName, double price,
    double total, PdfGrid grid) {
  final PdfGridRow row = grid.rows.add();
  row.cells[0].value = units;
  row.cells[1].value = code;
  row.cells[2].value = productName;
  row.cells[3].value = price.toString();
  row.cells[4].value = total.toString();
}

//Create and row for the grid.
void _addPayments(String units,String code, String productName, double price,
    PdfGrid grid) {
  final PdfGridRow row = grid.rows.add();
  row.cells[0].value = units;
  row.cells[1].value = code;
  row.cells[2].value = productName;
}

//Get the total amount.
double _getTotalAmount(PdfGrid grid) {
  double total = 0;
  // for (int i = 0; i < grid.rows.count; i++) {
  //   final String value =
  //   grid.rows[i].cells[grid.columns.count - 1].value as String;
  //   total += double.parse(value);
  // }
  return invoice.totalAmount?? 0.0;
}


String _formatCurrency(double amount) {
  return '\$${amount.toStringAsFixed(2)}';
}

class Product {
  const Product(
    this.sku,
    this.productName,
    this.price,
    this.quantity,
  );

  final String sku;
  final String productName;
  final double price;
  final int quantity;
  double get total => price * quantity;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sku;
      case 1:
        return productName;
      case 2:
        return _formatCurrency(price);
      case 3:
        return quantity.toString();
      case 4:
        return _formatCurrency(total);
    }
    return '';
  }
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
