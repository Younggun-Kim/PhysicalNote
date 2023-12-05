import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/my_information/my_information_ui_mapper.dart';
import 'package:physical_note/app/ui/page/test/model/muscle_data.dart';
import 'package:physical_note/app/ui/page/test/test.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';
import 'package:svg_path_parser/svg_path_parser.dart';


class TestPage extends GetView<TestController> {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: InteractiveViewer(
            maxScale: 5,
            minScale: 0.1,
            scaleEnabled: true,
            child: Obx(
              () => Stack(
                children: controller.muscleList.value.map(
                  (muscleData) {
                    return _getClippedImage(
                      muscleData: muscleData,
                      color: muscleData.isSelected ? Colors.grey.withOpacity(0.3) : Colors.pink,
                    );
                  },
                ).toList(),
              ),
            )),
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
