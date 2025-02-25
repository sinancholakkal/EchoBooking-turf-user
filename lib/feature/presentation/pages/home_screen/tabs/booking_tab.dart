import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/domain/model/booking_turf_model.dart';
import 'package:echo_booking/feature/presentation/bloc/booking_bloc/booking_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/card_turf_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/circular_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingTab extends StatefulWidget {
  const BookingTab({super.key});

  @override
  State<BookingTab> createState() => _BookingTabState();
}

class _BookingTabState extends State<BookingTab> {
  @override
  void initState() {
    context.read<BookingBloc>().add(FetchBookingTurfEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        if (state is FetchLoadingState) {
          return CircularWidget();
        } else if (state is FetchLoadedState) {
          final List<BookingTurfmodel> turfs = state.bookingTurfModels;
          return ListView.builder(
            itemCount: turfs.length,
            itemBuilder: (context, index) {
              //log(state.starTurfs.length.toString());
              return CardTurfsWidget(
                  screenWidth: screenWidth,
                  turfModel: turfs[index],
                  index: index,
                  heroTag: 'booking_$index',
                  type: ActionTypeFrom.booking);
            },
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
