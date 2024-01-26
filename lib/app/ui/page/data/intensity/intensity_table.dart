import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';
import 'package:physical_note/app/utils/extensions/border_extensions.dart';

import 'intensity_level_type.dart';

/// Intensity 테이블.
class IntensityTable extends StatelessWidget {
  final int level;

  final Function(int) onPressed;

  const IntensityTable({super.key, required this.level, required this.onPressed});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _TableHeader(),
      _TableCellOver(
        level: level,
        onPressed: onPressed,
      ),
      _TableCellVeryHard(
        level: level,
        onPressed: onPressed,
      ),
      _TableCellHard(
        level: level,
        onPressed: onPressed,
      ),
      _TableCellNormal(
        level: level,
        onPressed: onPressed,
      ),
      _TableCellEasy(
        level: level,
        onPressed: onPressed,
      ),
      _TableCellVeryEasy(
        level: level,
        onPressed: onPressed,
      )
    ],
  );
}

/// 테이블 셀 컨테이너.
class _TableCellContainer extends StatelessWidget {
  final Widget child;

  const _TableCellContainer({
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(
      border: BorderExt.bottomBorder(),
    ),
    child: child,
  );
}

/// 테이블 레벨.
class _TableLevel extends StatelessWidget {
  final String level;

  const _TableLevel({required this.level});

  @override
  Widget build(BuildContext context) => Text(
    level,
    textAlign: TextAlign.center,
    style: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: ColorRes.fontBlack,
    ),
  );
}

/// 테이블 설명.
class _TableDescription extends StatelessWidget {
  final String text;

  const _TableDescription({required this.text});

  @override
  Widget build(BuildContext context) => Text(
    text,
    textAlign: TextAlign.center,
    style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: ColorRes.fontBlack,
      height: 2,
    ),
  );
}

/// 테이블 라디오 버튼.
class _TableRadio extends StatelessWidget {
  final bool isSelected;

  final VoidCallback onPressed;

  const _TableRadio({required this.isSelected, required this.onPressed});

  @override
  Widget build(BuildContext context) => Center(
    child: InkWellOver(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 21,
        height: 21,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: isSelected ? ColorRes.primary : ColorRes.white,
          border: Border.all(color: ColorRes.primary, width: 2),
          shape: BoxShape.circle,
        ),
      ),
    ),
  );
}

/// 테이블 헤더.
class _TableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _TableCellContainer(
    child: Row(
      children: [
        const Expanded(child: Text("")),
        Expanded(
          child: Text(
            StringRes.intensity.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorRes.fontBlack,
            ),
          ),
        ),
        Expanded(
          child: Text(
            StringRes.description.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorRes.fontBlack,
            ),
          ),
        ),
        const Expanded(child: Text("")),
      ],
    ),
  );
}

/// 테이블 셀 Over.
class _TableCellOver extends StatelessWidget {
  final int level;

  final Function(int) onPressed;

  const _TableCellOver({required this.level, required this.onPressed});

  @override
  Widget build(BuildContext context) => _TableCellContainer(
    child: Row(
      children: [
        const Expanded(child: _TableLevel(level: "10")),
        Expanded(
          child: _TableDescription(
            text: IntensityLevelType.over.toIntensity(),
          ),
        ),
        Expanded(
          child: _TableDescription(
            text: IntensityLevelType.over.toDescription(),
          ),
        ),
        Expanded(
          child: _TableRadio(
              isSelected: level == 10,
              onPressed: () {
                onPressed(10);
              }),
        ),
      ],
    ),
  );
}

/// 테이블 셀 Very Hard.
class _TableCellVeryHard extends StatelessWidget {
  final int level;

  final Function(int) onPressed;

  const _TableCellVeryHard({required this.level, required this.onPressed});

  @override
  Widget build(BuildContext context) => _TableCellContainer(
    child: Row(
      children: [
        const Expanded(child: _TableLevel(level: "9")),
        Expanded(
          child: _TableDescription(
            text: IntensityLevelType.veryHard.toIntensity(),
          ),
        ),
        Expanded(
          child: _TableDescription(
            text: IntensityLevelType.veryHard.toDescription(),
          ),
        ),
        Expanded(
          child: _TableRadio(
            isSelected: level == 9,
            onPressed: () {
              onPressed(9);
            },
          ),
        ),
      ],
    ),
  );
}

