import 'package:flutter/material.dart';
import 'package:my_app/models/ImageData.dart';
import 'package:my_app/services/ImageService.dart';
import 'package:my_app/views/CategoryTripPage.dart';
import 'package:my_app/views/AnimalMenu.dart';
import 'package:my_app/widgets/CustomSearchBar%20.dart';
//import 'package:my_app/widgets/MyImageCollage%20.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final ImageService _imageService = ImageService();

  String searchQuery = "";

  final String urlAnimals =
      'https://t4.ftcdn.net/jpg/04/15/79/09/360_F_415790935_7va5lMHOmyhvAcdskXbSx7lDJUp0cfja.jpg';
  final String urlMenu =
      'https://www.10wallpaper.com/wallpaper/1152x864/1606/Backpackers_Travel_aesthetic-2016_Sport_HD_Wallpaper_1152x864.jpg';

  //https://wallpapers.com/images/featured/travel-hd-axhrsecphqby11wk.jpg

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      urlMenu,
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 30,
                      bottom: 130,
                      child: Text(
                        "Make Memoris On Your \nNext Trip HII ",
                        style: TextStyle(
                          fontFamily: 'titleFont',
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 3.0,
                              color: Color.fromARGB(150, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      bottom: 80,
                      child: Text(
                        "Choose A Category \nAnd Move 1 Step Closer To Your New Trip", // Replace with your desired text
                        style: TextStyle(
                          fontFamily: 'primeryFont',
                          fontSize: 12, // Adjust the font size as needed
                          fontWeight: FontWeight.bold,
                          color: Colors
                              .white, // Choose text color that contrasts well with the image
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 3.0,
                              color: Color.fromARGB(150, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              CustomSearchBar(
                onSearchChanged: (query) {
                  setState(() {
                    searchQuery = query.toLowerCase();
                  });
                },
              ),
              SizedBox(height: 20),
              FutureBuilder<List<ImageData>>(
                future: _imageService.loadImageData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    final List<ImageData> filteredData =
                        snapshot.data!.where((item) {
                      return item.title.toLowerCase().contains(searchQuery);
                    }).toList();

                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(191, 172, 202, 1)
                                .withOpacity(0.0), // Top: Fully transparent
                            Color.fromRGBO(50, 247, 109, 1)
                                .withOpacity(0.7), // Transition to solid
                            Color.fromRGBO(
                                50, 247, 109, 1), // Solid central part
                            Color.fromRGBO(50, 247, 109, 1)
                                .withOpacity(0.7), // Transition back to color
                            Color.fromRGBO(191, 172, 202, 1)
                                .withOpacity(0.0), // Bottom: Fully transparent
                          ],
                          stops: const [
                            0.0,
                            0.05,
                            0.5,
                            0.95,
                            1.0
                          ], // Adjust these stops to control the blend area
                        ),
                      ),
                      padding: const EdgeInsets.only(
                          bottom: 30.0, left: 10.0, right: 10.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: filteredData.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CategoryTripPage(
                                      category: filteredData[index].category!),
                                ),
                              );
                            },
                            child: Container(
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        filteredData[index].url,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    right:
                                        10, // Adjust the position according to your UI
                                    bottom:
                                        10, // Adjust the position according to your UI
                                    child: Icon(
                                      Icons
                                          .arrow_forward_ios, // Right arrow icon
                                      color: Colors.white, // Icon color
                                      size: 24, // Icon size
                                    ),
                                  ),
                                  const Positioned(
                                    right:
                                        20, // Adjust the position according to your UI
                                    bottom:
                                        10, // Adjust the position according to your UI
                                    child: Icon(
                                      Icons
                                          .arrow_forward_ios, // Right arrow icon
                                      color: Colors.white, // Icon color
                                      size: 24, // Icon size
                                    ),
                                  ),
                                  Positioned(
                                    right: 45, // Close to the edge
                                    bottom: 9, // Aligned with the icon
                                    child: Text(
                                      filteredData[index]
                                          .title, // Text to be displayed
                                      style: const TextStyle(
                                        fontFamily: 'titleFont',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white, // Text color
                                        fontSize: 18, // Text size
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(1.0,
                                                1.0), // Horizontal and vertical offset
                                            blurRadius: 3.0, // The blur radius
                                            color: Color.fromARGB(
                                                255, 0, 0, 0), // Shadow color
                                          ),

                                          // Add more Shadow objects if you want multiple shadows or a more complex effect
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              SizedBox(height: 20),
              // SizedBox(
              //   // Providing a specific height to the widget that contains Expanded widgets
              //   height: 600, // Adjust this height according to your needs
              //   child: MyImageCollageWithURLs(
              //     imageUrl1: urlAnimals,
              //     imageUrl2: urlAnimals,
              //     imageUrl3: urlAnimals,
              //   ),
              // ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AnimalMenu()),
                  );
                },
                child: Container(
                  width: double
                      .infinity, // Makes the container take up all available width
                  height: 400, // Set a fixed height for your button
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          urlAnimals), // Replace with your image URL
                      fit: BoxFit
                          .cover, // Covers the area of the button without stretching the image
                    ),
                    borderRadius: BorderRadius.circular(
                        10), // Optional: if you want rounded corners
                  ),
                  child: Center(
                    child: Text(
                      'Go to Animal Menu',
                      style: TextStyle(
                        color: Colors
                            .white, // Choose a color that contrasts well with your image
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // backgroundColor: Color.fromRGBO(
      //     255, 253, 208, 1), // Set the light cream background color here
    );
  }
}
