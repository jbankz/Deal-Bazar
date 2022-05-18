import 'package:carousel_slider/carousel_slider.dart';
import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Constants/Assets.dart';
import '../../../../Core/Constants/Colors.dart';

class HomeScreenCarousalSliderWidget extends StatefulWidget {
  @override
  _HomeScreenCarousalSliderWidgetState createState() =>
      _HomeScreenCarousalSliderWidgetState();
}

class _HomeScreenCarousalSliderWidgetState
    extends State<HomeScreenCarousalSliderWidget> {
  int _current = 0;

  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: CarouselSlider(
              items: imageSliders,
              carouselController: _controller,
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(
                    () {
                      _current = index;
                    },
                  );
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageSliders.asMap().entries.map(
              (entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 10.0,
                    height: 10.0,
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (_current == entry.key
                          ? yellowColor
                          : greyColor.withOpacity(0.2)),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
