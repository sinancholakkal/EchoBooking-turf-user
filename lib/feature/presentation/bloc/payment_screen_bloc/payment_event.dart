part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}
class PaymentSuccessEvent extends PaymentEvent{
  final TurfModel turfModel;
  final String paymentId;
  final String dateKey;
  final String bookedTime;
  final UserModel userModel;
  PaymentSuccessEvent({required this.turfModel,required this.userModel,required this.paymentId,required this.dateKey,required this.bookedTime});
}