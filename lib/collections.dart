import 'package:flutter/material.dart';
import 'quotes_data.dart';

/// start collection this page show only count of quotes 
class CollectionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    Map<String, int> categoryCounts = {};
    for (var quote in quotes) {
      categoryCounts[quote.category] = (categoryCounts[quote.category] ?? 0) + 1;
    }
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE6F3EC),
        title: Text(
          "My Quotes",
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
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
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "${quotes.length} Total Quotes",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
                SizedBox(height: 24),
                
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: categoryCounts.length,
                    itemBuilder: (context, index) {
                      String category = categoryCounts.keys.elementAt(index);
                      int count = categoryCounts[category]!;
                      
                      return CategoryCard(
                        category: category,
                        count: count,
                        index: index,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;
  final int count;
  final int index;
  
  const CategoryCard({
    required this.category,
    required this.count,
    required this.index,
  });
  
  Color getCategoryColor(int index) {
    final colors = [
      Color(0xFFFFA07A),
      Color(0xFF98FB98), 
      Color(0xFFADD8E6), 
      Color(0xFFFFB6C1), 
      Color(0xFFFFDAB9),
      Color(0xFFE0FFFF),
      Color(0xFFD8BFD8), 
      Color(0xFFFFFACD),
    ];
    
    return colors[index % colors.length];
  }
  
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = getCategoryColor(index);
    
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Category filtering coming soon')),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode 
              ? cardColor.withOpacity(0.2)
              : cardColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -15,
              bottom: -15,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: cardColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    count.toString(),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "quotes",
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.white38 : Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}