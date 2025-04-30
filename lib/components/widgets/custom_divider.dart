import 'package:flutter/material.dart';
import 'package:portal/constants/colors.dart';

class CustomDivider extends StatelessWidget {
  final Color? color;
  final bool? isBroken;
  const CustomDivider({super.key, this.color, this.isBroken});

  @override
  Widget build(BuildContext context) {
    return isBroken == true
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                children: List.generate(
                  (constraints.maxWidth / 10).floor(),
                  (index) => Expanded(
                    child: Container(
                      height: 1,
                      color: index.isEven
                          ? (color ?? textColor1)
                          : Colors.transparent,
                    ),
                  ),
                ),
              );
            },
          )
        : Divider(
            thickness: 0.2,
            color: color ?? textColor1,
          );
  }
}
