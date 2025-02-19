import 'dart:developer';
import 'dart:ffi';

import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/domain/repository/turf_service.dart';
import 'package:echo_booking/feature/presentation/bloc/star_bloc/star_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StarAnimation extends StatefulWidget {
  final Map<String, List<Map<String, dynamic>>> timeSlots;
  final bool isFav;
  final TurfModel turfModel;
   StarAnimation({super.key,required this.timeSlots,required this.turfModel,required this.isFav});

  @override
  State<StarAnimation> createState() => _StarAnimationState();
}

class _StarAnimationState extends State<StarAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<Color?>? _colorAnimation;
  Animation<double?>? _sizeAnimation;
  late bool isFav;
  @override
@override
void initState() {
  super.initState();

  isFav = widget.isFav; // Use the widget's initial favorite state

  _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 500),
  );

  _colorAnimation = ColorTween(
    begin: Colors.grey,
    end: Colors.red,
  ).animate(_animationController!);

  _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
    TweenSequenceItem<double>(tween: Tween(begin: 40, end: 60), weight: 50),
    TweenSequenceItem<double>(tween: Tween(begin: 60, end: 40), weight: 50),
  ]).animate(_animationController!);

  if (isFav) {
    _animationController!.forward(); // Start animation if already a favorite
  }

  _animationController!.addStatusListener((status) {
    setState(() {
      isFav = status == AnimationStatus.completed;
    });
  });
}


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return IconButton(
      onPressed: () {
        if(isFav==false){
          log("Add turf===============");
          // TurfService().starAddTurf(widget.turfModel,widget.timeSlots);
          context.read<StarBloc>().add(AddTurfStarEvent(timeSlots: widget.timeSlots, turfModel: widget.turfModel));
        }else{
          //TurfService().deleteTurfFromStar(widget.turfModel.turfId);
          context.read<StarBloc>().add(RemoveTurfStarEvent(turfId: widget.turfModel.turfId));
          
          log("remof turf=======================");
        }
        
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
