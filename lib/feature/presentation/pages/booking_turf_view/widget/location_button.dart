import 'package:echo_booking/feature/presentation/bloc/item_view/item_view_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/booking_turf_view/screen_booking_turf_view.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationButtonWidget extends StatelessWidget {
  const LocationButtonWidget({
    super.key,
    required this.widget,
  });

  final ScreenBookingTurfView widget;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        context.read<ItemViewBloc>().add(GoogleMapLauncherEvent(
            position:
                "${widget.turfmodel.latitude},${widget.turfmodel.longitude}"));
      },
      icon: Icon(
        Icons.location_on,
        color: Colors.red,
      ),
      label: TextWidget(text: "View Location"),
    );
  }
}

