import 'package:rive/rive.dart';
import 'package:flutter/material.dart';

class RiveIcon extends StatefulWidget {
  const RiveIcon({
    Key? key,
    required this.iconUrl,
    required this.widgetDest,
    required this.isModal,
  }) : super(key: key);

  final String iconUrl;
  final Widget widgetDest;
  final bool isModal;

  @override
  _AnimatedIconState createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<RiveIcon> {
  bool _active = false;
  late RiveAnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = OneShotAnimation(
      'run',
      autoplay: false,
      onStart: () => setState(() => _active = true),
      onStop: () => setState(() => _active = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 10, 0, 10),
      height: 28,
      child: Container(
        child: _buildIcon(),
      ),
    );
  }

  Widget _buildIcon() {
    return GestureDetector(
      // TODO refresh page if possible
      onTap: () async {
        _active ? null : _animationController.isActive = true;
        if (widget.isModal) {
          if (await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return widget.widgetDest;
                },
              ) ==
              true) {
            setState(() {});
          }
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.widgetDest),
          );
        }
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: RiveAnimation.asset(
            widget.iconUrl,
            animations: const ['run'],
            controllers: [_animationController],
          ),
        ),
      ),
    );
  }
}
