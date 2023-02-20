import 'dart:io';

import 'package:docx_template/docx_template.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/registration/Company.dart';

///
/// Read file template.docx, produce it and save
///
void cr6FormGenerator(Company company) async {
  final f = File("assets/templates/CR6_template.docx");
  final docx = await DocxTemplate.fromBytes(await f.readAsBytes());

  // Load test image for inserting in docx
  final testFileContent = await File('assets/images/mockup.png').readAsBytes();

  // final listNormal = ['Foo', 'Bar', 'Baz'];
  final directors = company.directors!;
  final secretaries = company.secretaries!;

  final directorList = <RowContent>[];
  final secretaryList = <RowContent>[];


  Content content = Content();

  for (var n in directors) {

    final c = RowContent()
      ..add(TextContent("dname", n.name))
      ..add(TextContent("did", n.id))
      ..add(TextContent("dnationality", n.country))
      ..add(TextContent('daddress', n.street));

    directorList.add(c);
  }

  for (var n in secretaries) {

    final c = RowContent()
      ..add(TextContent("sname", n.name))
      ..add(TextContent("sid", n.id))
      ..add(TextContent("snationality", n.country))
      ..add(TextContent('saddress', n.street));
    secretaryList.add(c);
  }



  content
    ..add(TextContent("company_name", company.companyName))
    ..add(TextContent("director1", directors[0].name!+" "+directors[0].lastName!))

    ..add(TextContent("director1_street", company.street))
    ..add(TextContent("director1_city", company.city))
    ..add(TextContent("director1_country", company.country))
    ..add(TextContent("director1_city", company.city))

    ..add(TableContent("table",
          directorList,

    ))

    ..add(TableContent("table2",
      secretaryList,
    ))



  ;

  final docGenerated = await docx.generate(content);
  final fileGenerated = File('twistola.docx');
  if (docGenerated != null) await fileGenerated.writeAsBytes(docGenerated);

  final docGen = await docx.generate(content);
  final directory = await getApplicationDocumentsDirectory();
  print(directory.path);
  File docGener = File("${directory.path}/${company.companyName}_CR6.docx");
  if (docGen != null) await docGener.writeAsBytes(docGen);

}