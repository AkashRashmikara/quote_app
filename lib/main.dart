import 'package:flutter/material.dart';
import 'home.dart';
import 'collections.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quote App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          headlineMedium: TextStyle(fontWeight: FontWeight.w700),
          bodyLarge: TextStyle(fontSize: 16.0),
        ),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          headlineMedium: TextStyle(fontWeight: FontWeight.w700),
          bodyLarge: TextStyle(fontSize: 16.0),
        ),
      ),
      themeMode: ThemeMode.system,
      home: MainTabScreen(),
    );
  }
}

class MainTabScreen extends StatefulWidget {
  @override
  _MainTabScreenState createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _selectedIndex = 0;
  
  static final List<Widget> _screens = [
    HomeScreen(),
    CollectionsScreen(),
  ];
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.format_quote),
              label: 'Quotes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.collections_bookmark),
              label: 'Collections',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).brightness == Brightness.dark 
              ? Colors.greenAccent 
              : Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}