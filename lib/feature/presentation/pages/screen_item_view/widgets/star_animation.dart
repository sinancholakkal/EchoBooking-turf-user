import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarAnimation extends StatefulWidget {
  const StarAnimation({super.key});

  @override
  State<StarAnimation> createState() => _StarAnimationState();
}

class _StarAnimationState extends State<StarAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<Color?>? _colorAnimation;
  Animation<double?>? _sizeAnimation;
  bool isFav = false;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _colorAnimation = ColorTween(
      begin: Colors.grey,
      end: Colors.red,
    ).animate(_animationController!);

    _animationController!.addListener(() {
      log(_animationController!.value.toString());
      log(_colorAnimation!.value.toString());
    });

    _animationController!.addStatusListener((status){
      if(status==AnimationStatus.completed){
        setState(() {
          isFav = true;
        });
      }
      if(status==AnimationStatus.dismissed){
        setState(() {
          isFav = false;
        });
      }

      _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(tween: Tween(begin: 40,end: 60), weight: 50),
      TweenSequenceItem<double>(tween: Tween(begin: 60,end: 40), weight: 50),
    ]).animate(_animationController!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return IconButton(
      onPressed: () {
        
        (isFav==false)?_animationController!.forward():_animationController!.reverse();
      },
      icon: Icon(
        Icons.star,
        size: _sizeAnimation?.value ??40,
        color: _colorAnimation!.value,
      ),
    );
      },
    );
  }
}
