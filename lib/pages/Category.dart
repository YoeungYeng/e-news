import 'dart:convert';

import 'package:e_app/model/Category.dart';
import 'package:e_app/model/Connetion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool isLoading = false;
  List<Data> allCategory = [];

  Future<void> getCategory() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final String url = "${Connetion.conn}/category";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedBody = jsonDecode(response.body);
        final List<dynamic> result =
            (decodedBody['data'] as List<dynamic>?) ?? [];

        setState(() {
          allCategory = result.map((e) => Data.fromJson(e)).toList();
          isLoading = false;
        });
        isLoading = false;

        print("result $result");
        print("Data ${allCategory.toString()}");
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    getCategory();
    // push notication
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Category"), centerTitle: true),
      body: Column(
          children: [
            // title
            Text(""),
            // subtitle
            Text("")
            // image
            // description
            
          ]
      ),
    );
  }
}
