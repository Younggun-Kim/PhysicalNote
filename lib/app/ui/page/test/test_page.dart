import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/test/model/muscle_data.dart';
import 'package:physical_note/app/ui/page/test/test.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class TestPage extends GetView<TestController> {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: Obx(
          () {
            try {
              return SvgPicture.string(
                controller.svgString.value,
                height: 200,
                width: 200,
              );
            } catch (e) {
              return const SizedBox();
            }
          },
        ),
      );

  Widget _getClippedImage({
    required MuscleData muscleData,
    required Color color,
  }) {
    return ClipPath(
      clipper: Clipper(
        svgPath: muscleData.path,
      ),
      child: GestureDetector(
        onTap: () {
          controller.onPressedMuscle(muscleData);
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          color: color,
        ),
      ),
    );
  }
}

class Clipper extends CustomClipper<Path> {
  Clipper({
    required this.svgPath,
  });

  String svgPath;

  @override
  Path getClip(Size size) {
    var path = parseSvgPath(svgPath);
    final Matrix4 matrix4 = Matrix4.identity();

    matrix4.scale(1.1, 1.1);

    return path.transform(matrix4.storage).shift(const Offset(-220, 0));
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
