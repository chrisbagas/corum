import 'package:flutter/material.dart';
import 'package:forum_corum/forum/screens/forum_detail_page.dart';
// import '../models/forum_model.dart';
import 'package:timeago/timeago.dart' as timeago;
// import 'package:forum_corum/forum/models/forum_model_alt.dart';
import 'package:forum_corum/forum/models/forum_model.dart';

// import './card_header.dart';

@immutable
class CardItem extends StatefulWidget {
  const CardItem({
    Key? key,
    required this.forum,
  }) : super(key: key);

  final Forum forum;

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool _showDetailButton = false;

  @override
  Widget build(BuildContext context) {
    // return Card(
    //   margin: const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 0),
    //   child: InkWell(
    //     onTap: () {},
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         // CardHeader(forum: forum),
    //         Container(
    //           padding: const EdgeInsets.symmetric(horizontal: 12),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Row(
    //                 children: [
    //                   Container(
    //                     margin: const EdgeInsets.symmetric(
    //                         vertical: 5, horizontal: 15.0),
    //                     child: CircleAvatar(
    //                       child: Text(
    //                         forum.authorUsername[0],
    //                       ),
    //                     ),
    //                   ),
    //                   Container(
    //                     padding: const EdgeInsets.only(top: 24, bottom: 20),
    //                     child: Text(
    //                       '${forum.authorUsername} - ${timeago.format(forum.modifiedTime)}',
    //                       style: Theme.of(context).textTheme.caption,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               Container(
    //                 padding:
    //                     const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
    //                 child: Text(
    //                   forum.title,
    //                   style: Theme.of(context).textTheme.headline4,
    //                 ),
    //               ),
    //               // Container(
    //               //   padding: const EdgeInsets.only(bottom: 6),
    //               //   child: Text(
    //               //     forum.author,
    //               //     style: Theme.of(context).textTheme.headline5,
    //               //   ),
    //               // ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Card(
      margin: const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 0),
      child: InkWell(
        onTap: () {
          setState(() => _showDetailButton = !_showDetailButton);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ForumDetailPage()),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CircleAvatar(
                  child: Text(
                    widget.forum.authorUsername[0],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.forum.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'posted by ${widget.forum.authorUsername} - ${timeago.format(widget.forum.modifiedTime)}',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5.0, right: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 38,
                          child: TextButton(
                            onPressed: () {},
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 20.0,
                              semanticLabel: 'Delete',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 38,
                          child: TextButton(
                            onPressed: () {},
                            child: const Icon(
                              Icons.edit,
                              color: Colors.green,
                              size: 20.0,
                              semanticLabel: 'Edit',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text('0 reply'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ParallaxFlowDelegate extends FlowDelegate {
//   ParallaxFlowDelegate({
//     required this.scrollable,
//     required this.listItemContext,
//     required this.backgroundImageKey,
//   }) : super(repaint: scrollable.position);

//   final ScrollableState scrollable;
//   final BuildContext listItemContext;
//   final GlobalKey backgroundImageKey;

//   @override
//   BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
//     return BoxConstraints.tightFor(
//       width: constraints.maxWidth,
//       height: constraints.maxHeight * 1.2,
//     );
//   }

//   @override
//   void paintChildren(FlowPaintingContext context) {
//     final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
//     final listItemBox = listItemContext.findRenderObject() as RenderBox;
//     final listItemOffset = listItemBox.localToGlobal(
//         listItemBox.size.centerLeft(Offset.zero),
//         ancestor: scrollableBox);

//     final viewportDimension = scrollable.position.viewportDimension;
//     final scrollFraction =
//         (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

//     final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

//     final backgroundSize =
//         (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
//             .size;
//     final listItemSize = context.size;
//     final childRect =
//         verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

//     context.paintChild(
//       0,
//       transform:
//           Transform.translate(offset: Offset(0.0, childRect.top)).transform,
//     );
//   }

//   @override
//   bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
//     return scrollable != oldDelegate.scrollable ||
//         listItemContext != oldDelegate.listItemContext ||
//         backgroundImageKey != oldDelegate.backgroundImageKey;
//   }
// }
