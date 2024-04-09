import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_app/Providers/CatagoryProvider.dart';
import 'package:my_app/models/RecommendTripDetails.dart';
import 'package:my_app/services/TripDetailsService.dart';
import 'package:my_app/widgets/ImageSlider.dart';
import 'package:provider/provider.dart';

class RecommendTripDetailsPage extends StatefulWidget {
  final String tripId;

  RecommendTripDetailsPage({Key? key, required this.tripId}) : super(key: key);

  @override
  _RecommendTripDetailsPageState createState() =>
      _RecommendTripDetailsPageState();
}

class _RecommendTripDetailsPageState extends State<RecommendTripDetailsPage> {
  late Future<RecommendTripDetails> tripDetail;

  @override
  void initState() {
    super.initState();
    final selectedCategory =
        Provider.of<CategoryProvider>(context, listen: false).selectedCategory;
    tripDetail =
        TripDetailsService().fetchTripDetails(selectedCategory, widget.tripId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<RecommendTripDetails>(
        future: tripDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final tripDetails = snapshot.data!; // Variable for easier access
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ImageSlider(imageUrls: tripDetails.urls),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        tripDetails.subTitle,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontFamily: 'titleFont'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        tripDetails.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'titleFont',
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RatingBarIndicator(
                            rating: tripDetails.rates,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            tripDetails.rates.toString(),
                            style: const TextStyle(fontFamily: 'primeryFont'),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '${tripDetails.reviews} reviews',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          // fontFamily: 'primeryFont',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        tripDetails.description,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "About this activity",
                        style: TextStyle(
                            fontFamily: 'titleFont',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                          child: Text(
                            'Most Popular Days',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey,
                                  width: 0.5), // Border color and width
                              borderRadius: BorderRadius.circular(
                                  20), // Rounded corners of the border
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  10), // This padding ensures content is not too close to the border
                              child: Container(
                                height:
                                    40, // Fixed height for the inner container
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    'Mon',
                                    'Tue',
                                    'Wed',
                                    'Thu',
                                    'Fri',
                                    'Sat',
                                    'Sun'
                                  ].map((day) {
                                    final bool isPopular =
                                        tripDetails.popularDays.contains(day);
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal:
                                              4.0), // Space between days
                                      decoration: BoxDecoration(
                                        color: isPopular
                                            ? Colors.blue[300]
                                            : Colors.grey[
                                                300], // Highlight popular days with color
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: isPopular ? 12 : 8,
                                          vertical:
                                              8), // Adjust width by padding
                                      alignment: Alignment.center,
                                      child: Text(
                                        day,
                                        style: TextStyle(
                                          color: isPopular
                                              ? Colors.white
                                              : Colors
                                                  .black, // Text color contrast
                                          fontWeight: isPopular
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FutureBuilder<RecommendTripDetails>(
                  future: tripDetail,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'From \n',
                              style: TextStyle(
                                fontSize: 14, // Smaller font size for "From"
                                color: Colors
                                    .black, // Explicitly set the color for TextSpan
                                fontWeight: FontWeight.normal, // Regular weight
                              ),
                            ),
                            TextSpan(
                              text: '\$${snapshot.data!.cost.toString()} ',
                              style: const TextStyle(
                                fontSize: 20, // Bigger font size for the cost
                                color: Colors.black,
                                fontWeight:
                                    FontWeight.bold, // Bold weight for the cost
                              ),
                            ),
                            const TextSpan(
                              text: 'per person',
                              style: TextStyle(
                                fontSize:
                                    14, // Smaller font size for "per person"
                                color: Colors.black,
                                fontWeight: FontWeight.normal, // Regular weight
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Ensure text color is consistent
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ElevatedButton(
                  onPressed: () {
                    // Implement what happens when the button is pressed
                  },
                  child: const Text(
                    'Check Availability',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 162, 255),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
