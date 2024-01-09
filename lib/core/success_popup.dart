import 'package:flutter/material.dart';
import 'package:gathrr/core/colors.dart';
import 'package:gathrr/core/primary_button.dart';

class SuccessPopup extends StatelessWidget {
  final String successMsg, successTitle;
  final String btnLabel;

  final Function() onTapbtn;
  const SuccessPopup({
    Key? key,
    required this.successMsg,
    required this.successTitle,
    required this.btnLabel,
    required this.onTapbtn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              successTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kblack,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            successMsg == "" ? const SizedBox() : const SizedBox(height: 10),
            successMsg == ""
                ? const SizedBox()
                : Text(
                    successMsg,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
            const SizedBox(height: 20),
            SizedBox(
              width: 120,
              height: 40,
              child: PrimaryButton(
                onTap: onTapbtn,
                title: btnLabel,
              ),
            )
          ],
        ),
      ),
    );
  }
}
