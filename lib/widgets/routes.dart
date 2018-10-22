import 'package:flutter/widgets.dart';

class NoTransitionRoute<T> extends PageRouteBuilder<T> {
  NoTransitionRoute({
    @required WidgetBuilder builder,
    Duration duration = const Duration(milliseconds: 450),
  })  : assert(duration != null),
        super(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) => builder(context),
          transitionDuration: duration,
        );
}
