import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';

class WellnessGuideDialog extends StatefulWidget {
  const WellnessGuideDialog({super.key});

  @override
  State<StatefulWidget> createState() => _WellnessGuideDialog();
}

class _WellnessGuideDialog extends State<WellnessGuideDialog> {
  _WellnessGuideDialog();

  @override
  void initState() {
    super.initState();
  }

  void close() => Get.back();

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: close,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(30),
            ),
          ),
          Positioned(
            top: 96,
            left: 70,
            right: 30,
            child: InkWellOver(
              splashColor: Colors.transparent,
              onTap: close,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                ),
                child: Text(
                  StringRes.wellnessGuide.tr,
                  textAlign: TextAlign.right,
                  softWrap: true,
                  maxLines: 5,
                  style: const TextStyle(
                    fontSize: 10,
                    height: 1.6,
                    color: ColorRes.fontGray,
                  ),
                ),
              ),
            )
          ),
        ],
      ));
}
