import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSlider extends StatelessWidget {
  final List<String> imageUrls;

  const ImageSlider({Key? key, required this.imageUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 250, // Adjust the height as needed
          child: PageView.builder(
            controller: pageController,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) => Image.network(
              imageUrls[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              bottom: 10), // Adjust padding for optimal positioning
          child: SmoothPageIndicator(
            controller: pageController,
            count: imageUrls.length,
            effect: WormEffect(
              dotColor: Colors.grey[
                  300]!, // Color of inactive dots, ensuring they're visible on a dark background
              activeDotColor: Colors.white, // Color of the active dot
              dotHeight: 10, // Height of the dots
              dotWidth: 10, // Width of the dots
              spacing: 8, // Space between dots
            ),
          ),
        ),
      ],
    );
  }
}
