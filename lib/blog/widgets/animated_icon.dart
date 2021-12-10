import 'package:rive/rive.dart';
import 'package:flutter/material.dart';

class RiveIcon extends StatefulWidget {
  const RiveIcon({
    Key? key,
    required this.iconUrl,
  }) : super(key: key);

  final String iconUrl;

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
      height: 48,
      child: Container(
        child: _buildIcon(),
      ),
    );
  }

  Widget _buildIcon() {
    return GestureDetector(
      onTap: () => _active ? null : _animationController.isActive = true,
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
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
