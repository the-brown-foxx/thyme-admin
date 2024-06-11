import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/circular_progress_indicator.dart';
import 'package:thyme_to_park_admin/ui/util/loadable.dart';

class LoadableBuilder<T> extends StatelessWidget {
  final Loadable<T> loadable;
  final Widget Function(BuildContext, T) builder;

  const LoadableBuilder({
    super.key,
    required this.loadable,
    required this.builder,
  });

  @override
  Widget build(final BuildContext context) {
    final loadable = this.loadable;

    return AnimatedSize(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 150),
      child: loadable is Loaded<T>
          ? builder(context, loadable.value)
          : const IntrinsicHeight(
            child: Center(
                child: Padding(
                  padding: EdgeInsets.all(64),
                  child: HerbHubCircularProgressIndicator(),
                ),
              ),
          ),
    );
  }
}
