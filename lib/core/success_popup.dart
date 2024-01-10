import 'package:flutter/material.dart';
import 'package:gathrr/core/colors.dart';
import 'package:gathrr/core/consts.dart';
import 'package:gathrr/core/primary_button.dart';
import 'package:get/get.dart';

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
          color: kwhite,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              successTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
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
                      color: secondaryTextColor,
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

class PermissionPopup extends StatelessWidget {
  final String errorMsg, errorTitle;
  final String btnLabel1, btnLabel2;
  final Function()? onTapbtn1;
  final Function() onTapbtn2;
  const PermissionPopup(
      {Key? key,
      required this.errorMsg,
      required this.errorTitle,
      required this.btnLabel1,
      required this.btnLabel2,
      this.onTapbtn1,
      required this.onTapbtn2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        decoration: BoxDecoration(
          color: kwhite,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              errorTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kblack,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            kheight10,
            Text(
              errorMsg,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: hintTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            kheight20,
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      isActive: false,
                      isWhiteColor: true,
                      title: btnLabel1,
                      onTap: onTapbtn1 ??
                          () {
                            Get.back();
                          },
                    ),
                  ),
                  kwidth10,
                  Expanded(
                    child: PrimaryButton(
                      onTap: onTapbtn2,
                      title: btnLabel2,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
