import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portal/components/widgets/custom_circularProgressIndicator.dart';
import 'package:portal/constants/colors.dart';

class CustomImageWidget extends StatelessWidget {
  final String imageName;
  const CustomImageWidget({super.key, required this.imageName});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
                child: FutureBuilder(
                  future: precacheImage(
                      AssetImage('lib/assets/images/$imageName'), context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CustomCircularProgressIndicator(
                          color: secondaryColor);
                    }
                    return Image.asset(
                      'lib/assets/images/$imageName',
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: secondaryColor,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 350,
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: FutureBuilder(
                future: precacheImage(
                    AssetImage('lib/assets/images/$imageName'), context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CustomCircularProgressIndicator(
                        color: primaryColor);
                  }
                  return Image.asset(
                    'lib/assets/images/$imageName',
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.broken_image_outlined,
                      color: redColor,
                      size: 50,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
