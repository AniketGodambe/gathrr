import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gathrr/core/colors.dart';
import 'package:gathrr/core/success_popup.dart';
import 'package:gathrr/view/events/event_list_screen.dart';
import 'package:gathrr/view/profile_page.dart';

final rootPageScrollController = ScrollController(initialScrollOffset: 0.0);

class RootPage extends StatefulWidget {
  final int selectedIndex;

  const RootPage({super.key, this.selectedIndex = 0});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  @override
  void initState() {
    setState(() {
      _selectedIndex = widget.selectedIndex;
    });
    super.initState();
  }

  void _onItemTapped(int index) {
    if (rootPageScrollController.hasClients) {
      rootPageScrollController.animateTo(1,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
    setState(
      () {
        _selectedIndex = index;
        HapticFeedback.lightImpact();
      },
    );
  }

  final pageOptions = [
    const EventListPage(),
    const ProfilePage(),
  ];

  Future<bool> _onWillPop() async {
    return (await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PermissionPopup(
          errorMsg: 'you want to exit from app?',
          errorTitle: 'Are you sure',
          btnLabel1: 'No',
          btnLabel2: 'Yes',
          onTapbtn2: () {
            Navigator.of(context).pop(true);
          },
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: pageOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: kwhite,
          selectedLabelStyle: const TextStyle(
            // color: Color(0xFF2F4CDA),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            color: Color(0xFF797D8B),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          unselectedFontSize: 10,
          // selectedItemColor: const Color(0xFF2F4CDA),
          unselectedItemColor: const Color(0xFF797D8B),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.home),
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.person),
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
