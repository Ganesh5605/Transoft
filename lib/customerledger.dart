import 'package:flutter/material.dart';

class Customerledger extends StatefulWidget {
  const Customerledger({super.key});

  @override
  State<Customerledger> createState() => _CustomerledgerState();
}

class _CustomerledgerState extends State<Customerledger> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Legder"),
      ),
    );
  }
}
