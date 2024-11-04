import 'package:flutter/material.dart';
import 'package:physical_note/app/config/constant/intensity_type.dart';
import 'package:physical_note/app/resources/colors/color_res.dart';
import 'package:physical_note/app/ui/widgets/slider/custom_slider_thumb_circle.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

const double sliderPadding = 12;

class IntensityNotiItem extends StatelessWidget {
  final IntensityType type;

  final double value;

  final String time;

  final Function(double) onSliderChanged;

  const IntensityNotiItem({
    super.key,
    required this.type,
    required this.value,
    required this.time,
    required this.onSliderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type.toKor,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: ColorRes.fontBlack,
            fontSize: 16,
            height: 20 / 16,
            letterSpacing: -0.5,
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: '09:30 - 11:00',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                ),
              ),
              const WidgetSpan(child: SizedBox(width: 10)),
              TextSpan(
                text: '($time)',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 20 / 16,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _SliderAxisLabels(),
        _Slider(
          value: value,
          onSliderChanged: onSliderChanged,
        ),
      ],
    );
  }
}

class _SliderAxisLabels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        sliderPadding * 2,
        0,
        sliderPadding + 6,
        0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(
            11,
            (int index) => Text(
              '$index',
              style: const TextStyle(
                fontSize: 10,
                color: ColorRes.grayBababa,
                height: 20 / 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Slider extends StatelessWidget {
  final double value;

  final Function(double) onSliderChanged;

  const _Slider({
    required this.value,
    required this.onSliderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _SliderBackground(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: sliderPadding),
          child: _SliderContent(
            value: value,
            onSliderChanged: onSliderChanged,
          ),
        ),
      ],
    );
  }
}

class _SliderBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorRes.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
        gradient: const LinearGradient(
          colors: [
            ColorRes.primary,
            Colors.white,
          ],
          stops: [0.5, 0.5],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
}

class _SliderContent extends StatelessWidget {
  final double value;

  final Function(double) onSliderChanged;

  const _SliderContent({
    required this.value,
    required this.onSliderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 10,
        activeTrackColor: ColorRes.primary,
        inactiveTrackColor: ColorRes.white,
        trackShape: const RectangularSliderTrackShape(),
        thumbColor: ColorRes.primary,
        thumbShape: const CustomSliderThumbCircle(
          thumbRadius: 10,
          currentValue: 0,
        ),
        overlayShape: SliderComponentShape.noThumb,
        tickMarkShape: CustomSliderTickMarkShape(),
      ),
      child: Slider(
        value: value,
        min: 0,
        max: 10,
        divisions: 10,
        onChanged: onSliderChanged,
      ),
    );
  }
}
