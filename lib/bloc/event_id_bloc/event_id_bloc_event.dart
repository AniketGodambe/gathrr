part of 'event_id_bloc_bloc.dart';

sealed class EventIdBlocEvent extends Equatable {
  const EventIdBlocEvent();

  @override
  List<Object> get props => [];
}

class EventByIdInitialFetchEvent extends EventIdBlocEvent {
  final String eventId;

  const EventByIdInitialFetchEvent({required this.eventId});
}

class LaunchUrlEvent extends EventIdBlocEvent {
  final String url;

  const LaunchUrlEvent({required this.url});
}
