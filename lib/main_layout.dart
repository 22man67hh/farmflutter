import 'package:flutter/material.dart';
import 'package:flutter_project/crop-page.dart';
import 'package:flutter_project/home-page.dart';

class MainLayout extends StatefulWidget {
  // final String title;
  // final Widget floatingActionButton;
  final List<Widget>? actions;
  const MainLayout({
    super.key,
    // required this.title,
    // required this.floatingActionButton,
    this.actions,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  // final List<String> _titles = ['Home', 'Crop', 'Logout']; // unused
  final List<Widget> _screens = 
  [
 HomePage(),
  CropPage(),
    Center(child: Text('Logout'),),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
     
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.energy_savings_leaf),
              label: 'Crop',
              activeIcon: Icon(Icons.energy_savings_leaf_outlined),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'Logout',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor:  const Color.fromARGB(255, 110, 196, 11),
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      );
    
  }
}
