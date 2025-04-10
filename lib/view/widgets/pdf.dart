import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:notes/models/note_model.dart';

class PDFGenerator {
  static Future<void> printNotes(List<NoteModel> notes) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Center(
            child: pw.Text(
              'My Notes',
              style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.SizedBox(height: 20),
          ...notes.map((note) => pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 10),
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(),
              borderRadius: pw.BorderRadius.circular(5),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("ID: ${note.id}"),
                pw.Text("Title: ${note.title}"),
                pw.Text("Body: ${note.body}"),
                pw.Text("Critical: ${note.isCritical ? 'Yes' : 'No'}"),
              ],
            ),
          )),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}
