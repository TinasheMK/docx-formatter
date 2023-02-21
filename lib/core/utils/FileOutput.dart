// import 'dart:io';
//
// import 'package:docx_template/docx_template.dart';
// import 'package:path_provider/path_provider.dart';
//
// import '../../models/Memo.dart';
// import '../../models/registration/Company.dart';
//
// class FileOutput extends LogOutput {
//   FileOutput();
//
//   File file;
//
//   @override
//   void init() {
//     super.init();
//     file = new File(filePath);
//   }
//
//   @override
//   void output(OutputEvent event) async {
//     if (file != null) {
//       for (var line in event.lines) {
//         await file.writeAsString("${line.toString()}\n",
//             mode: FileMode.writeOnlyAppend);
//       }
//     } else {
//       for (var line in event.lines) {
//         print(line);
//       }
//     }
//   }
// }