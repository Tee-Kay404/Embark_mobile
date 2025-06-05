import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CardPayment extends StatelessWidget {
  const CardPayment({super.key});

  final String bankName = "Awesome Bank Ltd.";
  final String accountNumber = "2346889422";
  final String accountHolder = "UNITED BANK FOR AFRICA (UBA5+ )";

  void copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$label copied to clipboard',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Theme.of(context).colorScheme.surface),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  TextStyle? transferTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        );
  }

  String get qrData =>
      'BANK:$bankName\nACCOUNT:$accountNumber\nHOLDER:$accountHolder';

  @override
  Widget build(BuildContext context) {
    final textStyle = transferTextStyle(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Transfer Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please transfer your payment to the following account:',
              style: textStyle,
            ),
            SizedBox(height: 30),
            _buildInfoRow(
              context,
              label: 'Bank Name',
              value: bankName,
              onCopy: () => copyToClipboard(context, bankName, 'Bank Name'),
            ),
            Divider(),
            _buildInfoRow(
              context,
              label: 'Account Number',
              value: accountNumber,
              onCopy: () =>
                  copyToClipboard(context, accountNumber, 'Account Number'),
            ),
            Divider(),
            _buildInfoRow(
              context,
              label: 'Account Holder',
              value: accountHolder,
              onCopy: () =>
                  copyToClipboard(context, accountHolder, 'Account Holder'),
            ),
            SizedBox(height: 30),
            Center(
              child: QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 150,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Scan this QR code with your banking app to auto-fill transfer details.',
              style: textStyle?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                // Add extra logic if needed
              },
              icon: Icon(Icons.info_outline),
              label: Text('More Info', style: textStyle),
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context,
      {required String label,
      required String value,
      required VoidCallback onCopy}) {
    final style = transferTextStyle(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              style: style,
              children: [
                TextSpan(
                  text: '$label:\n',
                  style: style?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.copy, color: Colors.blue),
          onPressed: onCopy,
          tooltip: 'Copy $label',
        ),
      ],
    );
  }
}
