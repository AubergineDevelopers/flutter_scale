# Flutter Scale

A Flutter package allows you to easily integrate Scale widget.

## Preview
<img src="https://github.com/pinkeshdarji/flutter_notebook_page/blob/master/preview/preview.png" height="700" width="380" alt="Screenshot"/>

## Installing

1.  Add dependency to `pubspec.yaml`

    *Get the latest version in the 'Installing' tab on pub.dartlang.org*

```dart
dependencies:
    flutter_scale: 0.0.1
```

2.  Import the package
```dart
import 'package:flutter_scale/flutter_scale.dart';
```

3.  Adding Vertical Scale

```dart
class _Example1State extends State<Example1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: VerticalScale(
      maxValue: 13,
      scaleController: ScrollController(),
    ));
  }
}
```

4.  Adding Horizontal Scale

```dart
class _Example1State extends State<Example1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: HorizontalScale(
      maxValue: 25,
      scaleController: ScrollController(),
    ));
  }
}
```

*With optional parameters*

```dart
class _Example1State extends State<Example1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: VerticalScale(
      maxValue: 7,
      scaleController: ScrollController(initialScrollOffset: 200),
      scaleColor: Colors.redAccent,
      lineColor: Colors.amber,
      linesBetweenTwoPoints: 5,
      middleLineAt: 3,
      pointer: RotatedBox(
          quarterTurns: 1, child: Image.asset('assets/images/tooltip.png')),
      textStyle: TextStyle(
        fontSize: 35,
        color: Colors.amber,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
    ));
  }
}
```

## How to use
Check out the **example** app in the [example](example) directory or the 'Example' tab on pub.dartlang.org for a more complete example.
