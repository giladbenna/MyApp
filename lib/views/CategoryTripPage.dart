import 'package:flutter/material.dart';
import 'package:my_app/models/CategoryTripCard.dart';
import 'package:my_app/services/ImageService.dart';
import 'package:my_app/views/TripInformationPage.dart';
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
        title: Text("Category - ${widget.category}"),
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
              FutureBuilder<List<CategoryTripCard>>(
                future:
                    _imageService.loadImageDetailsByCategory(widget.category),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap:
                          true, // Important to keep the ListView within the SingleChildScrollView
                      physics:
                          NeverScrollableScrollPhysics(), // To use ListView inside SingleChildScrollView
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        CategoryTripCard item = snapshot.data![index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 15),
                          width: double.infinity, // Full width of the parent
                          height: 200, // Fixed height for the card
                          child: Card(
                            color: Colors
                                .white, // Set the card's background color to white
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Rounded corners for the card
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        10.0), // Top left corner
                                    bottomLeft: Radius.circular(
                                        10.0), // Bottom left corner
                                  ),
                                  child: Image.network(
                                    item.url,
                                    fit: BoxFit.cover,
                                    width:
                                        190, // Specify your desired width for the image
                                    height:
                                        200, // Make the image fill the card height
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        8.0), // Add padding around the text
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.title,
                                          style: TextStyle(
                                            fontFamily: 'titleFont',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          item.subTitle, // SubTitle part
                                          style: TextStyle(
                                            fontFamily: 'titleFont',
                                            fontSize: 12,
                                            color: Color.fromARGB(
                                                255, 155, 154, 148),
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        SizedBox(height: 40),
                                        Container(
                                          width: 200,
                                          child: ElevatedButton.icon(
                                            icon: Image.asset(
                                                'assets/images/show_me_icon_removebg.png',
                                                width: 32),
                                            label: Text(
                                              'Show Me',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      220, 11, 3, 133)),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white70),
                                            ),
                                            onPressed: () {
                                              // Use Navigator to push TripInformationPage onto the stack
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TripInformationPage(
                                                    imageId: item.id,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          item.location, // SubTitle part
                                          style: TextStyle(
                                            fontFamily: 'titleFont',
                                            fontSize: 12,
                                            color:
                                                Color.fromARGB(255, 27, 27, 27),
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
