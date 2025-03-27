import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/constants/colors/colors.dart';

class MainHeader extends StatefulWidget {
  final String currentCity;
  const MainHeader({super.key, required this.currentCity});

  @override
  State<MainHeader> createState() => _MainHeaderState();
}

bool expanded = false;

class _MainHeaderState extends State<MainHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, right: 8, left: 8, bottom: 2),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: background2,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  widget.currentCity,
                  style: const TextStyle(color: textColor1),
                ),
                const Spacer(),
                expanded
                    ? Expanded(
                        // Ensure it takes up space
                        child: SlideTransition(
                          position: _offsetAnimation,
                          child: searchBar(),
                        ),
                      )
                    : const SizedBox.shrink(),
                expanded == false
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            expanded = !expanded;
                            if (expanded) {
                              _controller.forward();
                            } else {
                              _controller.reverse();
                            }
                          });
                        },
                        icon: const Icon(CupertinoIcons.search,
                            color: textColor1),
                      )
                    : const SizedBox.shrink(),
                const Gap(16),
                notificationsBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget notificationsBtn() {
    return Stack(children: [
      IconButton(
          onPressed: () => context.go('/notifications'),
          icon: const Icon(CupertinoIcons.bell, color: textColor1)),
      Positioned(
        top: 6,
        right: 10,
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ]);
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    expanded = !expanded;
                    _controller.reverse();
                  });
                },
                icon: const Icon(CupertinoIcons.search, color: textColor1),
              ),
              hintText: 'Search here',
              hintStyle: const TextStyle(color: textColor1),
            ),
            style: const TextStyle(color: textColor1),
          ),
        ),
      ),
    );
  }
}
