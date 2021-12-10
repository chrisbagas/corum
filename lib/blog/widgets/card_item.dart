import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/post.dart';
import './card_header.dart';

const prefixUrl = 'assets/graphics';

const iconUrls = [
  '$prefixUrl/trash_bin.riv',
  '$prefixUrl/pencil.riv',
];

@immutable
class CardItem extends StatelessWidget {
  CardItem({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardHeader(post: post),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                _buildParallaxBackground(context),
                _buildGradient(),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  post.title,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  post.subtitle,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 24, bottom: 20),
                child: Text(
                  'Posted on ${post.datePublished}',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: Color(0xFF2C2E3D),
          height: 0,
        ),
      ],
    );
  }

  final GlobalKey _backgroundImageKey = GlobalKey();

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context)!,
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.network(
          post.thumbnailUrl,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildGradient() {
    return const Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // 0x40632D37
            colors: [Color(0x80302129), Colors.transparent, Color(0x80011C26)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 0.6, 0.95],
          ),
        ),
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
      height: constraints.maxHeight * 1.2,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}
