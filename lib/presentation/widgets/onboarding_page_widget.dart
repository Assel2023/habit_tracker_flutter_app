import 'package:flutter/material.dart';

class OnboardingPageWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPageWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

@override
Widget build(BuildContext context) {
  return Stack(
    children: [
      Positioned.fill(
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover, 
        ),
      ),

      Positioned(
        bottom: 0, 
        left: 0,
        right: 0,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.30, 
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 40), 
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

}