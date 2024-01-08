import 'package:flutter/material.dart';
import 'package:gathrr/core/colors.dart';
import 'package:loading_indicator/loading_indicator.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onTap;
  final String title;
  final bool isLoading;
  final bool isActive;
  final bool isWhiteColor;

  const PrimaryButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.isLoading = false,
    this.isActive = true,
    this.isWhiteColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: isActive == true && isLoading == false ? onTap : () {},
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isActive == false
              ? isWhiteColor
                  ? Colors.white
                  : const Color(0xFFF3F3F3)
              : primaButtonColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: isLoading == true
              ? const SizedBox(
                  height: 40,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballPulse,
                    colors: [Colors.white],
                    strokeWidth: 2,
                  ),
                )
              : Center(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      color: isActive == false ? Colors.grey : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
