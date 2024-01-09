import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gathrr/repo/event_list_repo.dart';

import 'dart:developer';

import 'package:gathrr/model/event_list_model/event_list_model.dart';
part 'events.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc() : super(EventlistInitial()) {
    on<EventListInitialFetchEvent>(eventListInitialFetchEvent);
  }

  FutureOr<void> eventListInitialFetchEvent(
      EventListInitialFetchEvent event, Emitter<EventsState> emit) async {
    emit(EventListLoadingState());
    try {
      List<EventListModel> eventList = await EventListRepo.getEventList();

      emit(EventListFetchSuccessState(eventList: eventList));
    } catch (e) {
      emit(EventListErrorState());
      log(e.toString());
    }
  }
}
