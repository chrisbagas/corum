import 'package:flutter/material.dart';
import 'animated_icon.dart';
import '../models/post.dart';

const prefixUrl = 'assets/graphics';

const iconUrls = [
  '$prefixUrl/trash_bin.riv',
  '$prefixUrl/pencil.riv',
];

class CardHeader extends StatefulWidget {
  const CardHeader({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  _CardHeaderState createState() => _CardHeaderState();
}

class _CardHeaderState extends State<CardHeader> {
  bool _isExpanded = false;

  void toggleExpand() {
    _isExpanded = !_isExpanded;
  }

  Widget _buildInit(BuildContext context) {
    return IgnorePointer(
      ignoring: _isExpanded,
      child: ListTile(
        contentPadding:
            const EdgeInsets.only(left: 10, right: 0, bottom: 4, top: 4),
        leading: const CircleAvatar(
          radius: 18,
          //backgroundImage: ,
        ),
        title: AnimatedOpacity(
          duration: const Duration(milliseconds: 180),
          opacity: _isExpanded ? 0 : 1,
          child: Text(
            widget.post.author,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        trailing: AnimatedOpacity(
          duration: const Duration(milliseconds: 180),
          opacity: _isExpanded ? 0 : 1,
          child: IconButton(
            onPressed: () {
              setState(() {
                toggleExpand();
              });
            },
            icon: const Icon(
              Icons.more_horiz_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpanded(BuildContext context) {
    List<Widget> l = [];

    int temp = 1;

    for (String iconUrl in iconUrls) {
      l.add(
        AnimatedContainer(
          duration: Duration(milliseconds: 180 * temp),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 180 * temp++),
            opacity: _isExpanded ? 1 : 0,
            child: RiveIcon(iconUrl: iconUrl),
          ),
        ),
      );
    }

    l.add(
      AnimatedOpacity(
        duration: const Duration(milliseconds: 180),
        opacity: _isExpanded ? 1 : 0,
        child: IconButton(
          onPressed: () {
            setState(() {
              toggleExpand();
            });
          },
          icon: const Icon(
            Icons.circle,
            size: 4.2,
            color: Colors.white,
          ),
        ),
      ),
    );

    return IgnorePointer(
      ignoring: !_isExpanded,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 0, bottom: 4, top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: l,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildExpanded(context),
        _buildInit(context),
      ],
    );
  }
}
