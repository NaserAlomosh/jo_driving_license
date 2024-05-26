import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSwitchValue extends StatelessWidget {
  final Function(bool) onChanged;
  final bool value;
  const CustomSwitchValue(
      {super.key, required this.onChanged, required this.value});

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      trackColor: Theme.of(context).colorScheme.outline,
      thumbColor: Theme.of(context).colorScheme.primary,
      activeColor: Theme.of(context).colorScheme.onError,
      value: value,
      onChanged: onChanged,
    );
  }
}
