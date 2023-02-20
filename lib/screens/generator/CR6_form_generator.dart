import 'dart:io';

import 'package:docx_template/docx_template.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/registration/Company.dart';

///
/// Read file template.docx, produce it and save
///
void cr6FormGenerator(Company company, String code) async {
  final f = File("assets/templates/CR6_template.docx");
  final docx = await DocxTemplate.fromBytes(await f.readAsBytes());

  final f2 = File("assets/templates/memocover_template.docx");
  final memoCover = await DocxTemplate.fromBytes(await f2.readAsBytes());

  final f3 = File("assets/templates/tocollect_template.docx");
  final toCollect = await DocxTemplate.fromBytes(await f3.readAsBytes());


  // final listNormal = ['Foo', 'Bar', 'Baz'];
  final directors = company.directors!;
  final secretaries = company.secretaries!;

  final directorList = <RowContent>[];
  final secretaryList = <RowContent>[];
  final directorContList = <Content>[];


  Content content = Content();

  for (var n in directors) {

    final c = RowContent()
      ..add(TextContent("dname", n.name!+" "+n.lastName!))
      ..add(TextContent("did", n.nationalId))
      ..add(TextContent("dnationality", n.country))
      ..add(TextContent('daddress', n.street));

    directorList.add(c);
  }

  for (var n in directors) {

    final c = PlainContent("dlist")
      ..add(TextContent("dname", n.name!+" "+n.lastName!))
      ..add(TextContent("did", n.nationalId));
    directorContList.add(c);
  }


  for (var n in secretaries) {

    final c = RowContent()
      ..add(TextContent("sname", n.name!+" "+n.lastName!))
      ..add(TextContent("sid", n.nationalId))
      ..add(TextContent("snationality", n.country))
      ..add(TextContent('saddress', n.street));
    secretaryList.add(c);
  }



  content
    ..add(TextContent("company_name", company.companyName))
    ..add(TextContent("d1_name", directors[0].name!+" "+directors[0].lastName!))

    ..add(TextContent("d1_street", directors[0].street))
    ..add(TextContent("d1_city", directors[0].city))
    ..add(TextContent("d1_country", directors[0].country))
    ..add(TextContent("d1_city", directors[0].city))
    ..add(TextContent("d1_address", directors[0].street!+", "+directors[0].city!+", "+directors[0].country!))

    ..add(TableContent("table",
          directorList,

    ))

    ..add(TableContent("table2",
      secretaryList,
    ))
  ;


  final docGen = await docx.generate(content);
  final memoCoverGen = await memoCover.generate(content);
  final toCollectGen = await toCollect.generate(content);

  final directory = await getApplicationDocumentsDirectory();
  print(directory.path);

  new File("${directory.path}\\ClientDocs\\${company.companyName}\\${company.companyName}_CR6.docx").create(recursive: true)
      .then((File file) async {
        if (docGen != null) await file.writeAsBytes(docGen);
  });

  new File("${directory.path}\\ClientDocs\\${company.companyName}\\${company.companyName}_memocover.docx").create(recursive: true)
      .then((File file) async {
    if (memoCoverGen != null) await file.writeAsBytes(memoCoverGen);
  });

  new File("${directory.path}\\ClientDocs\\${company.companyName}\\${company.companyName}_tocollect.docx").create(recursive: true)
      .then((File file) async {
    if (toCollectGen != null) await file.writeAsBytes(toCollectGen);
  });





}