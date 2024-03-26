import 'package:flutter/material.dart';
import 'package:my_app/views/AnimalMenuPage.dart';

class MyImageCollageWithURLs extends StatelessWidget {
  final String imageUrl1;
  final String imageUrl2;
  final String imageUrl3;
  final String imageUrl4;

  MyImageCollageWithURLs({
    required this.imageUrl1,
    required this.imageUrl2,
    required this.imageUrl3,
    required this.imageUrl4,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(16.0), // Apply rounded corners here
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 235, 214, 177),
                  Color.fromARGB(255, 198, 151, 74),
                ],
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1, // Adjust flex as needed
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child:
                                  Image.network(imageUrl1, fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: Image.network(imageUrl2,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: Image.network(imageUrl3,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 180,
                        left: 10,
                        child: Text(
                          'Learn About Animals',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'titleFont',
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.network(imageUrl4, fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 140,
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AnimalMenuPage()),
                            );
                          },
                          label: Text(
                            "See Animals",
                            style: TextStyle(
                              fontFamily: 'primeryFont',
                            ),
                          ),
                          icon: Icon(Icons.pets),
                          backgroundColor: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                        ),
                      ),
                    ],
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
