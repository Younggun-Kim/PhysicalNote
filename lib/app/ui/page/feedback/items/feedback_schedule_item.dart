import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/feedback/items/feedback_schedule_item_ui_state.dart';

class FeedbackScheduleItem extends StatelessWidget {
  final FeedbackScheduleItemUiState uiState;

  const FeedbackScheduleItem({super.key, required this.uiState});

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: ColorRes.borderWhite),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Tag(tag: uiState.tag, tagColor: uiState.tagColor),
            _Team(name: uiState.teamName),
            _Content(
              fieldName: StringRes.period.tr,
              content: uiState.period,
            ),
            _Content(
              fieldName: StringRes.name.tr,
              content: uiState.name,
            ),
            _Content(
              fieldName: StringRes.time.tr,
              content: uiState.time,
            ),
            _Content(
              fieldName: StringRes.place.tr,
              content: uiState.place,
            ),
            _Content(
              fieldName: StringRes.trainingContent.tr,
              content: uiState.training,
            ),
            _ImageList(
              imageList: uiState.imageList,
            ),
          ],
        ),
      );
}

/// 태그.
class _Tag extends StatelessWidget {
  final String? tag;
  final Color? tagColor;

  const _Tag({
    required this.tag,
    required this.tagColor,
  });

  @override
  Widget build(BuildContext context) => Visibility(
        visible: tag != null,
        child: Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
          color: tagColor ?? ColorRes.disable,
          child: Text(
            tag ?? "",
            style: const TextStyle(
              fontSize: 15,
              color: ColorRes.fontBlack,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
}

/// 팀.
class _Team extends StatelessWidget {
  final String? name;

  const _Team({
    this.name,
  });

  @override
  Widget build(BuildContext context) => Visibility(
        visible: name != null,
        child: Container(
          margin: const EdgeInsets.only(bottom: 2),
          child: Row(
            children: [
              SvgPicture.asset(Assets.starYellow),
              const SizedBox(width: 4),
              Text(
                name ?? "",
                style: const TextStyle(
                  fontSize: 15,
                  color: ColorRes.fontBlack,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );
}

/// 컨텐츠.
class _Content extends StatelessWidget {
  final String fieldName;
  final String? content;

  const _Content({required this.fieldName, this.content});

  final textStyle = const TextStyle(
    fontSize: 15,
    color: ColorRes.fontBlack,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) => Visibility(
        visible: content != null,
        child: Container(
          margin: const EdgeInsets.only(bottom: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$fieldName - ",
                style: textStyle,
              ),
              Expanded(child: Text(
                content ?? "",
                style: textStyle,
                softWrap: true,
              ),),
            ],
          ),
        ),
      );
}

class _ImageList extends StatelessWidget {
  final List<String>? imageList;

  const _ImageList({this.imageList});

  @override
  Widget build(BuildContext context) {
    final list = imageList;
    if (list == null || list.isEmpty) {
      return const SizedBox(
        width: 0,
        height: 0,
      );
    }

    return SizedBox(
      height: 107,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            list[index],
            height: 120,
            fit: BoxFit.contain,
          );
        },
      ),
    );
  }
}
