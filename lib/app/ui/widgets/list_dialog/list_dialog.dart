import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

import 'list_dialog_item.dart';

class ListDialog extends StatefulWidget {
  final List<ListDialogItem> items;

  const ListDialog({
    super.key,
    required this.items,
  });

  @override
  State<StatefulWidget> createState() => _ListDialogState();
}

class _ListDialogState extends State<ListDialog> {
  late final List<ListDialogItem> items;

  @override
  void initState() {
    super.initState();
    items = widget.items;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: ColorRes.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final item = items[index];
                  return Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: ColorRes.white,
                      border: Border.all(color: ColorRes.disable),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWellOver(
                      onTap: () {
                        Get.back(result: item);
                      },
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ColorRes.fontBlack,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
                itemCount: items.length,
              ),
            ),
          ],
        ),
      );
}
