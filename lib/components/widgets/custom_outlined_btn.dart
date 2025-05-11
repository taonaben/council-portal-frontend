import 'package:flutter/material.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';

class CustomOutlinedButton extends StatefulWidget {
  final String btnLabel;
  final bool? expand;
  final Function()? onTap;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomOutlinedButton(
      {super.key,
      required this.btnLabel,
      required this.onTap,
      this.backgroundColor,
      this.expand,
      this.borderColor,
      this.textColor});

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _controller.forward();
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        _controller.reverse();
        setState(() {
          _isPressed = false;
        });
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      onTapCancel: () {
        _controller.reverse();
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: (widget.expand ?? false) ? double.infinity : null,
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: widget.expand == true ? 0 : 16,
              ),
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? background1,
                borderRadius: BorderRadius.circular(uniBorderRadius),
                border: Border.all(
                  color: widget.borderColor ?? primaryColor,
                  width: 2,
                ),
                boxShadow: _isPressed
                    ? []
                    : [
                        BoxShadow(
                          color: blackColor.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              alignment: Alignment.center,
              child: Text(
                widget.btnLabel,
                style: TextStyle(
                  color: widget.textColor ?? textColor2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
