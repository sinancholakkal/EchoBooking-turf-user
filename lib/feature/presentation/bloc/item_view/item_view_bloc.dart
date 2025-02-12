import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'item_view_event.dart';
part 'item_view_state.dart';

class ItemViewBloc extends Bloc<ItemViewEvent, ItemViewState> {
  ItemViewBloc() : super(ItemViewInitial()) {
    on<CarouselDoubt>((event, emit) {
      emit(CarouselDoubtChangedState(currentDoubt: event.currentDobt));
    });
  }
}
