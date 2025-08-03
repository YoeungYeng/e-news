import 'dart:io';

import 'package:e_app/pages/BookMark.dart';
import 'package:e_app/pages/Category.dart';
import 'package:e_app/pages/Explore.dart';
import 'package:e_app/pages/Home.dart';
import 'package:e_app/pages/Setting.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  const Layout({super.key, required this.category_id});
  final dynamic category_id;

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int selectedIndex = 0;
  final List<Widget> _screens = [Home(categoryId: null,), Explore(), Bookmark(), Setting()];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.redAccent,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.black87,
        onTap: _onItemTapped,
        items: const [

          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
