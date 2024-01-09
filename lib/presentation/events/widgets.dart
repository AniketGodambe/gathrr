import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gathrr/bloc/event_list_bloc/events_bloc.dart';
import 'package:gathrr/core/animation_widget.dart';
import 'package:gathrr/core/consts.dart';
import 'package:gathrr/core/custom_textstyle.dart';
import 'package:gathrr/core/error_dialog.dart';
import 'package:gathrr/presentation/events/event_info_screen.dart';
import 'package:gathrr/presentation/events/event_list_screen.dart';
import 'package:get/get.dart';
import 'package:gathrr/bloc/event_id_bloc/event_id_bloc_bloc.dart';
import 'package:gathrr/core/colors.dart';

class CategoryContainerWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  const CategoryContainerWidget(
      {super.key, required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: isSelected ? const Color(0xFF004999) : kwhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : kblack,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class EventListWidget extends StatelessWidget {
  final EventListFetchSuccessState successState;
  EventListWidget({super.key, required this.successState});

  var categoryList = [
    {"title": "All Events", "isSelected": true},
    {"title": "Startups", "isSelected": false},
    {"title": "Technology", "isSelected": false},
    {"title": "Travel", "isSelected": false},
    {"title": "Food & Drink", "isSelected": false},
    {"title": "Health & Wellness", "isSelected": false},
    {"title": "Entertainment", "isSelected": false},
    {"title": "Sports", "isSelected": false},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 2,
              thickness: 2,
            ),
          ),
          kheight20,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Browse by categories',
              style: TextStyle(
                color: Color(0xFF001833),
                fontSize: 16,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          kheight20,
          SizedBox(
              height: 32,
              child: ListView.builder(
                itemCount: categoryList.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (categoryList[index]['isSelected'] == false) {
                        showDialog(
                          context: Get.context!,
                          builder: (BuildContext context) {
                            return const ErrorPopup(
                              errorMsg: "Stay tuned for updates!",
                              errorTitle: 'Coming Soon',
                              btnLabel: "Okay",
                            );
                          },
                        );
                      }
                    },
                    child: CategoryContainerWidget(
                      title: categoryList[index]['title'].toString(),
                      isSelected: categoryList[index]['isSelected'] as bool,
                    ),
                  );
                },
              )),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            itemCount: successState.eventList.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  ListAnimationWidget(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => EventInfoScreen(
                              eventId: successState.eventList[index].id,
                            ));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: ShapeDecoration(
                          color: kwhite,
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
                            // Container(
                            //   width: 84,
                            //   height: 84,
                            //   decoration: ShapeDecoration(
                            //     image: DecorationImage(
                            //       image: NetworkImage(successState
                            //           .eventList[index].eventBanner),
                            //       fit: BoxFit.fill,
                            //     ),
                            //     shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(4)),
                            //   ),
                            // ),
                            // Container(
                            //   width: 84,
                            //   height: 84,
                            //   decoration: BoxDecoration(
                            //     shape: BoxShape.rectangle,
                            //     borderRadius: BorderRadius.circular(4),
                            //   ),
                            //   child: CachedNetworkImage(
                            //     imageUrl:
                            //         successState.eventList[index].eventBanner,
                            //     fit: BoxFit.fill,
                            //     placeholder: (context, url) => Container(),
                            //     errorWidget: (context, url, error) =>
                            //         Container(),
                            //   ),
                            // ),
                            CachedNetworkImage(
                                useOldImageOnUrlChange: true,
                                maxHeightDiskCache: 3000,
                                maxWidthDiskCache: 3000,
                                imageUrl:
                                    successState.eventList[index].eventBanner,
                                imageBuilder: (context, imageProvider) {
                                  return Image(
                                    image: imageProvider,
                                    fit: BoxFit.fill,
                                    height: 84,
                                    width: 84,
                                  );
                                },
                                progressIndicatorBuilder:
                                    (context, url, progress) {
                                  return const SizedBox();
                                },
                                errorWidget: (context, url, error) => Container(
                                    padding: const EdgeInsets.all(8),
                                    height: 84,
                                    width: 84,
                                    decoration: BoxDecoration(
                                      color: kwhite,
                                      border: Border.all(
                                        color: borderColor,
                                      ),
                                    ),
                                    child: Image.asset(
                                      'Assets/images/influencer_profile_placeholder.png',
                                      fit: BoxFit.cover,
                                      height: 84,
                                      width: 84,
                                    ))),

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
                                      color: kblack,
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
                        color:
                            successState.eventList[index].generalInfo == "Free"
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
          ),
        ],
      ),
    );
  }
}

