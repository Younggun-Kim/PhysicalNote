import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/dialog/history_filter/history_filter_dialog_args.dart';
import 'package:physical_note/app/ui/dialog/template/dialog_template.dart';
import 'package:physical_note/app/ui/page/history/type/history_date_filter_type.dart';
import 'package:physical_note/app/ui/page/history/type/history_order_filter_type.dart';
import 'package:physical_note/app/ui/widgets/buttons/base_button.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';

class HistoryFilterDialog extends StatelessWidget {
  final HistoryFilterDialogArgs args;

  const HistoryFilterDialog({
    super.key,
    required this.args,
  });

  void _close() {
    Get.back();
  }

  void _selectFilterAndClose(
      {HistoryDateFilterType? dateType,
      HistoryOrderFilterType? orderType,
      bool? isRecovery}) {
    Get.back(
        result: HistoryFilterDialogArgs(
      dateType: dateType ?? args.dateType,
      orderType: orderType ?? args.orderType,
      isRecovery: isRecovery ?? args.isRecovery,
    ));
  }

  @override
  Widget build(BuildContext context) => DialogTemplate(
        padding: const EdgeInsets.all(30),
        backgroundColor: ColorRes.dimmed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Spacer(),
                  InkWellOver(
                    onTap: _close,
                    child: SvgPicture.asset(Assets.xCloseGray),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              if (args.isRecovery != null)
                _InjuryState(
                  isRecovery: args.isRecovery!,
                  onPressed: (bool isRecovery) {
                    if (args.isRecovery == isRecovery) {
                      return;
                    }
                    _selectFilterAndClose(isRecovery: isRecovery);
                  },
                ),
              _Order(
                orderType: args.orderType,
                onPressed: (HistoryOrderFilterType orderType) {
                  if (args.orderType == orderType) {
                    return;
                  }
                  _selectFilterAndClose(orderType: orderType);
                },
              ),
              const SizedBox(height: 24),
              _Date(
                dateType: args.dateType,
                onPressed: (HistoryDateFilterType dateType) {
                  if (args.dateType == dateType) {
                    return;
                  }
                  _selectFilterAndClose(dateType: dateType);
                },
              ),
            ],
          ),
        ),
      );
}

class _FieldName extends StatelessWidget {
  final String text;

  const _FieldName({
    required this.text,
  });

  @override
  Widget build(BuildContext context) => Text(
        text,
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: ColorRes.fontBlack,
          height: 22 / 14,
          letterSpacing: -0.5,
        ),
      );
}

class _Button extends StatelessWidget {
  final String text;

  final bool isSelected;

  final bool showShadow;

  final VoidCallback onPressed;

  const _Button({
    required this.text,
    required this.isSelected,
    this.showShadow = true,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => BaseButton(
        isSelected: isSelected,
        selectedBackgroundColor: ColorRes.thirdPrimary,
        text: text,
        showBorder: false,
        showShadow: showShadow,
        defaultTextStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: ColorRes.gray9f9f9f,
          height: 20 / 12,
          letterSpacing: -0.5,
        ),
        selectedTextStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: ColorRes.fontBlack,
          height: 20 / 12,
          letterSpacing: -0.5,
        ),
        onPressed: onPressed,
      );
}

class _InjuryState extends StatelessWidget {
  final bool isRecovery;

  final Function(bool) onPressed;

  const _InjuryState({
    required this.isRecovery,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FieldName(text: StringRes.myState.tr),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: _Button(
                  text: StringRes.historyFilterProgressInjury.tr,
                  isSelected: !isRecovery,
                  onPressed: () {
                    onPressed(false);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _Button(
                  text: StringRes.historyFilterHealedInjury.tr,
                  isSelected: isRecovery,
                  onPressed: () {
                    onPressed(true);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      );
}

class _Order extends StatelessWidget {
  final HistoryOrderFilterType orderType;

  final Function(HistoryOrderFilterType) onPressed;

  const _Order({
    required this.orderType,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FieldName(text: StringRes.sortBy.tr),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: _Button(
                  text: StringRes.historyFilterDesc.tr,
                  isSelected: orderType == HistoryOrderFilterType.desc,
                  onPressed: () {
                    onPressed(HistoryOrderFilterType.desc);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _Button(
                  text: StringRes.historyFilterAsc.tr,
                  isSelected: orderType == HistoryOrderFilterType.asc,
                  onPressed: () {
                    onPressed(HistoryOrderFilterType.asc);
                  },
                ),
              ),
            ],
          )
        ],
      );
}

class _Date extends StatelessWidget {
  final HistoryDateFilterType dateType;

  final Function(HistoryDateFilterType) onPressed;

  const _Date({
    required this.dateType,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FieldName(text: StringRes.inquiryPeriod.tr),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _Button(
                    text: StringRes.historyFilterAll.tr,
                    isSelected: dateType == HistoryDateFilterType.all,
                    showShadow: false,
                    onPressed: () {
                      onPressed(HistoryDateFilterType.all);
                    },
                  ),
                ),
                Expanded(
                  child: _Button(
                    text: StringRes.historyFilterWeek.tr,
                    isSelected: dateType == HistoryDateFilterType.week,
                    showShadow: false,
                    onPressed: () {
                      onPressed(HistoryDateFilterType.week);
                    },
                  ),
                ),
                Expanded(
                  child: _Button(
                    text: StringRes.historyFilterMonth.tr,
                    isSelected: dateType == HistoryDateFilterType.month,
                    showShadow: false,
                    onPressed: () {
                      onPressed(HistoryDateFilterType.month);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      );
}
