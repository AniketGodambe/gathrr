import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gathrr/bloc/event_id_bloc/event_id_bloc_bloc.dart';
import 'package:gathrr/core/colors.dart';
import 'package:gathrr/core/consts.dart';
import 'package:gathrr/core/error_dialog.dart';
import 'package:gathrr/core/primary_button.dart';
import 'package:gathrr/presentation/events/widgets.dart';

class EventInfoScreen extends StatefulWidget {
  final String eventId;
  const EventInfoScreen({super.key, required this.eventId});

  @override
  State<EventInfoScreen> createState() => _EventInfoScreenState();
}

class _EventInfoScreenState extends State<EventInfoScreen> {
  final EventIdBlocBloc eventidBloc = EventIdBlocBloc();

  @override
  void initState() {
    eventidBloc.add(EventByIdInitialFetchEvent(eventId: widget.eventId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
        actions: [
          const Center(
            child: SvgContainerWidget(
              svgPath: 'assets/ic_fav.svg',
              height: 25,
              isColorRequired: false,
              isBgRequired: false,
            ),
          ),
          kwidth20,
          const Center(
            child: SvgContainerWidget(
              svgPath: 'assets/ic_send.svg',
              height: 25,
              isColorRequired: false,
              isBgRequired: false,
            ),
          ),
          kwidth20,
        ],
      ),
      bottomNavigationBar: BlocConsumer<EventIdBlocBloc, EventIdBlocState>(
          bloc: eventidBloc,
          listenWhen: (previous, current) => current is EventIdActionState,
          buildWhen: (previous, current) => current is! EventIdActionState,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case EventIdFetchSuccessState:
                final successState = state as EventIdFetchSuccessState;
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0x33E0DBDB),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    border: Border(
                      left: BorderSide(color: Color(0xFFCBCBCB)),
                      top: BorderSide(color: Color(0xFFCBCBCB)),
                      right: BorderSide(color: Color(0xFFCBCBCB)),
                      bottom: BorderSide(width: 0.40, color: Color(0xFFCBCBCB)),
                    ),
                  ),
                  height: 68,
                  child: Row(
                    children: [
                      kwidth10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              successState.eventByIdModel.generalInfo,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: kblack,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              '(No taxes needed) ',
                              style: TextStyle(
                                color: kblack,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      kwidth10,
                      Expanded(
                          child: PrimaryButton(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const ErrorPopup(
                                      errorMsg: "This feature is coming soon!",
                                      errorTitle: 'Oops',
                                      btnLabel: "Okay",
                                    );
                                  },
                                );
                              },
                              title: "Register now")),
                      kwidth10,
                    ],
                  ),
                );
              default:
                return const SizedBox();
            }
          }),
      body: BlocConsumer<EventIdBlocBloc, EventIdBlocState>(
        bloc: eventidBloc,
        listenWhen: (previous, current) => current is EventIdActionState,
        buildWhen: (previous, current) => current is! EventIdActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case EventIdFetchSuccessState:
              final successState = state as EventIdFetchSuccessState;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 272,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              successState.eventByIdModel.eventBanner),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    kheight20,
                    SizedBox(
                      height: 650,
                      child: DefaultTabController(
                        length: 4,
                        child: Column(
                          children: [
                            Container(
                              color: kwhite,
                              child: const TabBar(
                                isScrollable: false,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                labelStyle: TextStyle(
                                  color: Color(0xFF001833),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                                labelColor: Color(0xFF001833),
                                unselectedLabelColor: Color(0xFF8C8C8C),
                                indicatorColor: Color(0xFF001833),
                                indicatorSize: TabBarIndicatorSize.label,
                                tabs: [
                                  Text('Event info'),
                                  Text('Agenda'),
                                  Text('Sponsors'),
                                  Text('Speakers'),
                                ],
                              ),
                            ),
                            kheight15,
                            Expanded(
                              child: TabBarView(
                                children: [
                                  EventEnfoTab(
                                    successState: successState,
                                    eventidBloc: eventidBloc,
                                  ),
                                  const Text(
                                    "Agenda Not available",
                                    textAlign: TextAlign.center,
                                  ),
                                  const Text(
                                    "Sponsors Not available",
                                    textAlign: TextAlign.center,
                                  ),
                                  const Text(
                                    "Speakers Not available",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );

            case EventIdLoadingState:
              return const Center(child: CircularProgressIndicator());
            case EventIdErrorState:
              return const Center(child: Text("Oppss There is an issue "));
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
