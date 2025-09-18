import 'package:flutter/material.dart';

class Paymentvoucher extends StatefulWidget {
  const Paymentvoucher({super.key});

  @override
  State<Paymentvoucher> createState() => _PaymentvoucherState();
}

class _PaymentvoucherState extends State<Paymentvoucher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment Voucher",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
    );
  }
}
