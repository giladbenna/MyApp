import 'package:flutter/material.dart';
import 'package:my_app/views/AnimalMenu.dart';

class MyImageCollageWithURLs extends StatelessWidget {
  final String imageUrl1;
  final String imageUrl2;
  final String imageUrl3;

  MyImageCollageWithURLs({
    required this.imageUrl1,
    required this.imageUrl2,
    required this.imageUrl3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Image.network(imageUrl1, fit: BoxFit.cover)),
        SizedBox(height: 8),
        Expanded(child: Image.network(imageUrl2, fit: BoxFit.cover)),
        SizedBox(height: 8),
        Expanded(
          child: Stack(
            children: [
              Image.network(imageUrl3, fit: BoxFit.cover),
              Positioned(
                right: 10,
                bottom: 10,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnimalMenu()),
                    );
                  },
                  child: Icon(Icons.pets),
                  backgroundColor: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
