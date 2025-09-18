import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Receipts extends StatefulWidget {
  const Receipts({super.key});

  @override
  State<Receipts> createState() => _ReceiptsState();
}

class _ReceiptsState extends State<Receipts> {
  DateTime? selectedDate = DateTime.now();
  TextEditingController Rnoctrl = TextEditingController();
  TextEditingController Rnamectrl = TextEditingController();
  TextEditingController ledgerbalancectrl = TextEditingController();
  TextEditingController Ramountctrl = TextEditingController();
  TextEditingController Rremarkctrl = TextEditingController();

  FocusNode RNO = FocusNode();
  FocusNode RName = FocusNode();
  FocusNode lerdgerbalance = FocusNode();
  FocusNode amount = FocusNode();
  FocusNode remark = FocusNode();
  String selectedmode = "Cash";
  final List<Map<String, String>> PaymentMode = [
    {'label': 'Cash', 'value': 'Cash'},
    {'label': 'HDFC', 'value': 'HDFC'},
    {'label': 'Kotak', 'value': 'Kotak'},
  ];
  var oldRSrno = "";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Select Date',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.deepOrange, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.deepOrange),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Receipt Entry",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        actions: [
          InkWell(
            onTap: () {
              _selectDate(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.calendar_month),
                  Text(
                    "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text('NO:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  Container(
                    width: 50,
                    child: IconButton(
                      onPressed: () {
                        var p1 = Rnoctrl.text;
                        var p2 = int.parse(p1) - 1;
                        if (p2 > 0 && p2 < int.parse(oldRSrno)) {
                          Rnoctrl.text = p2.toString().padLeft(4, '0');
                          getData(Rnoctrl.text);
                          setState(() {});
                        } else {
                          Fluttertoast.showToast(
                            msg: "No more previous purchase",
                          );
                        }
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 100,
                      child: TextFormField(
                        controller: Rnoctrl,
                        focusNode: RNO,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    width: 50,
                    child: IconButton(
                      onPressed: () {
                        var p1 = Rnoctrl.text;
                        var p2 = int.parse(p1) + 1;
                        if (p2 > 0 && p2 < int.parse(oldRSrno)) {
                          Rnoctrl.text = p2.toString().padLeft(4, '0');
                          getData(Rnoctrl.text);
                          setState(() {});
                        } else {
                          Fluttertoast.showToast(msg: "No more Entry");
                        }
                      },
                      icon: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Name:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: Rnamectrl,
                      focusNode: RName,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "Ledger Balance:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: ledgerbalancectrl,
                      focusNode: lerdgerbalance,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "Amount:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: Ramountctrl,
                      focusNode: amount,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Bank:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        label: Text('Select Type'),
                        border: OutlineInputBorder(),
                      ),
                      value: selectedmode,
                      items:
                          PaymentMode.map((item) {
                            return DropdownMenuItem<String>(
                              value: item['value'],
                              child: Text(item['label']!),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedmode = value!;
                          print('Selected Value: $selectedmode');
                          // To get the label:
                          final selectedLabel =
                              PaymentMode.firstWhere(
                                (item) => item['value'] == value,
                              )['label'];
                          print('Selected Label: $selectedLabel');
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text("Remark:", style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(
                      child: TextFormField(
                        controller: Rremarkctrl,
                        focusNode: remark,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "add any remark here..",
                          contentPadding: EdgeInsets.all(10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      )),
                ],
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.brown, // Border color
                            width: 2, // Border width
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Optional rounded corners
                          ),
                          backgroundColor: Colors.brown, // Button background
                          foregroundColor: Colors.white, // Text/icon color
                        ),
                        child: Text("Cancel"),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.brown, // Border color
                            width: 2, // Border width
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Optional rounded corners
                          ),
                          backgroundColor: Colors.brown, // Button background
                          foregroundColor: Colors.white, // Text/icon color
                        ),
                        child: Text("Save"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getData(String text) {}
}