class SvgContainerWidget extends StatelessWidget {
  final String svgPath;
  final double height;
  final bool isColorRequired;
  final bool isBgRequired;
  const SvgContainerWidget(
      {super.key,
      required this.svgPath,
      required this.height,
      this.isColorRequired = true,
      this.isBgRequired = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(!isBgRequired ? 0 : 8),
      decoration: !isBgRequired
          ? null
          : const ShapeDecoration(
              color: Color(0xFFEDEDED),
              shape: OvalBorder(),
            ),
      child: SvgPicture.asset(
        svgPath,
        height: height,
        colorFilter: !isColorRequired
            ? null
            : const ColorFilter.mode(
                Color(0xff0062CC),
                BlendMode.srcIn,
              ),
      ),
    );
  }
}

class EventEnfoTab extends StatelessWidget {
  final EventIdBlocBloc eventidBloc;
  final EventIdFetchSuccessState successState;
  const EventEnfoTab(
      {super.key, required this.successState, required this.eventidBloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          successState.eventByIdModel.eventName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF001833),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const SvgContainerWidget(
              svgPath: "assets/ic_map_pin.svg", height: 15),
          title: Text(
            successState.eventByIdModel.venue,
            style: const TextStyle(
              color: Color(0xFF001833),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            successState.eventByIdModel.location,
            style: eventInfoDetailsStyle,
          ),
          trailing: GestureDetector(
            onTap: () {
              eventidBloc.add(LaunchUrlEvent(
                  url: successState.eventByIdModel.locationMapLink));
            },
            child: const Text(
              'View on map',
              style: TextStyle(
                color: Color(0xFF0062CC),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const SvgContainerWidget(
              svgPath: "assets/ic_calendar.svg", height: 15),
          title: const Text(
            'RadarSoft office',
            style: TextStyle(
              color: Color(0xFF001833),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            '${formatDate(format: 'hh:mm', date: DateTime.parse(successState.eventByIdModel.startDate))} - ${formatDate(format: 'hh:mm a', date: DateTime.parse(successState.eventByIdModel.endDate))}',
            style: eventInfoDetailsStyle,
          ),
        ),
        kheight20,
        getTitle('About'),
        kheight10,
        Text(
          successState.eventByIdModel.description,
          style: const TextStyle(
            color: Color(0xFF2B2A2A),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        kheight20,
        getTitle('Hosted by'),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            width: 48,
            height: 48,
            decoration: const ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage("https://via.placeholder.com/48x48"),
                fit: BoxFit.fill,
              ),
              shape: OvalBorder(),
            ),
          ),
          title: Text(
            successState.eventByIdModel.organiserName,
            style: const TextStyle(
              color: kblack,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: const Text(
            'NA',
            style: TextStyle(
              color: kblack,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        kheight20,
        getTitle('Need Help?'),
        kheight10,
        Row(
          children: [
            const SvgContainerWidget(
                svgPath: "assets/ic_calendar.svg", height: 15),
            kwidth10,
            const Text(
              'Call us',
              style: TextStyle(
                color: kblack,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            kwidth30,
            const SvgContainerWidget(
                svgPath: "assets/ic_calendar.svg", height: 15),
            kwidth10,
            const Text(
              'Chat with us',
              style: TextStyle(
                color: kblack,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        kheight40,
      ],
    );
  }

  Text getTitle(title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF001833),
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
