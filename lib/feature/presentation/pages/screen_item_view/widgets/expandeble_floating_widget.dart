import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class ExpandebleFloatingWidget extends StatelessWidget {
  void Function() callOntap;
  void Function() whatsappOnTap;
   ExpandebleFloatingWidget({
    
    super.key,
    required this.callOntap,
    required this.whatsappOnTap
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
    
      type: ExpandableFabType.up,
      childrenAnimation: ExpandableFabAnimation.none,
      distance: 70,
      overlayStyle: ExpandableFabOverlayStyle(
        color: Colors.transparent,
      ),
      children:  [
        FloatingActionButton.small(
          heroTag: null,
          onPressed: callOntap,
          child: Icon(Icons.call),
        ),
        FloatingActionButton.small(
          heroTag: null,
          onPressed: whatsappOnTap,
          child: Image.asset("asset/whatsapp.png"),
        ),
        
        
      ],
    );
  }
}
