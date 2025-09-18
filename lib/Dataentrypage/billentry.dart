import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Accountmaster.dart';
import '../models/billentrymodel.dart';

class Billentry extends StatefulWidget {
  const Billentry({super.key});

  @override
  State<Billentry> createState() => _BillentryState();
}

class _BillentryState extends State<Billentry> {
  DateTime? selectedDate = DateTime.now();
  TextEditingController BillNoctrl = TextEditingController();
  TextEditingController Namectrl = TextEditingController();
  TextEditingController vehnoctrl = TextEditingController();
  TextEditingController itemnamectrl = TextEditingController();
  TextEditingController unitctrl = TextEditingController();
  TextEditingController qtyctrl = TextEditingController();
  TextEditingController ratectrl = TextEditingController();
  TextEditingController amountctrl = TextEditingController();
  FocusNode BillNo = FocusNode();
  FocusNode Name = FocusNode();
  FocusNode vehno = FocusNode();
  FocusNode itemname = FocusNode();
  FocusNode unit = FocusNode();
  FocusNode qty = FocusNode();
  FocusNode rate = FocusNode();
  FocusNode amount = FocusNode();
  var oldbillno = "";
  List<BillEntryItem> item = [];
  bool isVisible = false;
  String selectedflocation = "Pune";
  final List<Map<String, String>> items = [
    {'label': 'Pune', 'value': 'Pune'},
    {'label': 'Satara', 'value': 'Satara'},
  ];
  String selectedtolocation = "Satara";
  final List<Map<String, String>> items2 = [
    {'label': 'Satara', 'value': 'Satara'},
    {'label': 'Kolhapur', 'value': 'Kolhapur'},
  ];

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
          'Bill Entry',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isVisible = true;
          setState(() {});
          addItem(context, -1);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    isVisible = false;
                    //saveData();
                    setState(() {});
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
                  child: Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height/3.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Bill NO:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 50,
                          child: IconButton(
                            onPressed: () {
                              var p1 = BillNoctrl.text;
                              var p2 = int.parse(p1) - 1;
                              if (p2 > 0 && p2 < int.parse(oldbillno)) {
                                BillNoctrl.text = p2.toString().padLeft(4, '0');
                                getData(BillNoctrl.text);
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
                              controller: BillNoctrl,
                              focusNode: BillNo,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.all(10),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
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
                              var p1 = BillNoctrl.text;
                              var p2 = int.parse(p1) + 1;
                              if (p2 > 0 && p2 < int.parse(oldbillno)) {
                                BillNoctrl.text = p2.toString().padLeft(4, '0');
                                getData(BillNoctrl.text);
                                setState(() {});
                              } else {
                                Fluttertoast.showToast(msg: "No more purchase");
                              }
                            },
                            icon: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                        Container(
                          width: 50,
                          child: IconButton(
                            onPressed: () {
                              showlist(context);
                            },
                            icon: Icon(Icons.list_alt),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'From Location:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 100,
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  // label: Text('Select Type'),
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                ),
                                value: selectedflocation,
                                items:
                                    [
                                      "Pune",
                                      "Satara",
                                    ].map<DropdownMenuItem<String>>((
                                      String value,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (val) {
                                  selectedflocation = val!;
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'To Location:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 150,
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  // label: Text('Select Type'),
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                ),
                                value: selectedtolocation,
                                items:
                                    [
                                      "Satara",
                                      "Kolhapur",
                                    ].map<DropdownMenuItem<String>>((
                                      String value,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (val) {
                                  selectedtolocation = val!;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "Name:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            /*width: 100,*/
                            child: TextFormField(
                              controller: Namectrl,
                              focusNode: Name,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Select Supplier",
                                isDense: true,
                                contentPadding: EdgeInsets.all(10),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),

                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            bool? result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Accountmaster(),
                              ),
                            );
                            if (result!) {
                             // GetSuppMasters();
                            }
                          },
                          icon: Icon(Icons.person_add),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "Vehicle No:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            /* width: 100,*/
                            child: TextFormField(
                              controller: vehnoctrl,
                              focusNode: vehno,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Vehicle NO",
                                isDense: true,
                                contentPadding: EdgeInsets.all(10),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),

                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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

  void showlist(BuildContext context) {}

  addItem(BuildContext context, int index) {
    if (index < 0) {
      itemnamectrl.text = "";
      unitctrl.text = "";
      qtyctrl.text = "";
      ratectrl.text = "";
      amountctrl.text = "";
    } else {
      itemnamectrl.text = item[index].Item.toString();
      unitctrl.text = item[index].Unit.toString();
      qtyctrl.text = item[index].Qty.toString();
      ratectrl.text = item[index].rate.toString();
      amountctrl.text = item[index].amount.toString();
    }
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: StatefulBuilder(
            builder: (context, setStateA) {
              return Dialog(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Item:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: itemnamectrl,
                                focusNode: itemname,
                                onChanged: (val) {
                                  if (val.isNotEmpty) {
                                    amountctrl.text =
                                        (double.parse(
                                          qtyctrl.text.isNotEmpty
                                              ? qtyctrl.text
                                              : "0.0",
                                        ) *
                                            double.parse(
                                              ratectrl.text.isNotEmpty
                                                  ? ratectrl.text
                                                  : "0.0",
                                            ))
                                            .toString();
                                  }
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Unit:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: unitctrl,
                                focusNode: unit,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Qty:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: qtyctrl,
                                focusNode: qty,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Rate:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: ratectrl,
                                focusNode: rate,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Amount:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: amountctrl,
                                focusNode: amount,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
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
                                  backgroundColor:
                                  Colors.brown, // Button background
                                  foregroundColor:
                                  Colors.white, // Text/icon color
                                ),
                                child: Text("Cancel"),
                              ),
                            ),
                            Container(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (index < 0) {
                                    BillEntryItem newrow = new BillEntryItem(
                                      Item: itemnamectrl.text,
                                      Unit:unitctrl.text,
                                      Qty: qtyctrl.text,
                                      rate: ratectrl.text,
                                      amount: amountctrl.text,
                                    );
                                    item.add(newrow);
                                  } else {
                                    item[index].Item =
                                      itemnamectrl.text;
                                    item[index].Unit =
                                      unitctrl.text;
                                    item[index].Qty =
                                      qtyctrl.text;
                                    item[index].rate =
                                      ratectrl.text;

                                    item[index].amount =
                                      amountctrl.text;
                                  }
                                  Navigator.pop(context);
                                  setState(() {});
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
                                  backgroundColor:
                                  Colors.brown, // Button background
                                  foregroundColor:
                                  Colors.white, // Text/icon color
                                ),
                                child: Text(index < 0 ? "Add" : 'Update'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
