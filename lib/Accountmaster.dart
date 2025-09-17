import 'package:flutter/material.dart';

class Accountmaster extends StatefulWidget {
  const Accountmaster({super.key});

  @override
  State<Accountmaster> createState() => _AccountmasterState();
}

class _AccountmasterState extends State<Accountmaster> {
  TextEditingController Namectrl = TextEditingController();
  TextEditingController Emailctrl = TextEditingController();
  TextEditingController Mobilenoctrl = TextEditingController();
  TextEditingController Openingctrl = TextEditingController();
  FocusNode Name = FocusNode();
  FocusNode Email = FocusNode();
  FocusNode Mobileno = FocusNode();
  FocusNode Opening = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          "Add New Account",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              TextFormField(
                controller: Namectrl,
                focusNode: Name,
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
              SizedBox(height: 5),
              Text('Email:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              TextFormField(
                controller: Emailctrl,
                focusNode: Email,
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
              SizedBox(height: 5),
              Text(
                'Mobile No:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: Mobilenoctrl,
                focusNode: Mobileno,
                keyboardType: TextInputType.number,
                maxLength: 10,
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
              Text('Opening:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              TextFormField(
                controller: Openingctrl,
                focusNode: Opening,
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
            ],
          ),
        ),
      ),
    );
  }
}
