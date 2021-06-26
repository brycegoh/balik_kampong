import 'package:flutter/material.dart';

class KampongPaddedSafeArea extends StatelessWidget {
  final Widget child;
  KampongPaddedSafeArea({required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      minimum: const EdgeInsets.all(5),
      child: child,
    );
  }
}

class KampongFullScreenContainer extends StatelessWidget {
  final Widget child;
  KampongFullScreenContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: child,
    );
  }
}

class KampongFullHeightContainer extends StatelessWidget {
  final Widget child;
  KampongFullHeightContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: child,
    );
  }
}

class KampongFullWidthContainer extends StatelessWidget {
  final Widget child;
  KampongFullWidthContainer({required this.child});

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

class KampongColumnCenterCenter extends StatelessWidget {
  final List<Widget> children;
  KampongColumnCenterCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class KampongColumnEndCenter extends StatelessWidget {
  final List<Widget> children;
  KampongColumnEndCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class KampongColumnEndStart extends StatelessWidget {
  final List<Widget> children;
  KampongColumnEndStart({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ); //Column
  }
}

class KampongColumnCenterStart extends StatelessWidget {
  final List<Widget> children;
  bool mainAxisMin;
  KampongColumnCenterStart({required this.children, this.mainAxisMin = false});

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

class KampongColumnSpaceBetweenStretch extends StatelessWidget {
  final List<Widget> children;
  KampongColumnSpaceBetweenStretch({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ); //Column
  }
}

class KampongColunSpaceEvenlyStretch extends StatelessWidget {
  final List<Widget> children;
  KampongColunSpaceEvenlyStretch({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ); //Column
  }
}

class KampongColumnStartCenter extends StatelessWidget {
  final List<Widget> children;
  KampongColumnStartCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class KampongColumnStartStart extends StatelessWidget {
  final List<Widget> children;
  KampongColumnStartStart({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ); //Column
  }
}

class KampongColumnSpaceAroundCenter extends StatelessWidget {
  final List<Widget> children;
  KampongColumnSpaceAroundCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class KampongRowCenterCenter extends StatelessWidget {
  final List<Widget> children;
  KampongRowCenterCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class KampongRowStartStart extends StatelessWidget {
  final List<Widget> children;
  KampongRowStartStart({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ); //Column
  }
}

class KampongRowStartCenter extends StatelessWidget {
  final List<Widget> children;
  KampongRowStartCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class KampongRowSpaceAroundCenter extends StatelessWidget {
  final List<Widget> children;
  KampongRowSpaceAroundCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class KampongRowSpaceEvenlyCenter extends StatelessWidget {
  final List<Widget> children;
  KampongRowSpaceEvenlyCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class KampongRowSpaceEvenlyStart extends StatelessWidget {
  final List<Widget> children;
  KampongRowSpaceEvenlyStart({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ); //Column
  }
}

class KampongRowSpaceBetweenCenter extends StatelessWidget {
  final List<Widget> children;
  KampongRowSpaceBetweenCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class KampongRowEndCenter extends StatelessWidget {
  final List<Widget> children;
  KampongRowEndCenter({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ); //Column
  }
}

class KampongColumnSpaceAroundStart extends StatelessWidget {
  final List<Widget> children;
  KampongColumnSpaceAroundStart({required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ); //Column
  }
}
