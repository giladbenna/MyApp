import 'package:flutter/material.dart';
import 'package:my_app/models/ImportantThing.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemShopPage extends StatelessWidget {
  final List<ImportantThing> unselectedItems;

  const ItemShopPage({Key? key, required this.unselectedItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Missing Items'),
      ),
      body: SingleChildScrollView(
        // Make the entire screen scrollable
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/images/dont_forget_pic.png',
                fit: BoxFit.cover,
                width: MediaQuery.of(context)
                    .size
                    .width, // Full width of the device
              ),
            ),
            SizedBox(height: 20),
            // Dynamically generate a list of cards
            Column(
              children: unselectedItems.map((item) {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment
                          .stretch, // Stretch row items to fit the card height
                      children: [
                        Image.network(
                          item.imageUrl,
                          fit: BoxFit.cover,
                          width: 100, // Fixed width for the image
                          height: 100, // Fixed height for a uniform look
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, // Space between the text and the button
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title!,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ), // Item title
                                    SizedBox(height: 4),
                                    Text(
                                      'Price: \$${item.price.toString()}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Color.fromARGB(232, 66, 107, 31)),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment
                                      .bottomRight, // Align button to the bottom-right
                                  child: ElevatedButton.icon(
                                    onPressed: () =>
                                        _launchURL(item.link), // Launch the URL
                                    icon: Icon(Icons.shopping_cart,
                                        size: 16), // Icon inside the button
                                    label: Text(
                                        "Show Me"), // Text inside the button
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                          Color.fromARGB(255, 90, 162, 221),
                                      textStyle: TextStyle(fontSize: 14),
                                    ),
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
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
