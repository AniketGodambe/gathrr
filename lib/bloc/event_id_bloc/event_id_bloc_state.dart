part of 'event_id_bloc_bloc.dart';

sealed class EventIdBlocState extends Equatable {
  const EventIdBlocState();

  @override
  List<Object> get props => [];
}

final class EventIdBlocInitial extends EventIdBlocState {}

final class EventIdActionState extends EventIdBlocState {}

class EventIdFetchSuccessState extends EventIdBlocState {
  final EventByIdModel eventByIdModel;

  const EventIdFetchSuccessState({required this.eventByIdModel});
}

class EventIdLoadingState extends EventIdBlocState {}

class EventIdErrorState extends EventIdBlocState {}
