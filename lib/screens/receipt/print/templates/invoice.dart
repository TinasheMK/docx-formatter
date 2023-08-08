/*
 * Copyright (C) 2017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:smart_admin_dashboard/core/models/Currency.dart';

import '../../../../core/models/InvoiceItem.dart';
import '../../../../core/models/Invoice.dart';

Future<Uint8List> generateInvoice(
    PdfPageFormat pageFormat, Invoice data) async {
  final lorem = LoremText();
  PdfColor mainColor;
  PdfColor accent;
  PdfColor lightAccent;
  if(data.business!=null && data.business!.color!=null) {
    var colo = Color(data.business!.color!);
    double red = colo.red.toDouble()>=0?colo.red.toDouble()/255 : 0.0;
    double green = colo.green.toDouble()>=0?colo.green.toDouble()/255 : 0.0;
    double blue = colo.blue.toDouble()>=0?colo.blue.toDouble()/255 : 0.0;
    print(red.toString()+" "+green.toString()+" "+blue.toString());
    mainColor = PdfColor(red, green, blue);

    double red1 = red*1.7>=1?1 : red*1;
    double green1 = green*1.7>=1?1 : green*1;
    double blue1 = blue*1.7>=1?1 : blue*1;

    accent = PdfColor(red*0.3, green*0.3, blue*0.3);
    lightAccent = PdfColor(red1, green1, blue1);
  }else{
    mainColor = PdfColors.teal;
    accent = PdfColors.blueGrey900;
    lightAccent = PdfColors.red;

  }

  final invoice = LocalInvoice(
    invoiceNumber: data.invoiceNumber.toString(),
    products: data.invoiceItems!,
    logo: data.business?.logo ?? '',
    customerName: data.client?.name??'',
    customerAddress: data.client?.street??'',
    paymentInfo:
        "${data.business?.paymentInfo??''}\n"
            "${data.business?.street??''}\n"
            "${data.business?.city??''}, ${data.business?.country??''}, \n"
            "${data.business?.telephone??''}",
    tax: .0,
    baseColor: mainColor,
    accentColor: accent,
    lightAccent: lightAccent,
  );

  return await invoice.buildPdf(pageFormat);
}

class LocalInvoice {
  LocalInvoice({
    required this.products,
    required this.logo,
    required this.customerName,
    required this.customerAddress,
    required this.invoiceNumber,
    required this.tax,
    required this.paymentInfo,
    required this.baseColor,
    required this.accentColor,
    required this.lightAccent,
  });

  final List<InvoiceItem> products;
  final String logo;
  final String customerName;
  final String customerAddress;
  final String invoiceNumber;
  final double tax;
  final String paymentInfo;
  final PdfColor baseColor;
  final PdfColor accentColor;
  final PdfColor lightAccent;

  static const _darkColor = PdfColors.black;
  static const _lightColor = PdfColors.white;

  PdfColor get _baseTextColor => baseColor.isLight ? _lightColor : _darkColor;

  PdfColor get _accentTextColor => baseColor.isLight ? _lightColor : _darkColor;

  double get _total =>
      products.map<double>((p) => p.total!).reduce((a, b) => a + b);

  double get _grandTotal => _total * (1 + tax);

  ImageProvider? _logo;

  String? _bgShape;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    // Create a PDF document.
    final doc = Document();

    // _logo = await rootBundle.loadString('assets/logo/logo.svg');
    // logoPath ==null ? Image.asset("assets/logo/logo_icon.png", scale:1)
    //     : Image.file(File(logoPath!), scale:1),

    final directory = await getDownloadPath2();

    if(logo!='')_logo = MemoryImage(File("${directory}${logo!}"!).readAsBytesSync());
    _bgShape = await rootBundle.loadString('assets/logo/invoice.svg');

    var robotoRegularFont = await rootBundle.load("assets/fonts/Roboto/Roboto-Regular.ttf");
    var robotoBoldFont = await rootBundle.load("assets/fonts/Roboto/Roboto-Bold.ttf");
    var robotoItalicFont = await rootBundle.load("assets/fonts/Roboto/Roboto-Italic.ttf");
    var robotoRegular = Font.ttf(robotoRegularFont);
    var robotoBold = Font.ttf(robotoRegularFont);
    var robotoItalic = Font.ttf(robotoRegularFont);


    // Add page to the PDF
    doc.addPage(
      MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          await robotoRegular,
          await robotoBold,
          await robotoItalic,
        ),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          _contentHeader(context),
          _contentTable(context),
          SizedBox(height: 20),
          _contentFooter(context),
          SizedBox(height: 20),
          _termsAndConditions(context),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  Widget _buildHeader(Context context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'INVOICE',
                      style: TextStyle(
                        color: baseColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(2)),
                      color: accentColor,
                    ),
                    padding: const EdgeInsets.only(
                        left: 40, top: 10, bottom: 10, right: 20),
                    alignment: Alignment.centerLeft,
                    height: 50,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: _accentTextColor,
                        fontSize: 12,
                      ),
                      child: GridView(
                        crossAxisCount: 2,
                        children: [
                          Text('Invoice '),
                          Text(invoiceNumber),
                          Text('Date:'),
                          Text(_formatDate(DateTime.now())),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 18, left: 20, right: 10, top: 10),
                    height: 90,
                    child:
                        _logo != null ? Image(_logo!) : Text(""),
                  ),
                  // Container(
                  //   color: baseColor,
                  //   padding: EdgeInsets.only(top: 3),
                  // ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) SizedBox(height: 20)
      ],
    );
  }

  Widget _buildFooter(Context context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Container(
        //   height: 20,
        //   width: 100,
        //   child: BarcodeWidget(
        //     barcode: Barcode.pdf417(),
        //     data: 'Invoice $invoiceNumber',
        //     drawText: false,
        //   ),
        // ),
        Text(
          'Page ${context.pageNumber}/${context.pagesCount}',
          style: const TextStyle(
            fontSize: 12,
            color: PdfColors.white,
          ),
        ),
      ],
    );
  }

  PageTheme _buildTheme(
      PdfPageFormat pageFormat, Font base, Font bold, Font italic) {
    return PageTheme(
      pageFormat: pageFormat,
      theme: ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      buildBackground: (context) => FullPage(
        ignoreMargins: true,
        child: SvgImage(svg: _bgShape!, colorFilter:lightAccent),
      ),
    );
  }

  Widget _contentHeader(Context context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 70,
            child: FittedBox(
              child: Text(
                'Total: ${_formatCurrency(_grandTotal)}',
                style: TextStyle(
                  color: baseColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 50),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: 70,
                child: Text(
                  'Invoice to:',
                  style: TextStyle(
                    color: _darkColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 70,
                  child: RichText(
                      text: TextSpan(
                          text: '$customerName\n',
                          style: TextStyle(
                            color: _darkColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          children: [
                         TextSpan(
                          text: '\n',
                          style: TextStyle(
                            fontSize: 5,
                          ),
                        ),
                        TextSpan(
                          text: customerAddress,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                      ])),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _contentFooter(Context context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thank you for your business',
                style: TextStyle(
                  color: _darkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 8),
                child: Text(
                  'Payment Info:',
                  style: TextStyle(
                    color: baseColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                paymentInfo,
                style: const TextStyle(
                  fontSize: 8,
                  lineSpacing: 5,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 10,
              color: _darkColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sub Total:'),
                    Text(_formatCurrency(_total)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax:'),
                    Text('${(tax * 100).toStringAsFixed(1)}%'),
                  ],
                ),
                Divider(color: accentColor),
                DefaultTextStyle(
                  style: TextStyle(
                    color: baseColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total:'),
                      Text(_formatCurrency(_grandTotal)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _termsAndConditions(Context context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: accentColor)),
                ),
                padding: const EdgeInsets.only(top: 10, bottom: 4),
                child: Text(
                  'Terms & Conditions',
                  style: TextStyle(
                    fontSize: 12,
                    color: baseColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Please make payment before the due date',
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 6,
                  lineSpacing: 2,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(),
        ),
      ],
    );
  }

  Widget _contentTable(Context context) {
    const tableHeaders = [
      'SKU#',
      'Item Description',
      'Price',
      'Quantity',
      'Total'
    ];

    return TableHelper.fromTextArray(
      border: null,
      cellAlignment: Alignment.centerLeft,
      headerDecoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(2)),
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerRight,
        3: Alignment.center,
        4: Alignment.centerRight,
      },
      headerStyle: TextStyle(
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
      cellStyle: const TextStyle(
        color: PdfColors.black,
        fontSize: 10,
      ),
      rowDecoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: accentColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        products.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => products[row].getIndex(col, new Currency()) ?? '',
        ),
      ),
    );
  }
}

String _formatCurrency(double amount) {
  return '\$${amount.toStringAsFixed(2)}';
}

String _formatDate(DateTime date) {
  final format = DateFormat.yMMMd('en_US');
  return format.format(date);
}

// class Product {
//   const Product(
//     this.sku,
//     this.productName,
//     this.price,
//     this.quantity,
//   );
//
//   final String sku;
//   final String productName;
//   final double price;
//   final int quantity;
//   double get total => price * quantity;
//
//   String getIndex(int index) {
//     switch (index) {
//       case 0:
//         return sku;
//       case 1:
//         return productName;
//       case 2:
//         return _formatCurrency(price);
//       case 3:
//         return quantity.toString();
//       case 4:
//         return _formatCurrency(total);
//     }
//     return '';
//   }
// }

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