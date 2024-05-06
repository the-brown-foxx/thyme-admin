import 'dart:ui';

enum Corner {
  topLeft,
  topRight,
  bottomRight,
  bottomLeft;

  static const all = {
    Corner.topLeft,
    Corner.topRight,
    Corner.bottomRight,
    Corner.bottomLeft,
  };
}

class Edge {
  Edge._();

  static const left = {Corner.bottomLeft, Corner.topLeft};
  static const top = {Corner.topLeft, Corner.topRight};
  static const right = {Corner.topRight, Corner.bottomRight};
  static const bottom = {Corner.bottomRight, Corner.bottomLeft};
}

extension RoundedCorners on Set<Corner> {
  Radius getRadius(final Corner corner) =>
      Radius.circular(contains(corner) ? 16 : 8);
}
