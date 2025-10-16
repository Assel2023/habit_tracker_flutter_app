import 'package:flutter/material.dart';
import 'package:habit_tracker/l10n/app_localizations.dart';
import 'package:habit_tracker/presentation/screens/home_screen.dart';
import 'package:habit_tracker/presentation/widgets/onboarding_page_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  bool _isLastPage = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onOnboardingComplete() {
    final settingsBox = Hive.box('settings');
    settingsBox.put('hasSeenOnboarding', true);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _isLastPage = (index == 2); 
              });
            },
            children: [
              OnboardingPageWidget(
                imagePath: 'assets/images/onboarding1.png',
                title: l10n.onboarding1Title,
                description: l10n.onboarding1Description,
              ),
              OnboardingPageWidget(
                imagePath: 'assets/images/onboarding2.png',
                title: l10n.onboarding2Title,
                description: l10n.onboarding2Description,
              ),
              OnboardingPageWidget(
                imagePath: 'assets/images/onboarding3.png',
                title: l10n.onboarding3Title,
                description: l10n.onboarding3Description,
              ),
            ],
          ),

          Container(
            alignment: const Alignment(0, 0.95),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: _onOnboardingComplete,
                  child: Text(l10n.skip), 
                ),

                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 12,
                    dotWidth: 12,
                    activeDotColor: Theme.of(context).colorScheme.primary,
                  ),
                ),

                TextButton(
                  onPressed: () {/* ... */},
                  child: Text(
                    _isLastPage ? l10n.done : l10n.next,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
