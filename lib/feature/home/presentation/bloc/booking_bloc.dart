import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/SubmitRatingUseCase.dart';
import '../../domain/usecases/get_available_dates_usecase.dart';
import '../../domain/usecases/get_available_slots_usecase.dart';
import '../../domain/usecases/book_slot_usecase.dart';
import '../../domain/usecases/finalize_booking_usecase.dart';

part 'booking_event.dart';
part 'booking_state.dart';
class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final GetAvailableDatesUseCase getAvailableDatesUseCase;
  final GetAvailableSlotsUseCase getAvailableSlotsUseCase;
  final BookSlotUseCase bookSlotUseCase;
  final FinalizeBookingUseCase finalizeBookingUseCase;
  final SubmitRatingUseCase submitRatingUseCase;

  BookingBloc({
    required this.getAvailableDatesUseCase,
    required this.getAvailableSlotsUseCase,
    required this.bookSlotUseCase,
    required this.finalizeBookingUseCase,
    required this.submitRatingUseCase,
  }) : super(BookingInitial()) {
    on<FetchAvailableDatesEvent>((event, emit) async {
      emit(BookingLoading());
      final result = await getAvailableDatesUseCase(event.physicianId);
      result.fold(
        (failure) => emit(BookingError(failure.message)),
        (dates) => emit(AvailableDatesLoaded(dates)),
      );
    });

    on<FetchAvailableSlotsEvent>((event, emit) async {
      emit(BookingLoading());
      final result = await getAvailableSlotsUseCase(
        event.physicianId,
        event.date,
        event.duration,
      );
      result.fold(
        (failure) => emit(BookingError(failure.message)),
        (slots) => emit(AvailableSlotsLoaded(slots)),
      );
    });

    // Single handler for BookSlotEvent
    on<BookSlotEvent>((event, emit) async {
      emit(BookingLoading());
      final result = await bookSlotUseCase(event.slotId);
      result.fold(
        (failure) => emit(BookingError(failure.message)),
        (bookingData) {
          final paymentUrl = bookingData['url']; // Extract the payment URL
          emit(PaymentUrlLoaded(paymentUrl));
        },
      );
    });

    on<FinalizeBookingEvent>((event, emit) async {
      emit(BookingLoading());
      final result = await finalizeBookingUseCase(event.slotId);
      result.fold(
        (failure) => emit(BookingError(failure.message)),
        (_) => emit(BookingFinalized()),
      );
    });
    on<SubmitRatingEvent>((event, emit) async {
  emit(RatingSubmitting());
  try {
    await submitRatingUseCase(
      physicianId: event.physicianId,
      rating: event.rating,
    );
    emit(RatingSubmitted());
  } catch (e) {
    emit(RatingError(e.toString()));
  }
});
  }
}