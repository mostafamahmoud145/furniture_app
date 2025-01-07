import 'package:flutter/material.dart';
import 'package:furniture_app/main.dart';

class AppBarChoicesForDesktop extends StatefulWidget {
  const AppBarChoicesForDesktop({super.key});

  @override
  State<AppBarChoicesForDesktop> createState() =>
      _AppBarChoicesForDesktopState();
}

class _AppBarChoicesForDesktopState extends State<AppBarChoicesForDesktop> {
  /// <--- AppBar List --->
  List<String> appBarList = ['Home', 'Services', 'Article', 'AboutUs'];

  /// <--- Selected Index --->
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: appBarList.asMap().entries.map((item) {
        /// <--- Index --->
        int index = item.key;

        /// <--- Item --->
        return Row(
          children: [
            _AppBarChoiceItem(
              title: item.value,
              index: index,
              selectedIndex: selectedIndex,
              onPressed: () {
                /// <--- Change Selected Index --->
                setState(() {
                  selectedIndex = index;
                });
              },
            ),

            /// <--- Horizontal spacing --->
            SizedBox(
              width: index != appBarList.length - 1
                  ? (MediaQuery.sizeOf(context).width * 0.02).clamp(20.0, 40.0)
                  : 0,
            ),
          ],
        );
      }).toList(),
    );
  }
}

class _AppBarChoiceItem extends StatelessWidget {
  const _AppBarChoiceItem({
    required this.title,
    required this.index,
    required this.selectedIndex,
    required this.onPressed,
  });

  final String title;
  final int index;
  final int selectedIndex;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: index == selectedIndex ? const Color(0xffb518581) : null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Text(
          title,
          style: TextStyle(
              fontSize: getResponsiveFontSize(context, fontSize: 15),
              color: index == selectedIndex ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
