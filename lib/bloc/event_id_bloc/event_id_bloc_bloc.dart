import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gathrr/repo/event_by_id_repo.dart';
import 'package:gathrr/model/event_by_id_model.dart';

part 'event_id_bloc_event.dart';
part 'event_id_bloc_state.dart';

class EventIdBlocBloc extends Bloc<EventIdBlocEvent, EventIdBlocState> {
  EventIdBlocBloc() : super(EventIdBlocInitial()) {
    on<EventByIdInitialFetchEvent>(eventListInitialFetchEvent);
    on<LaunchUrlEvent>(launchUrlEvent);
  }

  FutureOr<void> eventListInitialFetchEvent(
      EventByIdInitialFetchEvent event, Emitter<EventIdBlocState> emit) async {
    emit(EventIdLoadingState());
    try {
      final EventByIdModel eventByIdModel;

      eventByIdModel = await EventIdRepo.getEventById(eventId: event.eventId);

      emit(EventIdFetchSuccessState(eventByIdModel: eventByIdModel));
    } catch (e) {
      emit(EventIdErrorState());
      log(e.toString());
    }
  }

  FutureOr<void> launchUrlEvent(
      LaunchUrlEvent event, Emitter<EventIdBlocState> emit) {
    EventIdRepo.launchUrlFN(event.url);
  }
}
