import 'package:echo_booking/feature/presentation/bloc/item_view/item_view_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/screen_item_view.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/expandeble_floating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FloatingActionsWidget extends StatelessWidget {
  const FloatingActionsWidget({
    super.key,
    required this.widget,
  });

  final ScreenItemView widget;

  @override
  Widget build(BuildContext context) {
    return ExpandebleFloatingWidget(
        //call launcher
        callOntap: () => context
            .read<ItemViewBloc>()
            .add(CallLauncherEvent(phone: widget.turfmodel.phone)),
        //whatsApp launcher
        whatsappOnTap: () => context
            .read<ItemViewBloc>()
            .add(WhatsAppLauncher(phone: widget.turfmodel.phone)));
  }
}

