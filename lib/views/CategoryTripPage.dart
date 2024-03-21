import 'package:flutter/material.dart';
import 'package:my_app/models/ImageData.dart';
import 'package:my_app/services/ImageService.dart';
import 'package:my_app/views/InformationPage.dart';
import 'package:my_app/widgets/CustomSearchBar%20.dart';

class CategoryTripPage extends StatefulWidget {
  final String category;

  const CategoryTripPage({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryTripPageState createState() => _CategoryTripPageState();
}

class _CategoryTripPageState extends State<CategoryTripPage> {
  final ImageService _imageService = ImageService();
  String searchQuery = ""; // State to hold the current search query

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CategoryTrip'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchBar(
                onSearchChanged: (query) {
                  setState(() {
                    searchQuery = query.toLowerCase();
                  });
                },
              ),
              SizedBox(height: 20),
              FutureBuilder<List<ImageData>>(
                future:
                    _imageService.loadImageDetailsByCategory(widget.category),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    // Filter picturesData based on the searchQuery
                    final List<ImageData> filteredData =
                        snapshot.data!.where((item) {
                      return item.title.toLowerCase().contains(searchQuery);
                    }).toList();

                    return ListView.builder(
                      itemCount: filteredData.length,
                      shrinkWrap: true,
                      physics:
                          NeverScrollableScrollPhysics(), // To disable scrolling within the ListView
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Center(
                                child: Text(
                                  filteredData[index].title,
                                  style: TextStyle(
                                      fontFamily: 'titleFont',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TripInformation(
                                      imageId: filteredData[index].id,
                                      imageCategory: widget.category,
                                    ),
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      filteredData[index].url,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    right:
                                        10, // Adjust the position according to your design
                                    bottom:
                                        20, // Adjust the position according to your design
                                    child: Icon(
                                      Icons
                                          .arrow_forward, // The right arrow icon
                                      color: Colors.white, // Icon color
                                      size: 35, // Icon size, adjust as needed
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
