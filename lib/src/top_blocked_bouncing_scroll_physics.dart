import 'dart:math' show min;

import 'package:flutter/material.dart';

/// `ScrollPhysics` implementation which behaves like `BouncingScrollPhysics`,
/// except doesn't let you to over-scroll on top.
///
/// If you want your scroll-view to be always scrollable,
/// use [TopBlockedBouncingScrollPhysics] as a parent of
/// [AlwaysScrollableScrollPhysics], not the other way round:
///
/// ```dart
/// return ListView(
///   physics: const AlwaysScrollableScrollPhysics(
///     parent: TopBlockedBouncingScrollPhysics(),
///   ),
/// );
/// ```
class TopBlockedBouncingScrollPhysics extends BouncingScrollPhysics {
  const TopBlockedBouncingScrollPhysics({super.parent});

  @override
  BouncingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return TopBlockedBouncingScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (_checkIsUnderScroll(position, value)) {
      return value - position.pixels;
    }
    if (_checkDidHitTopEdge(position, value)) {
      return value - position.minScrollExtent;
    }

    return 0;
  }

  bool _checkIsUnderScroll(ScrollMetrics position, double value) {
    return value < position.pixels &&
        position.pixels <= position.minScrollExtent;
  }

  bool _checkDidHitTopEdge(ScrollMetrics position, double value) {
    return value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels;
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final Tolerance tolerance = this.tolerance;
    if (position.outOfRange) {
      double? end;
      if (position.pixels > position.maxScrollExtent) {
        end = position.maxScrollExtent;
      }
      if (position.pixels < position.minScrollExtent) {
        end = position.minScrollExtent;
      }

      return ScrollSpringSimulation(
        spring,
        position.pixels,
        end!,
        min(0.0, velocity),
        tolerance: tolerance,
      );
    }

    if (velocity.abs() < tolerance.velocity) {
      return null;
    }
    if (velocity > 0.0 && position.pixels >= position.maxScrollExtent) {
      return null;
    }
    if (velocity < 0.0 && position.pixels <= position.minScrollExtent) {
      return null;
    }

    return ClampingScrollSimulation(
      position: position.pixels,
      velocity: velocity,
      tolerance: tolerance,
    );
  }
}
