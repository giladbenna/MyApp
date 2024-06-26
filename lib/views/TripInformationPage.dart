import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/Providers/CatagoryProvider.dart';
import 'package:my_app/models/ImageDataDetails.dart';
import 'package:my_app/models/ImportantThing.dart';
import 'package:my_app/services/ImageService.dart';
import 'package:my_app/views/ItemShopPage.dart';
import 'package:my_app/widgets/TripCardsSlide.dart';
import 'package:provider/provider.dart';

class TripInformationPage extends StatefulWidget {
  final String imageId;

  const TripInformationPage({Key? key, required this.imageId})
      : super(key: key);

  @override
  _TripInformationPageState createState() => _TripInformationPageState();
}

class _TripInformationPageState extends State<TripInformationPage> {
  Future<ImageDataDetails>? _imageDetails;
  final ImageService _imageService = ImageService();
  Set<int> _selectedImages = {};

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedCategory =
          Provider.of<CategoryProvider>(context, listen: false)
              .selectedCategory;
      print("Selected Category: $selectedCategory");

      // Ensure this method sets the futureItems correctly.
      _imageDetails = _imageService.loadImageCategoryDetails(
          widget.imageId, selectedCategory);

      // If you need to refresh the UI once this future is set, call setState.
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Information'),
      ),
      body: FutureBuilder<ImageDataDetails>(
        future: _imageDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final tripDetails = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                            top: 10.0,
                            bottom: 10.0), // Adjust padding as needed

                        color: Color.fromARGB(20, 28, 203, 159),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.bottomLeft,
                              clipBehavior: Clip.none,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.network(
                                    tripDetails.url,
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: -55,
                                  left: 15,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          spreadRadius: 0,
                                          blurRadius: 6,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundImage: NetworkImage(
                                          tripDetails.profileImage),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 65),
                            Text(
                              tripDetails.title,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'titleFont'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              tripDetails.description,
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'primeryFont'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    Container(
                      height: 1,
                      color: Colors.grey,
                    ),

                    SizedBox(height: 20), // Optional spacing

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Important Things For This Trip',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 20, fontFamily: 'titleFont'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Choose the items you already got ! \n      then you can see where to buy them in the next page ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12, fontFamily: 'primeryFont'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    Container(
                      height:
                          140, // Adjust the height if needed to better fit the title
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: tripDetails.importantThings.length,
                        itemBuilder: (context, index) {
                          final importantThing =
                              tripDetails.importantThings[index];
                          return GestureDetector(
                            onTap: () => setState(() {
                              if (_selectedImages.contains(index)) {
                                _selectedImages.remove(index);
                              } else {
                                _selectedImages.add(index);
                              }
                            }),
                            child: Container(
                              width: 100,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: _selectedImages.contains(index)
                                    ? Border.all(
                                        color: Colors.blue,
                                        width:
                                            2) // Highlight selected items with a blue border
                                    : null, // No border for unselected items
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        importantThing.imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    importantThing.title!,
                                    style: TextStyle(fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 20),

                    OutlinedButton(
                      onPressed: () {
                        // we filter to get only the unselected ones based on their indices.
                        List<ImportantThing> unselectedImportantThings =
                            tripDetails
                                .importantThings
                                .asMap()
                                .entries
                                .where((entry) =>
                                    !_selectedImages.contains(entry.key))
                                .map((entry) => entry.value)
                                .toList();

                        // Navigate to the next page, passing the list of unselected ImportantThing objects.
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemShopPage(
                              unselectedItems: unselectedImportantThings,
                            ),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        // Set the minimum size to double.infinity to stretch across the width
                        minimumSize: Size(double.infinity,
                            60), // Increased height for better layout
                        // Define the background color as transparent
                        backgroundColor: Colors.transparent,
                        // Define the shape of the button with rounded corners
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        // Set the side for the outline border and its color
                        side: BorderSide(color: Colors.blue, width: 2),
                        // Ensure the content (text and icon) is centered within the button
                        alignment: Alignment.center,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Use min to keep the content tight
                        children: [
                          Expanded(
                            // Use Expanded to allow the text to take up most of the space
                            child: RichText(
                              textAlign: TextAlign
                                  .center, // Ensure the text is centered
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        'You Are Missing ${tripDetails.importantThings.length - _selectedImages.length} products 😔\n',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'primeryFont',
                                      color: Colors.blue,
                                      fontSize:
                                          22, // Larger text size for the first line
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'If You Like To Buy Them, CLICK ME ?',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily: 'primeryFont',
                                      fontSize:
                                          14, // Smaller text size for the second line
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward, // Use the arrow_forward icon
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 14),

                    Text(
                      "Recommend Trips",
                      style: TextStyle(
                          fontFamily: 'primeryFont',
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),

                    TripCardsSlide(
                      id: tripDetails.id,
                    ),

                    SizedBox(height: 20),

                    // Continues with the grey line separator
                    Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Location: ${tripDetails.location}',
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
