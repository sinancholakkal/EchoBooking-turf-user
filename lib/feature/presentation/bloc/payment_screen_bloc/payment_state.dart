part of 'payment_bloc.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}
class PaymentSuccessLoadingState extends PaymentState{}
class PaymentSuccessState extends PaymentState{}