import 'package:adminpanel/kababjees.dart';
import 'package:adminpanel/studio7teas.dart';
import 'package:adminpanel/sweetcreme.dart';

import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final int initialIndex;

  const BottomNavigation({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int currentindex;

  @override
  void initState() {
    super.initState();
    currentindex = widget.initialIndex;
  }

  final screen = [
    Studio7teas(
      onAddProduct: () {},
    ),
    Kababjees(
      onAddProduct: () {},
    ),
    SweetCreme(
      onAddProduct: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentindex,
        children: screen,
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)
            ]),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xff0b1225),
          unselectedItemColor: Colors.black,
          onTap: (index) {
            setState(() {
              currentindex = index;
            });
          },
          currentIndex: currentindex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.local_dining), label: "Studio7teas"),
            BottomNavigationBarItem(
                icon: Icon(Icons.fastfood), label: "kababjees"),
            BottomNavigationBarItem(
                icon: Icon(Icons.icecream), label: "SweetCreme"),
          ],
        ),
      ),
    );
  }
}
