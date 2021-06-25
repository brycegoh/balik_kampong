import 'package:flutter/material.dart';

class PaddedSafeArea extends StatelessWidget {
  final Widget child;
  PaddedSafeArea({required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      minimum: const EdgeInsets.all(5),
      child: child,
    );
  }
}

class FullScreenContainer extends StatelessWidget {
  final Widget child;
  FullScreenContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: child,
    );
  }
}

class FullHeightContainer extends StatelessWidget {
  final Widget child;
  FullHeightContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: child,
    );
  }
}

class FullWidthContainer extends StatelessWidget {
  final Widget child;
  FullWidthContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: child,
    );
  }
}

/*
Following Widgets will return a Row or Column Widget in which
it is configured as named
RowMainAxisCrossAxis
 */

class ColumnCenterCenter extends StatelessWidget {
  final List<Widget> children;
  ColumnCenterCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class ColumnEndCenter extends StatelessWidget {
  final List<Widget> children;
  ColumnEndCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class ColumnEndStart extends StatelessWidget {
  final List<Widget> children;
  ColumnEndStart({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ); //Column
  }
}

class ColumnCenterStart extends StatelessWidget {
  final List<Widget> children;
  bool mainAxisMin;
  ColumnCenterStart({required this.children, this.mainAxisMin = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: mainAxisMin ? MainAxisSize.min : MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ); //Column
  }
}

class ColumnSpaceBetweenStretch extends StatelessWidget {
  final List<Widget> children;
  ColumnSpaceBetweenStretch({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ); //Column
  }
}

class ColunSpaceEvenlyStretch extends StatelessWidget {
  final List<Widget> children;
  ColunSpaceEvenlyStretch({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ); //Column
  }
}

class ColumnStartCenter extends StatelessWidget {
  final List<Widget> children;
  ColumnStartCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class ColumnStartStart extends StatelessWidget {
  final List<Widget> children;
  ColumnStartStart({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ); //Column
  }
}

class ColumnSpaceAroundCenter extends StatelessWidget {
  final List<Widget> children;
  ColumnSpaceAroundCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class RowCenterCenter extends StatelessWidget {
  final List<Widget> children;
  RowCenterCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class RowStartStart extends StatelessWidget {
  final List<Widget> children;
  RowStartStart({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ); //Column
  }
}

class RowStartCenter extends StatelessWidget {
  final List<Widget> children;
  RowStartCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class RowSpaceAroundCenter extends StatelessWidget {
  final List<Widget> children;
  RowSpaceAroundCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class RowSpaceEvenlyCenter extends StatelessWidget {
  final List<Widget> children;
  RowSpaceEvenlyCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class RowSpaceEvenlyStart extends StatelessWidget {
  final List<Widget> children;
  RowSpaceEvenlyStart({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ); //Column
  }
}

class RowSpaceBetweenCenter extends StatelessWidget {
  final List<Widget> children;
  RowSpaceBetweenCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class RowEndCenter extends StatelessWidget {
  final List<Widget> children;
  RowEndCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}
