import 'package:flutter/material.dart';
import 'home.dart';
import 'collections.dart';

/// Entry point - Quote App.
void main() {
  runApp(myApp());
}

/// The main widget 
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

/// MainTabScreen is the screen that contains the bottom navigation for navigating between the Home and Collections screens.
class MainTabScreen extends StatefulWidget {
  @override
  _MainTabScreenState createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  /// The index of the currently selected tab in the bottom navigation.
  int _selectedIndex = 0;

  /// A list of screens to be displayed for each tab.
  static final List<Widget> _screens = [
    HomeScreen(),  
    CollectionsScreen(), 
  ];

  /// This function is called when an item in the bottom navigation is tapped.
  /// It updates the selected tab index.
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
