import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemShopPage extends StatelessWidget {
  final List<String> unselectedImages;
  final List<String> unselectedLinks;

  const ItemShopPage(
      {Key? key, required this.unselectedImages, required this.unselectedLinks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if the list is empty
    if (unselectedImages.isEmpty) {
      // The list is empty, show an image and a text message
      return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Center(
          // Center the content
          child: Column(
            children: [
              Image.asset(
                  'assets/images/no_missing_items.png'), // Replace with your asset's path
              SizedBox(height: 20), // Space between the image and the text
              Text(
                'No Missing Items ! \n You Are Ready For The Trip',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    } else {
      // The list is not empty, show the list of items
      return Scaffold(
        appBar: AppBar(
          title: Text('Missing Items'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "In this page Clicking \n'Find Here' \nRedirects you to the vendor's website For purchase details.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            // Insert the dynamic list of images and buttons here
            ...List<Widget>.generate(unselectedImages.length, (index) {
              return Column(
                children: [
                  Image.network(unselectedImages[index], fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: () => _launchURL(unselectedLinks[index]),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10)), // Slightly rounded corners
                        side: BorderSide(
                            color: Colors.blue), // Define the border color
                        backgroundColor:
                            Colors.transparent, // Transparent background
                        minimumSize:
                            Size(double.infinity, 50), // Span over the width
                      ),
                      child: Text('Find Here',
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      );
    }
  }

  void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }
}














// with the top stuck 
// return Scaffold(
//         appBar: AppBar(
//           title: Text('Missing Items'),
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 "In this page Clicking \n'Find Here' \nRedirects you to the vendor's website For purchase details.",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               // This wraps the ListView.builder
//               child: ListView.builder(
//                 itemCount: unselectedImages.length,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       Image.network(unselectedImages[index], fit: BoxFit.cover),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: OutlinedButton(
//                           onPressed: () => _launchURL(unselectedLinks[index]),
//                           style: OutlinedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(
//                                     10)), // Slightly rounded corners
//                             side: BorderSide(
//                                 color: Colors.blue), // Define the border color
//                             backgroundColor:
//                                 Colors.transparent, // Transparent background
//                             minimumSize: Size(
//                                 double.infinity, 50), // Span over the width
//                           ),
//                           child: Text('Find Here',
//                               style: TextStyle(color: Colors.blue)),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       );