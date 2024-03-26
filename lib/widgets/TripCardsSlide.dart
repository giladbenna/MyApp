import 'package:flutter/material.dart';
import 'package:my_app/models/RecommendTripCard.dart';
import 'package:my_app/services/TripCardsService.dart';

class TripCardsSlide extends StatefulWidget {
  final String id;

  TripCardsSlide({Key? key, required this.id}) : super(key: key);

  @override
  _TripCardsSlideState createState() => _TripCardsSlideState();
}

class _TripCardsSlideState extends State<TripCardsSlide> {
  late Future<List<RecommendTripCard>> futureItems;

  @override
  void initState() {
    super.initState();
    futureItems = TripCardsService().fetchVacationTripCardsById(
        widget.id); // Fetch items when the widget is initialized
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

          return Container(
            height: 200, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                RecommendTripCard item = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: Container(
                    width: 160, // Adjust the width of each card as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.network(item.urlPicture, fit: BoxFit.cover),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.title,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text(item.subTitle,
                              style: TextStyle(fontSize: 14)),
                        ),
                        // Add more details from the item here
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
