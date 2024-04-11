import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/models/CategoryTripCard.dart';
import 'package:my_app/services/CategoryTripService.dart';
import 'package:my_app/views/TripInformationPage.dart';
import 'package:my_app/widgets/CustomSearchBar%20.dart';

final favoriteProvider =
    StateProvider.autoDispose.family<bool, String>((ref, id) => false);

class CategoryTripPage extends StatefulWidget {
  final String category;

  const CategoryTripPage({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryTripPageState createState() => _CategoryTripPageState();
}

class _CategoryTripPageState extends State<CategoryTripPage> {
  String searchQuery = "";
  final CategoryTripService _tripService = CategoryTripService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Category - ${widget.category}")),
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
              const SizedBox(height: 20),
              FutureBuilder<List<CategoryTripCard>>(
                future: _tripService.loadItems(widget.category),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    var filteredList = snapshot.data!.where((item) {
                      return item.title.toLowerCase().contains(searchQuery) ||
                          item.subTitle.toLowerCase().contains(searchQuery) ||
                          item.location.toLowerCase().contains(searchQuery);
                    }).toList();

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        var item = filteredList[index];
                        return Card(
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0)),
                                    child: Image.network(item.url,
                                        fit: BoxFit.cover,
                                        width: 190,
                                        height: 200),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.title,
                                            style: const TextStyle(
                                                fontFamily: 'titleFont',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300),
                                            overflow: TextOverflow.clip,
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            item.subTitle,
                                            style: const TextStyle(
                                                fontFamily: 'titleFont',
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 155, 154, 148),
                                                fontWeight: FontWeight.w300),
                                          ),
                                          const SizedBox(height: 40),
                                          Container(
                                            width: 200,
                                            child: ElevatedButton.icon(
                                              icon: Image.asset(
                                                  'assets/images/show_me_icon_removebg.png',
                                                  width: 32),
                                              label: const Text('Show Me',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          220, 11, 3, 133))),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white70)),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TripInformationPage(
                                                              imageId:
                                                                  item.id)),
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            item.location,
                                            style: const TextStyle(
                                                fontFamily: 'titleFont',
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 27, 27, 27),
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top:
                                    30, // Adjust as necessary to align with your design
                                right:
                                    8, // Adjust as necessary to align with your design
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    // Notice change from 'watch' to 'ref'
                                    // Correctly access the provider for a specific item ID using 'ref.watch'
                                    final isFavorited =
                                        ref.watch(favoriteProvider(item.id));
                                    return IconButton(
                                      icon: Icon(
                                        isFavorited
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        // Correctly toggle the favorite state using 'ref.read' for accessing the notifier
                                        _toggleFavorite(item, !isFavorited);
                                        ref
                                            .read(favoriteProvider(item.id)
                                                .notifier)
                                            .state = !isFavorited;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleFavorite(CategoryTripCard item, bool isFavorite) async {
    // item.favorite = !item.favorite;
    await _tripService.updateFavoriteStatus(
        widget.category, item.id, isFavorite);
  }
}
