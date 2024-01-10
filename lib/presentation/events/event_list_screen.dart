import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gathrr/bloc/event_list_bloc/events_bloc.dart';
import 'package:gathrr/core/colors.dart';
import 'package:gathrr/core/consts.dart';
import 'package:gathrr/core/success_popup.dart';
import 'package:gathrr/presentation/events/widgets.dart';
import 'package:gathrr/presentation/onboard/splash_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
      backgroundColor: const Color(0xffF9F9F9),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: kwhite,
            floating: false,
            pinned: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(formatDate(format: 'EEEE, dd MMMM')),
                const Text(
                  'Kalyani Nagar Pune, MH IN',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            ),
            actions: actionsWidget(),
          ),
          SliverListWidget(
            child: BlocConsumer<EventsBloc, EventsState>(
              bloc: eventListBloc,
              listenWhen: (previous, current) =>
                  current is EventlistActionState,
              buildWhen: (previous, current) =>
                  current is! EventlistActionState,
              listener: (context, state) {},
              builder: (context, state) {
                switch (state.runtimeType) {
                  case EventListFetchSuccessState:
                    final successState = state as EventListFetchSuccessState;
                    return EventListWidget(successState: successState);
                  case EventListLoadingState:
                    return const Center(child: CircularProgressIndicator());
                  case EventListErrorState:
                    return const Center(
                        child: Text("Oppss There is an issue "));
                  default:
                    return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

actionsWidget() {
  return [
    const Center(
      child: SvgContainerWidget(
        svgPath: 'assets/ic_search.svg',
        height: 25,
        isColorRequired: false,
        isBgRequired: false,
      ),
    ),
    kwidth20,
    GestureDetector(
      onTap: () {
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return PermissionPopup(
              errorMsg: "you want to log out?",
              errorTitle: 'Are you sure',
              btnLabel1: 'No',
              btnLabel2: 'Yes',
              onTapbtn2: () {
                final GetStorage storage = GetStorage();
                storage.write("appState", null);
                Get.offAll(() => const SplashScreen());
              },
            );
          },
        );
      },
      child: const Icon(
        Icons.logout,
        color: kblack,
        size: 25,
      ),
    ),
    kwidth20,
  ];
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

class SliverListWidget extends StatelessWidget {
  final Widget child;
  const SliverListWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[child]),
    );
  }
}
