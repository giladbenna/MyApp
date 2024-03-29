import 'package:flutter/material.dart';
import 'package:my_app/views/MenuPage.dart';
import 'package:my_app/views/FavoritesPage.dart';
import 'package:my_app/views/ProfilePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  double _linePosition = 0;

  @override
  void initState() {
    super.initState();
    // Set initial line position based on the selected index
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        _updateLinePosition(_selectedIndex, MediaQuery.of(context).size.width));
  }

  // Update line position based on the selected index
  void _updateLinePosition(int index, double screenWidth) {
    double itemWidth = screenWidth / 3; // Assuming 3 items for simplicity
    setState(() {
      _selectedIndex = index;
      _linePosition = itemWidth * index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          MenuPage(),
          FavoritesPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white, // Background color of the bottom bar
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              margin: EdgeInsets.only(left: _linePosition, top: 0),
              width: screenWidth / 3, // Width based on number of items
              height: 5.0,
              color: Colors.amber[800], // Line color
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int index = 0; index < 3; index++)
                  GestureDetector(
                    onTap: () => _updateLinePosition(index, screenWidth),
                    child: Container(
                      width: screenWidth / 3,
                      height: kToolbarHeight,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            index == 0
                                ? Icons.explore_outlined
                                : index == 1
                                    ? Icons.favorite_border
                                    : Icons.account_circle_outlined,
                            color: _selectedIndex == index
                                ? Colors.black
                                : Colors.grey,
                          ),
                          Text(
                            index == 0
                                ? 'Discovery'
                                : index == 1
                                    ? 'Favorites'
                                    : 'Profile',
                            style: TextStyle(
                              fontFamily:
                                  'primeryFont', // Replace with your actual font
                              color: _selectedIndex == index
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
