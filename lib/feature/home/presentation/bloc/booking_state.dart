part of 'booking_bloc.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class AvailableDatesLoaded extends BookingState {
  final List<String> dates;

  const AvailableDatesLoaded(this.dates);

  @override
  List<Object> get props => [dates];
}

class AvailableSlotsLoaded extends BookingState {
  final List<Map<String, dynamic>> slots;

  const AvailableSlotsLoaded(this.slots);

  @override
  List<Object> get props => [slots];
}

class BookingSuccess extends BookingState {
  final Map<String, dynamic> bookingData;

  const BookingSuccess(this.bookingData);

  @override
  List<Object> get props => [bookingData];
}

class BookingFinalized extends BookingState {}

class BookingError extends BookingState {
  final String message;

  const BookingError(this.message);

  @override
  List<Object> get props => [message];
}

class RatingSubmitting extends BookingState {}

class RatingSubmitted extends BookingState {}

class RatingError extends BookingState {
  final String message;
  RatingError(this.message);
}