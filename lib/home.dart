
import 'dart:math';
import 'package:flutter/material.dart';
import 'quote.dart';
import 'quotes_data.dart';
import 'details.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  String selectedCategory = "Motivational"; 
  late Quote currentQuote;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  int currentQuoteIndex = 0;
  int totalQuotes = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    getRandomQuote();
  }

  void getRandomQuote() {
    final categoryQuotes = quotes.where((q) => q.category == selectedCategory).toList();
    if (categoryQuotes.isNotEmpty) {
      totalQuotes = categoryQuotes.length;
      setState(() {
        currentQuoteIndex = Random().nextInt(totalQuotes);
        currentQuote = categoryQuotes[currentQuoteIndex];
        _controller.reset();
        _controller.forward();
      });
    }
  }

  List<String> getCategories() {
    return quotes.map((quote) => quote.category).toSet().toList();
  }

  void nextQuote() {
    final categoryQuotes = quotes.where((q) => q.category == selectedCategory).toList();
    if (categoryQuotes.isNotEmpty) {
      setState(() {
        currentQuoteIndex = (currentQuoteIndex + 1) % categoryQuotes.length;
        currentQuote = categoryQuotes[currentQuoteIndex];
        _controller.reset();
        _controller.forward();
      });
    }
  }

  void previousQuote() {
    final categoryQuotes = quotes.where((q) => q.category == selectedCategory).toList();
    if (categoryQuotes.isNotEmpty) {
      setState(() {
        currentQuoteIndex = (currentQuoteIndex - 1 + categoryQuotes.length) % categoryQuotes.length;
        currentQuote = categoryQuotes[currentQuoteIndex];
        _controller.reset();
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Daily Quotes", 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          )
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode 
                ? [Color(0xFF1E1E1E), Color(0xFF121212)] 
                : [Color(0xFFE6F3EC), Color(0xFFD1E8E2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black45 : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedCategory,
                      isExpanded: true,
                      dropdownColor: isDarkMode ? Colors.grey[900] : Colors.white,
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                        color: isDarkMode ? Colors.white70 : Colors.blueGrey,
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                          getRandomQuote();
                        });
                      },
                      items: getCategories().map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailsScreen(quote: currentQuote)),
                    );
                  },
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity! > 0) {
                      previousQuote();
                    } else if (details.primaryVelocity! < 0) {
                      nextQuote();
                    }
                  },
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: isDarkMode 
                                  ? Colors.teal.withOpacity(0.1)
                                  : Colors.teal.withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(100),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 0,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.amber.withOpacity(0.1)
                                  : Colors.amber.withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(100),
                              ),
                            ),
                          ),
                        ),
                        
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 24),
                            padding: EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey[850]!.withOpacity(0.7)
                                  : Colors.white.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.format_quote,
                                  color: isDarkMode
                                      ? Colors.tealAccent.withOpacity(0.4)
                                      : Colors.teal.withOpacity(0.4),
                                  size: 40,
                                ),
                                SizedBox(height: 16),
                                
                                Text(
                                  currentQuote.text,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    height: 1.4,
                                    color: isDarkMode ? Colors.white : Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 24),
                                
                                Text(
                                  "- ${currentQuote.author}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    color: isDarkMode ? Colors.white70 : Colors.black54,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                
                                SizedBox(height: 24),
                                
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${currentQuoteIndex + 1}/${totalQuotes}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isDarkMode ? Colors.white54 : Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: previousQuote,
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                      iconSize: 28,
                    ),
                    
                    ElevatedButton(
                      onPressed: getRandomQuote,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        backgroundColor: isDarkMode ? Colors.tealAccent : Colors.teal,
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shuffle),
                          SizedBox(width: 8),
                          Text(
                            "Random",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    IconButton(
                      onPressed: nextQuote,
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                      iconSize: 28,
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
}
