import 'package:flutter/material.dart';

class HorizontalFeaturedItems extends StatefulWidget {
  final int initialPage;
  final double aspectRatio;
  final double viewportFraction;
  final EdgeInsetsGeometry padding;
  final SliverChildDelegate childrenDelegate;

  HorizontalFeaturedItems({
    Key key,
    this.initialPage: 0,
    this.aspectRatio: 1.0,
    this.viewportFraction: 1.0,
    this.padding = EdgeInsets.zero,
    @required IndexedWidgetBuilder itemBuilder,
    int itemCount,
    bool addAutomaticKeepAlives: true,
    bool addRepaintBoundaries: true,
  })  : childrenDelegate = new SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
        ),
        super(key: key);

  @override
  HorizontalFeaturedItemsState createState() {
    return new HorizontalFeaturedItemsState();
  }
}

class HorizontalFeaturedItemsState extends State<HorizontalFeaturedItems> {
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: this.widget.initialPage,
      viewportFraction: this.widget.viewportFraction,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      final double itemWidth = (constraints.maxWidth - widget.padding.horizontal) * this.widget.viewportFraction;
      final double itemHeight = (itemWidth * this.widget.aspectRatio);
      return Container(
        height: itemHeight,
        child: ListView.custom(
          scrollDirection: Axis.horizontal,
          controller: _controller,
          physics: const PageScrollPhysics(),
          padding: this.widget.padding,
          itemExtent: itemWidth,
          childrenDelegate: this.widget.childrenDelegate,
        ),
      );
    });
  }
}
