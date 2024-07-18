import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CustomSwiper extends StatelessWidget {
  const CustomSwiper({
    super.key,
    required this.images,
    required this.height,
    required this.isWholePage,
    this.duration = kDefaultAutoplayTransactionDuration,
    this.autoDelayDuration = kDefaultAutoplayDelayMs,
  });

  final List<String> images;
  final double height;
  final bool isWholePage;
  final int duration;
  final int autoDelayDuration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Swiper(
        curve: Curves.fastEaseInToSlowEaseOut,
        duration: duration,
        autoplayDelay: autoDelayDuration,
        autoplay: true,
        itemCount: images.length,
        itemBuilder: ((context, index) {
          return Image.asset(
            images[index],
            fit: BoxFit.cover,
          );
        }),
        pagination: !isWholePage
            ? const SwiperPagination(
                alignment: Alignment.bottomCenter,
                builder: DotSwiperPaginationBuilder(
                  activeColor: Colors.red,
                ),
              )
            : null,
      ),
    );
  }
}
