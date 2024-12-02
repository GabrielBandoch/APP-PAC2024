import 'package:flutter/material.dart';
import 'package:pac20242/presetation/widgets/navigationBarComplete.dart';
import 'package:pac20242/presetation/widgets/receipts.dart';

class ReceiptPreviewScreen extends StatefulWidget {
  final String? userName;
  final String? userCPF;
  final String? paymentStatus;
  final String? receiptAmount;
  final String? uid;

  const ReceiptPreviewScreen({
    Key? key,
    this.userName,
    this.userCPF,
    this.paymentStatus,
    this.receiptAmount,
    this.uid
  }) : super(key: key);

  @override
  _ReceiptPreviewScreenState createState() => _ReceiptPreviewScreenState();
}

class _ReceiptPreviewScreenState extends State<ReceiptPreviewScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pré-visualização do Recibo',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            ReceiptCard(
              userName: widget.userName ?? 'N/A',
              avatarUrl: 'https://example.com/avatar.png',
              status: widget.paymentStatus ?? 'N/A',
              date: '01/01/2024',
              amount: 'R\$ ${widget.receiptAmount ?? '0,00'}',
              uid: '',
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Responsável:', widget.userName ?? 'N/A'),
            const SizedBox(height: 8),
            _buildInfoRow('CPF do Responsável:', widget.userCPF ?? 'N/A'),
            const SizedBox(height: 8),
            _buildInfoRow('Status do Pagamento:', widget.paymentStatus ?? 'N/A',
                valueColor: widget.paymentStatus == 'Pago' ? Colors.green : Colors.red),
            const SizedBox(height: 8),
            _buildInfoRow('Valor:', 'R\$ ${widget.receiptAmount ?? '0,00'}'),
            const Spacer(),
            SizedBox(
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  // lógica da ação
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF1577EA)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Gerar Recibo',
                  style: TextStyle(
                    color: Color(0xFF1577EA),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarComplete(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16, color: valueColor ?? Colors.black),
        ),
      ],
    );
  }
}
