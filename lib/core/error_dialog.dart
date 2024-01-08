import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorPopup extends StatelessWidget {
  final String errorMsg, errorTitle, btnLabel;
  final Function()? onTap;
  const ErrorPopup(
      {Key? key,
      required this.errorMsg,
      required this.errorTitle,
      this.btnLabel = "",
      this.onTap})
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              errorTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              errorMsg,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: onTap ??
                  () {
                    Get.back();
                  },
              child: Container(
                height: 40,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: ShapeDecoration(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      btnLabel == "" ? 'Retry' : btnLabel,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
