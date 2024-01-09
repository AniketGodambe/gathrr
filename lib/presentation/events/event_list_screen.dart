import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gathrr/bloc/event_list_bloc/events_bloc.dart';
import 'package:gathrr/core/consts.dart';
import 'package:gathrr/presentation/events/widgets.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
        actions: [
          const Center(
            child: SvgContainerWidget(
              svgPath: 'assets/ic_search.svg',
              height: 25,
              isColorRequired: false,
              isBgRequired: false,
            ),
          ),
          kwidth20,
          const Center(
            child: SvgContainerWidget(
              svgPath: 'assets/ic_notification.svg',
              height: 25,
              isColorRequired: false,
              isBgRequired: false,
            ),
          ),
          kwidth20,
        ],
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
              return EventListWidget(successState: successState);
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

Future<void> launchUrlFN(url) async {
  try {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  } catch (e) {
    print(e);
  }
}
