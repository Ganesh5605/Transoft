import 'package:flutter/material.dart';
class Billprint extends StatefulWidget {
  const Billprint({super.key});

  @override
  State<Billprint> createState() => _BillprintState();
}

class _BillprintState extends State<Billprint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill Printing"),
      ),
    );
  }
}
