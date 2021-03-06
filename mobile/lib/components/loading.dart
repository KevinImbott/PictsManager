import 'package:flutter/material.dart';

///
/// Widget for displaying loading animation and doing background work at the same time.
///
class EzTransition extends StatefulWidget {
  EzTransition(this.child, this.toProcess, {required this.backgroundColor});

  final Function() toProcess;
  final Widget child;
  final Color backgroundColor;

  @override
  _EzTransitionState createState() => _EzTransitionState();
}

class _EzTransitionState extends State<EzTransition> {
  @override
  void initState() {
    super.initState();
    widget.toProcess();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: getBackgroundColor(),
      child: widget.child,
    );
  }

  Color getBackgroundColor() {
    return widget.backgroundColor == null
        ? Theme.of(context).backgroundColor
        : widget.backgroundColor;
  }
}