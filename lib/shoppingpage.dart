import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/shoppingpagemodel.dart';

class Shoppingpage extends StatefulWidget {
  const Shoppingpage({super.key});

  @override
  State<Shoppingpage> createState() => _ShoppingpageState();
}

class _ShoppingpageState extends State<Shoppingpage> {
  List<Product> entries = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts(); //pagr vr alya alya data get kraycha api la call krun
  }

  fetchProducts() async {
    final response = await http.get(
      Uri.parse("https://dummyjson.com/products"),
    );

    if (response.statusCode == 200) {
      var resp = jsonDecode(response.body);
      print("resp--->$resp");// to check the repsonse

      entries = (resp['products'] as List)
          .map((e) => Product.fromJson(e))
          .toList();
      print("entries-->$entries");//bind all data in model for better understanding
// JSON -> List
      setState(() {});//entries chi list update vayla
    } else {
      throw Exception("Failed to load products");
    }
  } //api call kraycha syntax

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi Dhanraj",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                "Good Morning",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: entries.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (context, index) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
