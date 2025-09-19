import 'package:flutter/material.dart';
import 'package:transoft/paymentvoucher.dart';
import 'package:transoft/receipts.dart';
import 'package:transoft/shoppingpage.dart';

import 'Accountmaster.dart';
import 'Dataentrypage/billentry.dart';
import 'billprint.dart';
import 'customerledger.dart';

class Menupage extends StatefulWidget {
  const Menupage({super.key});

  @override
  State<Menupage> createState() => _MenupageState();
}

class _MenupageState extends State<Menupage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List entries = [
    "Bill Entry",
    "Customer Receipts",
    "Payment Voucher",
    "Bill Print",
    "Customer Ledger",
    "Account Master",
    "Shopping",
  ];
  List entriesIcon = [
    Icons.local_shipping_sharp,
    Icons.receipt,
    Icons.payments,
    Icons.print,
    Icons.account_balance_wallet,
    Icons.account_box,
    Icons.shopping_cart,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: entries.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                index == 0
                    ? gotoBillentry()
                    : index == 1
                    ? gotoreceipts()
                    : index == 2
                    ? gotopaymentvoucher()
                    : index == 3
                    ? gotobillprint()
                    : index == 4
                    ? gotocustomerledger()
                    : index == 5
                    ? gotoAccountmater()
                    : index == 6
                    ? gotoshoppingpage()
                    : print("wip");
              },
              // onTap: option.onTap,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(entriesIcon[index], size: 48, color: Colors.blue),
                    SizedBox(height: 12),
                    Text(
                      entries[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  gotoBillentry() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Billentry()),
    );
  }

  gotoreceipts() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Receipts()),
    );
  }

  gotopaymentvoucher() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Paymentvoucher()),
    );
  }

  gotobillprint() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Billprint()),
    );
  }

  gotocustomerledger() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Customerledger()),
    );
  }

  gotoAccountmater() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Accountmaster()),
    );
  }

  gotoshoppingpage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Shoppingpage()),
    );
  }
}
