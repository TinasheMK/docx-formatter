import 'dart:io';

import 'package:docx_template/docx_template.dart';
import 'package:docxform/core/models/Objective.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../models/Client.dart';

///
/// Read file template.docx, produce it and save
///
Future <String> cr6FormGenerator(Client company, String code, List<Objective> memos) async {
  try {
    final data = await rootBundle.load('assets/templates/CR6_template.docx');
    final bytes = data.buffer.asUint8List();
    final docx = await DocxTemplate.fromBytes(bytes);

    final data2 = await rootBundle.load('assets/templates/memocover_template.docx');
    final bytes2 = data2.buffer.asUint8List();
    final memoCover = await DocxTemplate.fromBytes(bytes2);

    final data3 = await rootBundle.load('assets/templates/tocollect_template.docx');
    final bytes3 = data3.buffer.asUint8List();
    final toCollect = await DocxTemplate.fromBytes(bytes3);

    final data4 = await rootBundle.load('assets/templates/articles_template.docx');
    final bytes4 = data4.buffer.asUint8List();
    final articles = await DocxTemplate.fromBytes(bytes4);

    final data5 = await rootBundle.load('assets/templates/memo_template.docx');
    final bytes5 = data5.buffer.asUint8List();
    final memoDoc = await DocxTemplate.fromBytes(bytes5);




    // final listNormal = ['Foo', 'Bar', 'Baz'];
    final directors = company.directors!;
    final secretaries = company.secretaries!;
    final memo = memos;

    final directorList = <RowContent>[];
    final secretaryList = <RowContent>[];
    final directorContList = <Content>[];
    final memoList = <Content>[];


    Content content = Content();

    for (var n in directors) {
      final c = RowContent()
        ..add(TextContent("dname", n.name! + " " + n.lastName!))..add(
            TextContent("did", n.nationalId))..add(
            TextContent("dstreet", n.street))..add(
            TextContent("dcity", n.city))..add(
            TextContent("dcountry", n.country))..add(
            TextContent("dnationality", n.country))..add(TextContent('daddress',
            directors[0].street! + ", " + directors[0].city! + ", " +
                directors[0].country!));

      directorList.add(c);
    }

    for (var n in directors) {
      final c = PlainContent("dlist")
        ..add(TextContent("dname", n.name! + " " + n.lastName!))..add(
            TextContent("did",
                n.nationalId!));
      directorContList.add(c);
    }

    for (var n in memo) {
      final c = PlainContent("memolist")
        ..add(TextContent("memodesc", n.description));
      memoList.add(c);
    }


    for (var n in secretaries) {
      final c = RowContent()
        ..add(TextContent("sname", n.name! + " " + n.lastName!))..add(
            TextContent("sid", n.nationalId))..add(
            TextContent("snationality", n.country))..add(
            TextContent("dstreet", n.street))..add(
            TextContent("dcity", n.city))..add(
            TextContent("dcountry", n.country))..add(TextContent('saddress',
            secretaries[0].street! + ", " + secretaries[0].city! + ", " +
                secretaries[0].country!));
      secretaryList.add(c);
    }

    var day = DateFormat('d').format(DateTime.now());
    var tag;
    if(day==1 || day==21 || day==31){
      tag = "st";
    }else if(day==2 || day==22){
      tag ="nd";
    }else if(day==3 || day==23){
      tag="rd";
    }else{
      tag = "th";
    }

    content..add(TextContent("company_name", company.name))..add(
        TextContent(
            "d1_name", directors[0].name! + " " + directors[0].lastName!))..add(
        TextContent("d1_street", directors[0].street))
      ..add( TextContent("d1_city", directors[0].city))
      ..add( TextContent("currentdate", day))
      ..add( TextContent("currentdaytag", tag))
      ..add( TextContent("currentyear", DateFormat('y').format(DateTime.now())))
      ..add( TextContent("d1_country", directors[0].country))
      ..add( TextContent("d1_city", directors[0].city))
      ..add( TextContent( "d1_address", directors[0].street! + ", " + directors[0].city! + ", " +   directors[0].country!))
      ..add( TextContent(  "sname", secretaries[0].name! + " " + secretaries[0].lastName!))
      ..add( TextContent("sid", secretaries[0].nationalId))
      ..add( TextContent("snationality", secretaries[0].country))
      ..add(   TextContent('saddress', secretaries[0].street))
      ..add(  TableContent("table",       directorList,  ))
      ..add(TableContent("table2",   secretaryList,  ))
      ..add(ListContent("dlist", directorContList))
      ..add(   ListContent("memolist", memoList))
    ;


    final docGen = await docx.generate(content);
    final memoCoverGen = await memoCover.generate(content);
    final toCollectGen = await toCollect.generate(content);
    final articlesGen = await articles.generate(content);
    final memoDocGen = await memoDoc.generate(content);

    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);

    new File("${directory.path}\\ClientDocs\\${company.name}\\${company
        .name}_CR6.docx").create(recursive: true)
        .then((File file) async {
      if (docGen != null) await file.writeAsBytes(docGen);
    });

    new File("${directory.path}\\ClientDocs\\${company.name}\\${company
        .name}_memocover.docx").create(recursive: true)
        .then((File file) async {
      if (memoCoverGen != null) await file.writeAsBytes(memoCoverGen);
    });

    new File("${directory.path}\\ClientDocs\\${company.name}\\${company
        .name}_tocollect.docx").create(recursive: true)
        .then((File file) async {
      if (toCollectGen != null) await file.writeAsBytes(toCollectGen);
    });

    new File("${directory.path}\\ClientDocs\\${company.name}\\${company
        .name}_articles.docx").create(recursive: true)
        .then((File file) async {
      if (articlesGen != null) await file.writeAsBytes(articlesGen);
    });

    new File("${directory.path}\\ClientDocs\\${company.name}\\${company
        .name}_memo.docx").create(recursive: true)
        .then((File file) async {
      if (memoDocGen != null) await file.writeAsBytes(memoDocGen);
    });
    return "Documents created successfully. Check your documents folder in ClientDocs folder.";
  }catch(e){
    return e.toString();
  }





}