import 'package:flutter/cupertino.dart';

const _leftPane = 'left_pane';
const _rightPane = 'right_pane';

// TODO: remove this since intrinsic height already fulfilled its job
class _MatchLeftPaneHeightLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(final Size size) {
    final paneWidth = size.width / 2;

    final leftPaneSize = layoutChild(
      _leftPane,
      BoxConstraints(
        minWidth: paneWidth,
        maxWidth: paneWidth,
        maxHeight: size.height,
      ),
    );

    final rightPaneSize = layoutChild(
      _rightPane,
      BoxConstraints(
        minWidth: paneWidth,
        maxWidth: paneWidth,
        maxHeight: leftPaneSize.height,
      ),
    );

    positionChild(_leftPane, const Offset(0, 0));
    positionChild(_rightPane, Offset(leftPaneSize.width, 0));
  }

  @override
  bool shouldRelayout(final _MatchLeftPaneHeightLayoutDelegate oldDelegate) {
    return false;
  }
}

class MatchLeftPaneHeightLayout extends StatelessWidget {
  final Widget leftChild;
  final Widget rightChild;

  const MatchLeftPaneHeightLayout({
    super.key,
    required this.leftChild,
    required this.rightChild,
  });

  @override
  Widget build(final BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _MatchLeftPaneHeightLayoutDelegate(),
      children: [
        LayoutId(id: _leftPane, child: leftChild),
        LayoutId(id: _rightPane, child: rightChild),
      ],
    );
  }
}
