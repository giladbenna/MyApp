import 'package:flutter/material.dart';
import 'package:my_app/Providers/CatagoryProvider.dart';
import 'package:my_app/models/ImageData.dart';
import 'package:my_app/services/ImageService.dart';
import 'package:my_app/views/CategoryTripPage.dart';
import 'package:my_app/widgets/CustomSearchBar%20.dart';
import 'package:my_app/widgets/MyImageCollage%20.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final ImageService _imageService = ImageService();

  String searchQuery = "";

  final String urlAnimals =
      'https://t4.ftcdn.net/jpg/04/15/79/09/360_F_415790935_7va5lMHOmyhvAcdskXbSx7lDJUp0cfja.jpg';
  List<String> animalsUrls = [
    'https://static.nationalgeographic.es/files/expeditions.jpg?url=https://www.nationalgeographicexpeditions.eu/wp-content/uploads/2020/06/leopard-okavango-delta-botswana-shutterstock-240308062-750x400.jpg',
    'https://img.theweek.in/content/dam/week/news/sci-tech/image/nature-animals-evolution-shut.jpg',
    'https://res.cloudinary.com/enchanting/q_70,f_auto,w_600,h_400,c_fit/ymt-web/2023/01/Lions-South-Africa.jpg',
    'https://www.tripsavvy.com/thmb/QoBsYHGxoSaqCM50IbLZoqtEQE0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-200571828-001-57b6d0f45f9b58cdfd5cfe75.jpg',
    'https://media.istockphoto.com/id/1702675982/photo/the-most-well-known-animals-in-africa-walk-in-group-across-the-plain.webp?b=1&s=170667a&w=0&k=20&c=YTobTpqhayS_PKls7fk7SX8IqFkaPEH30L-M9rjzlWY='
  ];

  final String urlMenu =
      'https://www.10wallpaper.com/wallpaper/1152x864/1606/Backpackers_Travel_aesthetic-2016_Sport_HD_Wallpaper_1152x864.jpg';

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
                    const Positioned(
                      left: 30,
                      bottom: 130,
                      child: Text(
                        "Make Memoris On Your \nNext Trip",
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

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        color: Color.fromARGB(30, 28, 203, 159),
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
                                Provider.of<CategoryProvider>(context,
                                        listen: false)
                                    .updateCategory(
                                        filteredData[index].category);

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CategoryTripPage(
                                        category: filteredData[index].category),
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
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white, // Text color
                                          fontSize: 18, // Text size
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(1.0,
                                                  1.0), // Horizontal and vertical offset
                                              blurRadius:
                                                  3.0, // The blur radius
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
              SizedBox(
                // Providing a specific height to the widget that contains Expanded widgets
                height: 500, // Adjust this height according to your needs
                child: MyImageCollageWithURLs(
                  imageUrl1: animalsUrls[0],
                  imageUrl2: animalsUrls[3],
                  imageUrl3: animalsUrls[2],
                  imageUrl4: animalsUrls[1],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
