import 'package:flutter/material.dart';

class CustomOnTap extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final double borderRadius;

  const CustomOnTap({
    super.key,
    required this.onTap,
    required this.child,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(borderRadius),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      child: InkWell(
        highlightColor: Theme.of(context).colorScheme.primaryContainer,
        splashColor: Theme.of(context).colorScheme.primaryContainer,
        focusColor: Theme.of(context).colorScheme.primaryContainer,
        hoverColor: Theme.of(context).colorScheme.primaryContainer,
        overlayColor: MaterialStateProperty.all(
          Colors.grey.withOpacity(0.33),
        ),
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Center(child: child),
      ),
    );
  }
}
