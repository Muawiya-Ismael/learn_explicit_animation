import 'package:flutter/material.dart';
import 'package:learn_explicit_animations/pages/animated_widget.dart';
import 'package:learn_explicit_animations/pages/basic_animation.dart';
import 'package:learn_explicit_animations/pages/complex.dart';
import 'package:learn_explicit_animations/pages/curved_animation.dart';
import 'package:learn_explicit_animations/pages/custom_animation.dart';
import 'package:learn_explicit_animations/pages/morphing_shape.dart';
import 'package:learn_explicit_animations/pages/staggered_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Explicit Animations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark
      ),
      home: const AnimationSelectionPage(),
    );
  }
}

class AnimationSelectionPage extends StatelessWidget {
  const AnimationSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explicit Animations')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('1. Basic Animation'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BasicAnimationPage()),
            ),
          ),
          ListTile(
            title: const Text('2. Curved Animation'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CurvedAnimationPage()),
            ),
          ),
          ListTile(
            title: const Text('3. Staggered Animation'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StaggeredAnimationPage()),
            ),
          ),
          ListTile(
            title: const Text('4. Custom Animation with AnimatedBuilder'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CustomAnimationPage()),
            ),
          ),
          ListTile(
            title: const Text('5. Custom Animation with AnimatedWidget'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AnimatedWidgetPage()),
            ),
          ),
          ListTile(
            title: const Text('6. Morphing Shape Page'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MorphingShapePage()),
            ),
          ),
          ListTile(
            title: const Text('7. Complex'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ComplexAnimationPage()),
            ),
          ),
        ],
      ),
    );
  }
}
