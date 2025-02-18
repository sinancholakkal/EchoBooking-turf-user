import 'package:bloc/bloc.dart';
import 'package:echo_booking/domain/repository/turf_view_servises.dart';
import 'package:meta/meta.dart';

part 'item_view_event.dart';
part 'item_view_state.dart';

class ItemViewBloc extends Bloc<ItemViewEvent, ItemViewState> {
  final TurfViewServises turfViewServises = TurfViewServises();
  ItemViewBloc() : super(ItemViewInitial()) {
    on<CarouselDoubt>((event, emit) {
      emit(CarouselDoubtChangedState(currentDoubt: event.currentDobt));
    });
    on<GoogleMapLauncherEvent>((event, emit) async {
      turfViewServises.openInGoogleMap(event.position);
    });
    on<CallLauncherEvent>((event, emit) async {
      await turfViewServises.callLauncher(phone: event.phone);
    });
    on<WhatsAppLauncher>((event, emit) async {
       turfViewServises.launchWhatsApp(phone:event.phone );
    });
  }
}
