import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gathrr/bloc/event_bloc/events_bloc.dart';
import 'package:gathrr/core/consts.dart';
import 'package:intl/intl.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  final EventsBloc eventListBloc = EventsBloc();

  @override
  void initState() {
    eventListBloc.add(EventListInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(formatDate(format: 'EEEE, dd MMMM')),
      ),
      body: BlocConsumer<EventsBloc, EventsState>(
        bloc: eventListBloc,
        listenWhen: (previous, current) => current is EventlistActionState,
        buildWhen: (previous, current) => current is! EventlistActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case EventListFetchSuccessState:
              final successState = state as EventListFetchSuccessState;
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                itemCount: successState.eventList.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.60, color: Color(0xFFE3DDDD)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x33000000),
                              blurRadius: 1,
                              offset: Offset(0, 1),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 84,
                              height: 84,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(successState
                                      .eventList[index].eventBanner),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                            ),
                            kwidth20,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/ic_calendar.svg",
                                        height: 15,
                                      ),
                                      kwidth5,
                                      Text(
                                        '${formatDate(format: 'dd', date: DateTime.parse(successState.eventList[index].startDate))} - ${formatDate(format: 'dd MMM', date: DateTime.parse(successState.eventList[index].endDate))}',
                                        style: const TextStyle(
                                          color: Color(0xFF0D094D),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Spacer(),
                                      SvgPicture.asset(
                                        "assets/ic_time.svg",
                                        height: 15,
                                      ),
                                      kwidth5,
                                      Text(
                                        '${formatDate(format: 'hh:mm', date: DateTime.parse(successState.eventList[index].startDate))} - ${formatDate(format: 'hh:mm a', date: DateTime.parse(successState.eventList[index].endDate))}',
                                        style: const TextStyle(
                                          color: Color(0xFF0D094D),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                  kheight5,
                                  Text(
                                    successState.eventList[index].eventName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  kheight5,
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/ic_map_pin.svg",
                                        height: 15,
                                      ),
                                      kwidth5,
                                      Expanded(
                                        child: Text(
                                          "${successState.eventList[index].venue}, ${successState.eventList[index].location}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Color(0xFF0E0A4E),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  kheight10,
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/ic_team_line.svg",
                                        height: 15,
                                      ),
                                      kwidth5,
                                      Expanded(
                                        child: Text(
                                          'Booking limit - ${successState.eventList[index].bookingMaxLimit}',
                                          style: const TextStyle(
                                            color: Color(0xFF0D094D),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: successState.eventList[index].generalInfo ==
                                    "Free"
                                ? const Color(0xffF9E048)
                                : const Color(0xffFFA500),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                bottomRight: Radius.circular(4)),
                          ),
                          child: Text(
                            successState.eventList[index].generalInfo,
                            style: const TextStyle(
                              color: Color(0xFF0E0A4E),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              );

            case EventListLoadingState:
              return const Center(child: CircularProgressIndicator());
            case EventListErrorState:
              return const Center(child: Text("Oppss There is an issue "));
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

String formatDate({
  DateTime? date,
  required String format,
}) {
  DateTime now = date ?? DateTime.now();
  return DateFormat(format).format(now);
}

String formatDateWith5h30m({
  DateTime? date,
  required String format,
}) {
  DateTime now = date == null
      ? DateTime.now()
      : date.add(const Duration(hours: 5, minutes: 30));
  return DateFormat(format).format(now);
}
