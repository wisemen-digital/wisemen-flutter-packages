import 'package:flutter/material.dart';

/// [TrueCenterColumn] is a widget that centers its children vertically
/// disregarding the first child
class TrueCenterColumn extends StatefulWidget {
  /// Constructor [TrueCenterColumn]
  const TrueCenterColumn({
    required this.firstChild,
    required this.secondChild,
    super.key,
    this.lockedTop = false,
  });

  /// First child widget
  final Widget firstChild;

  /// Second child widget
  final Widget secondChild;

  /// Lock the top child
  final bool lockedTop;

  @override
  State<TrueCenterColumn> createState() => _TrueCenterColumnState();
}

class _TrueCenterColumnState extends State<TrueCenterColumn> {
  final GlobalKey _key1 = GlobalKey();
  double? _itemHeight1;

  final GlobalKey _key2 = GlobalKey();
  double? _itemHeight2;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _itemHeight1 = (_key1.currentContext!.findRenderObject()! as RenderBox)
            .size
            .height;
        _itemHeight2 = (_key2.currentContext!.findRenderObject()! as RenderBox)
            .size
            .height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Widget child1 = LayoutBuilder(
          builder: (context, constraints) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final height =
                  (_key1.currentContext!.findRenderObject()! as RenderBox)
                      .size
                      .height;
              if (height != _itemHeight1) {
                setState(() {
                  _itemHeight1 = height;
                });
              }
            });
            return KeyedSubtree(
              key: _key1,
              child: widget.firstChild,
            );
          },
        );

        final Widget child2 = LayoutBuilder(
          builder: (context, constraints) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final height =
                  (_key2.currentContext!.findRenderObject()! as RenderBox)
                      .size
                      .height;
              if (height != _itemHeight2) {
                setState(() {
                  _itemHeight2 = height;
                });
              }
            });
            return KeyedSubtree(
              key: _key2,
              child: widget.secondChild,
            );
          },
        );

        if (_itemHeight1 == null || _itemHeight2 == null) {
          return Column(
            children: [
              child1,
              child2,
            ],
          );
        }

        if ((constraints.maxHeight) < (_itemHeight1! + _itemHeight2!)) {
          if (widget.lockedTop) {
            return Column(
              children: [
                child1,
                Expanded(
                  child: SingleChildScrollView(
                    child: child2,
                  ),
                ),
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  child1,
                  child2,
                ],
              ),
            );
          }
        }

        if ((constraints.maxHeight - ((_itemHeight1! * 2) + _itemHeight2!)) >
            0) {
          return Column(
            children: [
              child1,
              SizedBox(
                height: (constraints.maxHeight -
                        ((_itemHeight1! * 2) + _itemHeight2!)) /
                    2,
              ),
              child2,
            ],
          );
        } else {
          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    child1,
                    child2,
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
