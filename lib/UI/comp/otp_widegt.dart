import 'package:flutter/material.dart';

class OtpDialog extends StatefulWidget {
  final Function(String) onOtpEntered;

  OtpDialog({required this.onOtpEntered});

  @override
  _OtpDialogState createState() => _OtpDialogState();
}

class _OtpDialogState extends State<OtpDialog> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter OTP'),
      content: TextField(
        controller: _otpController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'OTP',
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            String otp = _otpController.text;
            widget.onOtpEntered(otp);
            Navigator.pop(context);
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
