import 'dart:io';

import 'package:docx_template/docx_template.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_admin_dashboard/models/registration/Registration.dart';

///
/// Read file template.docx, produce it and save
///
void generateRegister(Registration register) async {
  final f = File("assets/templates/CR6_template.docx");
  final docx = await DocxTemplate.fromBytes(await f.readAsBytes());

  // Load test image for inserting in docx
  final testFileContent = await File('assets/images/mockup.png').readAsBytes();

  final listNormal = ['Foo', 'Bar', 'Baz'];
  final listBold = ['ooFPlop', 'raB', 'zaB'];

  final contentList = <Content>[];

  final b = listBold.iterator;
  for (var n in listNormal) {
    b.moveNext();

    final c = PlainContent("value")
      ..add(TextContent("normal", n))
      ..add(TextContent("bold", b.current));
    contentList.add(c);
  }
  print(register.director1_street.toString());
  Content content = Content();
  content
    ..add(TextContent("company_name", register.companyName))
    ..add(TextContent("director1", register.director1_street))

    ..add(TextContent("director1_street", register.director1_street))
    ..add(TextContent("director1_city", register.director1_city))
    ..add(TextContent("director1_country", register.director1_city))
    ..add(TextContent("director1_city", register.director1_city))

    ..add(TableContent("table", [
      RowContent()
        ..add(TextContent("dname", "Paul"))
        ..add(TextContent("did", "Viberg"))
        ..add(TextContent("dnationality", "Engineer"))
        ..add(TextContent('daddress', "testFileContent"))
        ..add(TextContent('dparticulars', "testFileContent"))
        ..add(TextContent('dincdate', "testFileContent")),

    ]))


    ..add(TableContent("table2", [
      RowContent()
        ..add(TextContent("sname", "Paul"))
        ..add(TextContent("sid", "Viberg"))
        ..add(TextContent("snationality", "Engineer"))
        ..add(TextContent('saddress', "testFileContent"))
        ..add(TextContent('sparticulars', "testFileContent"))
        ..add(TextContent('sincdate', "estFileContent")),

    ]))



  ;

  final docGenerated = await docx.generate(content);
  final fileGenerated = File('twistola.docx');
  if (docGenerated != null) await fileGenerated.writeAsBytes(docGenerated);

  final docGen = await docx.generate(content);
  final directory = await getApplicationDocumentsDirectory();
  print(directory.path);
  File docGener = File("${directory.path}/${register.companyName}_CR6.docx");
  if (docGen != null) await docGener.writeAsBytes(docGen);

}