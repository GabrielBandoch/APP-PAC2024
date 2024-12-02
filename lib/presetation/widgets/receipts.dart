import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:ui';
import 'dart:math';

class ReceiptCard extends StatelessWidget {
  final String userName;
  final String avatarUrl;
  final String status;
  final String date;
  final String amount;
  final String uid;

  const ReceiptCard({
    super.key,
    required this.userName,
    required this.avatarUrl,
    required this.status,
    required this.date,
    required this.amount,
    required this.uid
  });

  void _showReceiptDetails(BuildContext context) {
    final GlobalKey _captureKey =  GlobalKey();

    Future<void> _generatePdf() async {
    try {
      RenderRepaintBoundary boundary =
          _captureKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 2.0);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();
      final pdf = pw.Document();
      final imageMemory = pw.MemoryImage(pngBytes);
      pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(imageMemory),
          );
        },
      ));

      // Visualiza ou salva o PDF
      await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
    } catch (e) {
      print('Erro ao gerar o PDF: $e');
    }
  }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(
                color: Color(0xFF1577EA), width: 2),
          ),
          title: const Center(
            child: Text(
              'Detalhes do Recibo',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400), 
              child: ListBody(
                children: [
                  RepaintBoundary(
                    key: _captureKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recibo N° $uid',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Valor: $amount',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Recebi(emos) de $userName a quantia de $amount correspondente a transporte escolar. Para clareza firmo(amos) o presente.',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Nome: Gabriel F A Bandoch',
                          style: TextStyle(fontSize: 16),
                        ),
                        const Text(
                          'CPF/RG: 111.111.111-11',
                          style: TextStyle(fontSize: 16),
                        ),
                        const Text(
                          'Endereço: R° São João',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => _generatePdf(),
              child: const Text('Imprimir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1577EA), width: 2),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl),
                radius: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (status == 'Pago')
                    Text(
                      status,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    amount,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => _showReceiptDetails(context),
            child: const Text(
              'Exibir Detalhes',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF1577EA),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}