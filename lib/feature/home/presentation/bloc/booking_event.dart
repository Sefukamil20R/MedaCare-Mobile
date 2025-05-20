part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class FetchAvailableDatesEvent extends BookingEvent {
  final int physicianId;

  const FetchAvailableDatesEvent(this.physicianId, );

  @override
  List<Object> get props => [physicianId];
}

class FetchAvailableSlotsEvent extends BookingEvent {
  final int physicianId;
  final String date;
  final int duration;

  const FetchAvailableSlotsEvent(this.physicianId, this.date, this.duration);

  @override
  List<Object> get props => [physicianId, date, duration];
}

class BookSlotEvent extends BookingEvent {
  final int slotId;

  const BookSlotEvent(this.slotId);

  @override
  List<Object> get props => [slotId];
}

class FinalizeBookingEvent extends BookingEvent {
  final int slotId;

  const FinalizeBookingEvent(this.slotId);

  @override
  List<Object> get props => [slotId];
}
class PaymentUrlLoaded extends BookingState {
  final String paymentUrl;

  PaymentUrlLoaded(this.paymentUrl);

  @override
  List<Object> get props => [paymentUrl];
}
class SubmitRatingEvent extends BookingEvent {
  final int physicianId;
  final int rating;

  SubmitRatingEvent({required this.physicianId, required this.rating});
}
