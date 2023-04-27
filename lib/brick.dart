import 'package:flutter/material.dart';

import 'dart:math' as math;

class Brick extends StatefulWidget {
  const Brick({super.key});

  @override
  State<Brick> createState() => _BrickState();
}

class _BrickState extends State<Brick> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Tween tween;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    tween = Tween(begin: 0.0, end: 1.0);
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  //set1 animations

  //Brick1
  Animation get animOne => tween.animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.0, 0.125, curve: Curves.linear)));

  Animation get animTwo => tween.animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.125, 0.25, curve: Curves.linear)));

  //Brick2

  Animation get animThree => tween.animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.25, 0.375, curve: Curves.linear)));

  //Brick 3
  Animation get animFour => tween.animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.375, 0.5, curve: Curves.linear)));

  //Brick 4
  Animation get animfive => tween.animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.5, 0.625, curve: Curves.linear)));

  //Brick 4
  Animation get animSix => tween.animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.625, 0.750, curve: Curves.linear)));

  //Brick 3
  Animation get animseven => tween.animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.750, 0.875, curve: Curves.linear)));

  //Brick 2
  Animation get animeight => tween.animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.875, 1.0, curve: Curves.linear)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 33, 58, 75),
      appBar: AppBar(
          title: const Text("Flutter animations"),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: const Color.fromARGB(255, 30, 47, 58)),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBrick(
              animations: [animOne, animTwo],
              animationController: animationController,
              magrinLeft: 0.0,
              alignment: Alignment.centerLeft,
              isClockWise: true,
            ),
            AnimatedBrick(
              animations: [animThree, animeight],
              animationController: animationController,
              magrinLeft: 8.0,
              //  alignment: Alignment.centerLeft,
              isClockWise: false,
            ),
            AnimatedBrick(
              animations: [animFour, animseven],
              animationController: animationController,
              magrinLeft: 35.0,
              isClockWise: true,
            ),
            AnimatedBrick(
              animations: [animfive, animSix],
              animationController: animationController,
              magrinLeft: 35.0,
              isClockWise: false,
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedBrick extends AnimatedWidget {
  final AnimationController animationController;
  final List<Animation> animations;
  final double magrinLeft;
  final Alignment alignment;
  final bool isClockWise;
  const AnimatedBrick(
      {Key? key,
      required this.animationController,
      required this.animations,
      required this.magrinLeft,
      required this.isClockWise,
      this.alignment = Alignment.centerRight})
      : super(key: key, listenable: animationController);

  Matrix4 clockWise(animation) =>
      Matrix4.rotationZ(animation.value * math.pi * 2.0 * 0.5);

  Matrix4 anticlockWise(animation) =>
      Matrix4.rotationZ(-(animation.value * math.pi * 2.0 * 0.5));

  @override
  Widget build(BuildContext context) {
    var firstTransformation, secondTransformation;

    if (isClockWise) {
      firstTransformation = clockWise(animations[0]);
      secondTransformation = clockWise(animations[1]);
    } else {
      firstTransformation = anticlockWise(animations[0]);
      secondTransformation = anticlockWise(animations[1]);
    }

    return Transform(
        transform: firstTransformation,
        alignment: alignment,
        child: Transform(
          transform: secondTransformation,
          alignment: alignment,
          child: BrickItem(
            marginLeft: magrinLeft,
          ),
        ));
  }
}

class BrickItem extends StatelessWidget {
  const BrickItem({super.key, required this.marginLeft});

  final double marginLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: marginLeft),
      height: 11,
      width: 50,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Colors.red, Colors.black, Colors.blue]),
          color: Colors.green,
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