/// 테이블 셀 Hard.
class _TableCellHard extends StatelessWidget {
  final int level;

  final Function(int) onPressed;

  const _TableCellHard({required this.level, required this.onPressed});

  @override
  Widget build(BuildContext context) => _TableCellContainer(
    child: Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _TableLevel(level: "8"),
              SizedBox(height: 24),
              _TableLevel(level: "7"),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _TableDescription(
                text: IntensityLevelType.hard.toIntensity(),
              ),
              const SizedBox(height: 32),
              _TableDescription(
                text: IntensityLevelType.hard.toIntensity(),
              ),
            ],
          ),
        ),
        Expanded(
          child: _TableDescription(
            text: IntensityLevelType.hard.toDescription(),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _TableRadio(
                isSelected: level == 8,
                onPressed: () {
                  onPressed(8);
                },
              ),
              const SizedBox(height: 32),
              _TableRadio(
                isSelected: level == 7,
                onPressed: () {
                  onPressed(7);
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// 테이블 셀 Normal.
class _TableCellNormal extends StatelessWidget {
  final int level;

  final Function(int) onPressed;

  const _TableCellNormal({required this.level, required this.onPressed});

  @override
  Widget build(BuildContext context) => _TableCellContainer(
    child: Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _TableLevel(level: "6"),
              SizedBox(height: 24),
              _TableLevel(level: "5"),
              SizedBox(height: 24),
              _TableLevel(level: "4"),
            ],
          ),
        ),
        Expanded(
          child: Column(children: [
            _TableDescription(
              text: IntensityLevelType.normal.toIntensity(),
            ),
            const SizedBox(height: 32),
            _TableDescription(
              text: IntensityLevelType.normal.toIntensity(),
            ),
            const SizedBox(height: 32),
            _TableDescription(
              text: IntensityLevelType.normal.toIntensity(),
            ),
          ]),
        ),
        Expanded(
          child: _TableDescription(
            text: IntensityLevelType.normal.toDescription(),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              _TableRadio(
                isSelected: level == 6,
                onPressed: () {
                  onPressed(6);
                },
              ),
              const SizedBox(height: 32),
              _TableRadio(
                isSelected: level == 4,
                onPressed: () {
                  onPressed(4);
                },
              ),
              const SizedBox(height: 32),
              _TableRadio(
                isSelected: level == 5,
                onPressed: () {
                  onPressed(5);
                },
              )
            ],
          ),
        ),
      ],
    ),
  );
}

/// 테이블 셀 Easy.
class _TableCellEasy extends StatelessWidget {
  final int level;

  final Function(int) onPressed;

  const _TableCellEasy({required this.level, required this.onPressed});

  @override
  Widget build(BuildContext context) => _TableCellContainer(
    child: Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _TableLevel(level: "3"),
              SizedBox(height: 24),
              _TableLevel(level: "2"),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _TableDescription(
                text: IntensityLevelType.easy.toIntensity(),
              ),
              const SizedBox(height: 32),
              _TableDescription(
                text: IntensityLevelType.easy.toIntensity(),
              ),
            ],
          ),
        ),
        Expanded(
          child: _TableDescription(
            text: IntensityLevelType.easy.toDescription(),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _TableRadio(
                isSelected: level == 3,
                onPressed: () {
                  onPressed(3);
                },
              ),
              const SizedBox(height: 32),
              _TableRadio(
                isSelected: level == 2,
                onPressed: () {
                  onPressed(2);
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// 테이블 셀 Very Easy.
class _TableCellVeryEasy extends StatelessWidget {
  final int level;

  final Function(int) onPressed;

  const _TableCellVeryEasy({required this.level, required this.onPressed});

  @override
  Widget build(BuildContext context) => _TableCellContainer(
    child: Row(
      children: [
        const Expanded(child: _TableLevel(level: "1")),
        Expanded(
          child: _TableDescription(
            text: IntensityLevelType.veryEasy.toIntensity(),
          ),
        ),
        Expanded(
          child: _TableDescription(
            text: IntensityLevelType.veryEasy.toDescription(),
          ),
        ),
        Expanded(
          child: _TableRadio(
              isSelected: level == 1,
              onPressed: () {
                onPressed(1);
              }),
        ),
      ],
    ),
  );
}
