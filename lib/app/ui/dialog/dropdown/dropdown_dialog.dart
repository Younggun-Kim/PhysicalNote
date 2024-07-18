import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';
import 'package:physical_note/app/utils/extensions/list_extension.dart';

class DropdownDialog extends StatefulWidget {
  final List<String> items;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;

  const DropdownDialog({
    super.key,
    required this.items,
    this.top,
    this.left,
    this.right,
    this.bottom,
  });

  @override
  State<StatefulWidget> createState() => _DropdownDialog();
}

class _DropdownDialog extends State<DropdownDialog> {
  late final List<String> items;
  late final double? top;
  late final double? left;
  late final double? right;
  late final double? bottom;

  _DropdownDialog();

  @override
  void initState() {
    super.initState();
    items = widget.items;
    top = widget.top;
    left = widget.left;
    right = widget.right;
    bottom = widget.bottom;
  }

  void close() => Get.back();

  List<Widget> _convertItemsToWidget() {
    return items
        .mapWithIndex(
          (e, index) => _DropdownItem(
            item: e,
            isEdge: !(index == items.length - 1),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
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
              padding: const EdgeInsets.all(30),
            ),
          ),
          Positioned(
            top: top,
            left: left,
            right: right,
            bottom: bottom,
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
              child: Column(children: _convertItemsToWidget()),
            ),
          ),
        ],
      ));
}

class _DropdownItem extends StatelessWidget {
  final String item;

  final bool isEdge;

  const _DropdownItem({required this.item, required this.isEdge});

  @override
  Widget build(BuildContext context) => InkWellOver(
        onTap: () {
          Get.back(result: item);
        },
        child: Container(
          padding: isEdge ? const EdgeInsets.only(bottom: 20) : EdgeInsets.zero,
          alignment: Alignment.center,
          constraints: const BoxConstraints(minWidth: 90),
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: ColorRes.gray9f9f9f,
            ),
          ),
        ),
      );
}
