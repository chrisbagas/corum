import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:corum/api/GetCookies.dart';

import 'delete_modal.dart';
import 'edit_form.dart';
import 'animated_icon.dart';
import '../models/post.dart';

const prefixUrl = 'assets/graphics';

const iconUrls = [
  '$prefixUrl/trash_bin_white.riv',
  '$prefixUrl/pencil_white.riv',
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
    final _request = context.watch<ConnectNetworkService>();
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
        trailing: (_request.username == widget.post.author)
            ? AnimatedOpacity(
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
                    color: Color(0xFFF2F8F2),
                  ),
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildExpanded(BuildContext context) {
    final DeleteModal _deleteModal = DeleteModal(slug: widget.post.slug);
    final EditForm _editForm = EditForm(post: widget.post);

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
              children: <Widget>[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 180),
                    opacity: _isExpanded ? 1 : 0,
                    child: RiveIcon(
                      iconUrl: iconUrls[0],
                      widgetDest: _deleteModal,
                      isModal: true,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 360),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 360),
                    opacity: _isExpanded ? 1 : 0,
                    child: RiveIcon(
                      iconUrl: iconUrls[1],
                      widgetDest: _editForm,
                      isModal: false,
                    ),
                  ),
                ),
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
                      Icons.linear_scale_rounded,
                      size: 20,
                      color: Color(0xFFF2F8F2),
                    ),
                  ),
                ),
              ],
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
