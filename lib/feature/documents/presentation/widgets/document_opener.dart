import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class DocumentOpenerWithBytes extends StatelessWidget {
  final Uint8List pdfBytes;

  const DocumentOpenerWithBytes({super.key, required this.pdfBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfViewer.data(
        pdfBytes,
        sourceName: "document_${DateTime.now().millisecondsSinceEpoch}.pdf",
      ),
    );
  }
}

/// Saves [pdfBytes] to the device Downloads folder using FileSaver.
/// FileSaver handles Android 10+ scoped storage and permission automatically.
Future<void> savePdfToDownloads(
  Uint8List pdfBytes,
  String fileName,
  BuildContext context,
) async {
  // Strip .pdf extension from fileName — FileSaver adds it via MimeType.pdf
  final nameWithoutExt = fileName.endsWith('.pdf')
      ? fileName.substring(0, fileName.length - 4)
      : fileName;

  try {
    await FileSaver.instance.saveFile(
      name: nameWithoutExt,
      bytes: pdfBytes,
      mimeType: MimeType.pdf,
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Документ сохранён: $fileName"),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Не удалось сохранить: $e")),
      );
    }
  }
}
