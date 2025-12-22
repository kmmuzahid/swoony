import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swoony/core/config/theme/cubit/theme_cubit.dart';

class SystemThemeListener extends StatefulWidget {
  final Widget child;
  const SystemThemeListener({super.key, required this.child});

  @override
  State<SystemThemeListener> createState() => _SystemThemeListenerState();
}

class _SystemThemeListenerState extends State<SystemThemeListener> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _notifyOnce(); // set initial
  }

  void _notifyOnce() {
    final b = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    context.read<ThemeCubit>().update(brightness: b);
  }

  @override
  void didChangePlatformBrightness() {
    final b = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    context.read<ThemeCubit>().update(brightness: b);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
