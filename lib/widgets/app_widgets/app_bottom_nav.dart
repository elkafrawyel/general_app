import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:general_app/config/theme/color_extension.dart';

class NavBarItem {
  String text;
  String assetName;

  NavBarItem({
    required this.text,
    required this.assetName,
  });

  @override
  String toString() {
    return text;
  }
}

class AppBottomNav extends StatefulWidget {
  final List<NavBarItem> navBarItems;
  final Function(int index) onTap;

  const AppBottomNav({
    super.key,
    required this.navBarItems,
    required this.onTap,
  });

  @override
  State<AppBottomNav> createState() => _AppBottomNavState();
}

class _AppBottomNavState extends State<AppBottomNav> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 5.0,
      backgroundColor: context.kBackgroundColor,
      currentIndex: _index,
      items: widget.navBarItems
          .map(
            (navItem) => BottomNavigationBarItem(
              icon: SvgPicture.asset(
                navItem.assetName,
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(
                  _index == widget.navBarItems.indexOf(navItem)
                      ? context.kPrimaryColor
                      : context.kHintTextColor,
                  BlendMode.srcIn,
                ),
              ),
              label: navItem.text,
            ),
          )
          .toList(),
      selectedItemColor: context.kPrimaryColor,
      selectedLabelStyle: TextStyle(
        color: context.kPrimaryColor,
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
      unselectedItemColor: context.kHintTextColor,
      unselectedLabelStyle: TextStyle(
        color: context.kHintTextColor,
        fontSize: 13,
        fontWeight: FontWeight.w200,
      ),
      onTap: (int index) {
        setState(() {
          _index = index;
        });

        widget.onTap(index);
      },
    );
  }
}
