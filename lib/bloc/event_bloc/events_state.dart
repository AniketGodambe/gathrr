part of 'events_bloc.dart';

sealed class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => [];
}

final class EventlistInitial extends EventsState {}

final class EventlistActionState extends EventsState {}

class EventListFetchSuccessState extends EventsState {
  final List<EventListModel> eventList;

  const EventListFetchSuccessState({required this.eventList});
}

class EventListLoadingState extends EventsState {}

class EventListErrorState extends EventsState {}
