import 'dart:io';

import 'package:docx_template/docx_template.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/Memo.dart';
import '../../models/registration/Company.dart';
import '../../models/registration/Invoice.dart';

///
/// Read file template.docx, produce it and save
///
Future <String> invoiceGenerator(Invoice company, String code, List<Memo> memos) async {
  // try {
    final f = File("assets/templates/invoicetemplate1.docx");
    final docx = await DocxTemplate.fromBytes(await f.readAsBytes());

    // final listNormal = ['Foo', 'Bar', 'Baz'];
    final directors = company.invoiceitems!;
    // final secretaries = company.secretaries!;
    final memo = memos;

    final directorList = <RowContent>[];
    final secretaryList = <RowContent>[];
    final directorContList = <Content>[];
    final memoList = <Content>[];


    Content content = Content();

    for (var n in directors) {
      final c = RowContent()
        ..add(TextContent("dname","wiii" + " " + "ioioio"))..add(
            TextContent("did", ""))..add(
            TextContent("dstreet", ""))..add(
            TextContent("dcity", ""))..add(
            TextContent("dcountry", ""))..add(
            TextContent("dnationality", ""))..add(TextContent('daddress',
            ", " + "ytvytiouio" + ", " ));

      directorList.add(c);
    }

    for (var n in directors) {
      final c = PlainContent("dlist")
        ..add(TextContent("dname"," n.name! "+ " " + "n.lastName!"))..add(
            TextContent("did","address 2670"));
      directorContList.add(c);
    }

    for (var n in memo) {
      final c = PlainContent("memolist")
        ..add(TextContent("memodesc", n.description));
      memoList.add(c);
    }



    content..add(TextContent("company_name", company.notes))..add(
        TextContent(
            "d1_name", "directors[0].name!" + " " + "irectors[0].lastName!"))
      ..add(
        TextContent("d1_street", "directors"))
      ..add(
        TextContent("d1_city", "directors[0].city"))
      ..add(
        TextContent("d1_country", "directors[0].country"))

      ..add(TextContent(
        "sname", "wii"))


      ..add(TableContent("table2",
      secretaryList,
    ))..add(ListContent("dlist", directorContList))..add(
        ListContent("memolist", memoList))

    ;


    final docGen = await docx.generate(content);

    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);

    new File("${directory.path}\\ClientDocs\\${company
        .id}_invoice.docx").create(recursive: true)
        .then((File file) async {
      if (docGen != null) await file.writeAsBytes(docGen);
    });

    return "Documents created successfully. Check your documents folder in ClientDocs folder.";
  // }catch(e){
  //   return e.toString();
  // }





}