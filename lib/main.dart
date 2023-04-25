import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animations ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  // late Animation<Color> animation;
  late AnimationController animationController;

  void myListneer(status) {
    if (status == AnimationStatus.completed) {
      animation.removeStatusListener(myListneer);
      animationController.reset();
      animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: animationController, curve: Curves.fastOutSlowIn));
      animationController.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn))
      ..addStatusListener(myListneer);
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 33, 36, 44),
        body: Center(
            child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => Transform(
            transform:
                Matrix4.translationValues(animation.value * width, 0.0, 0),
            child: Container(
              height: 200,
              width: 200,
              color: Colors.green,
            ),
          ),
        )));
  }
}
