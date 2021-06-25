import 'package:flutter/material.dart';

class PowerButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const PowerButton({Key? key, required this.child, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
