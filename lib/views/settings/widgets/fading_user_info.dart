import 'package:flutter/material.dart';
import 'package:grocery/core/widgets/custom_fading_animation_manager.dart';
import 'package:grocery/core/widgets/fading_container.dart';

class FadingUserInfo extends StatelessWidget {
  const FadingUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return CustomFadingAnimationManager(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadingContainer(
            width: width * 0.6,
            height: width * 0.1,
          ),
          const SizedBox(
            height: 8,
          ),
          FadingContainer(
            width: width * 0.55,
            height: width * 0.1,
          ),

          // const Divider(
          //   height: 24,
          //   thickness: 2,
          // ),
          // const SizedBox(
          //   height: 8,
          // ),
          // FadingContainer(
          //   width: width,
          //   height: height * 0.09,
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // FadingContainer(
          //   width: width,
          //   height: height * 0.09,
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // FadingContainer(
          //   width: width,
          //   height: height * 0.09,
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // FadingContainer(
          //   width: width,
          //   height: height * 0.09,
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // FadingContainer(
          //   width: width,
          //   height: height * 0.09,
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // FadingContainer(
          //   width: width,
          //   height: height * 0.09,
          // ),
        ],
      ),
    );
  }
}
