import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_app/Providers/CatagoryProvider.dart';
import 'package:my_app/models/RecommendTripCard.dart';
import 'package:my_app/services/TripCardsService.dart';
import 'package:my_app/views/RecommendTripDetailsPage.dart';
import 'package:provider/provider.dart';

class TripCardsSlide extends StatefulWidget {
  final String id;

  TripCardsSlide({Key? key, required this.id}) : super(key: key);

  @override
  _TripCardsSlideState createState() => _TripCardsSlideState();
}

class _TripCardsSlideState extends State<TripCardsSlide> {
  Future<List<RecommendTripCard>> futureItems = Future.value([]);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedCategory =
          Provider.of<CategoryProvider>(context, listen: false)
              .selectedCategory;
      print("Selected Category: $selectedCategory");

      // Ensure this method sets the futureItems correctly.
      futureItems = TripCardsService()
          .fetchTripCardsByCategoryAndId(selectedCategory, widget.id);

      // If you need to refresh the UI once this future is set, call setState.
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RecommendTripCard>>(
      future: futureItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          return ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              color: Color.fromARGB(45, 28, 203, 159),
              height: 340, // Increased height to accommodate all elements
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  RecommendTripCard tripCard = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the details page and pass the trip ID.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecommendTripDetailsPage(
                              tripIdCard: tripCard.id, tripId: widget.id),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      margin: EdgeInsets.all(8),
                      child: Container(
                        width: 180,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(8.0)),
                              child: Image.network(
                                tripCard.urlPicture,
                                height: 150, // Half of the container height
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                tripCard.subTitle,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'primeryFont'),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                tripCard.title,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'titleFont'),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: Text(
                                "${tripCard.time} hours",
                                style: TextStyle(
                                    fontSize: 11, fontFamily: 'primeryFont'),
                              ),
                            ),
                            SizedBox(height: 30),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7.0),
                                  child: RatingBarIndicator(
                                    rating: tripCard.rate,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                  ),
                                ),
                                Text(
                                  tripCard.rate.toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black, // Default text color
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'From ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: '\$${tripCard.cost.toString()}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: ' per person',
                                      // Default style is applied, so it's not bold.
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
