import 'package:flutter/cupertino.dart';
import 'package:physical_note/app/domain/assignment/assignment.dart';
import 'package:physical_note/app/resources/colors/color_res.dart';
import 'package:physical_note/app/ui/widgets/text/text.dart';

class AssignmentItem extends StatelessWidget {
  final String title;
  final AssignmentEntity entity;

  const AssignmentItem({
    super.key,
    required this.title,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextBody3(
            title,
            isBold: true,
            color: ColorRes.grayA7,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: _Content(
            content: entity.feedback,
          ),
        ),
        const SizedBox(height: 14),
        _ImageListView(
          images: entity.images,
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final String content;

  const _Content({required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 162,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ColorRes.grayE0e0e0),
      ),
      child: TextBody2(content),
    );
  }
}

class _ImageListView extends StatelessWidget {
  final List<String> images;

  const _ImageListView({required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            images[index],
            width: 160,
            height: 100,
            fit: BoxFit.cover,
            loadingBuilder: (
              BuildContext context,
              Widget child,
              ImageChunkEvent? loadingProgress,
            ) {
              if (loadingProgress == null) return child;

              return Container(
                width: 160,
                height: 100,
                color: ColorRes.grayA7,
              );
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 20);
        },
      ),
    );
  }
}
