import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Color.fromARGB(166, 21, 183, 162),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text('Enter your payment details here.'),
        ),
      ),
    );
  }
}
