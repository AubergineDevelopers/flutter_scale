import 'package:flutter/material.dart';
import 'package:flutter_scale/flutter_scale.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Example(),
    );
  }
}

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  ScrollController _weightController;
  ScrollController _heightController;

  final feetController = TextEditingController();
  final inchController = TextEditingController();
  final kilogramController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _weightController = ScrollController(initialScrollOffset: 0);
    _heightController = ScrollController(initialScrollOffset: 0);
  }

  @override
  void dispose() {
    feetController.dispose();
    inchController.dispose();
    kilogramController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Height',
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 100,
                              child: TextField(
                                controller: feetController,
                                style: TextStyle(fontSize: 22),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: '0',
                                    suffixText: 'ft',
                                    border: OutlineInputBorder()),
                                //onSubmitted: _heightChangeScale(),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 100,
                              child: TextField(
                                controller: inchController,
                                style: TextStyle(fontSize: 22),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: '0',
                                    suffixText: 'in',
                                    border: OutlineInputBorder()),
                                //onSubmitted: _heightChangeScale(),
                              ),
                            ),
                          ],
                        ),
                        RaisedButton(
                          onPressed: _heightChangeScale,
                          child: Text('set height'),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Weight',
                          style: TextStyle(fontSize: 30),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 120,
                              child: TextField(
                                controller: kilogramController,
                                style: TextStyle(fontSize: 22),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: '0',
                                    suffixText: 'kg',
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            RaisedButton(
                              onPressed: _setWeight,
                              child: Text('set weight'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  )),
                  HorizontalScale(
                    maxValue: 200,
                    scaleController: _weightController,
                    onChanged: _handleWeightScaleChanged,
                  ),
                ],
              ),
            ),
            VerticalScale(
              maxValue: 13,
              scaleController: _heightController,
              scaleColor: Colors.amberAccent,
              lineColor: Colors.purple,
              linesBetweenTwoPoints: 11,
              middleLineAt: 6,
              textStyle: TextStyle(
                  fontSize: 22,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold),
              onChanged: _handleHeightScaleChanged,
            ),
          ],
        ),
      ),
    );
  }

  ///Height related methods
  _heightChangeScale() {
    double feet = double.tryParse(feetController.text) ?? 0;
    double inch = double.tryParse(inchController.text) ?? 0;

    // feet * 12 to get inches.
    double feetToInch = feet * 12;

    /// scale only understands scale points.
    /// So we need to convert our measurement into scale points by multiplying our measurement unit with 20
    /// i.e scale points = measurement unit * 20.
    /// inches * 20 to get actual scale point. NOTE: 20 is the actual distance between two lines.
    double inchToScalePoints = feetToInch * 20 + inch * 20;

    if (_heightController.hasClients) {
      _heightController.animateTo(inchToScalePoints,
          duration: Duration(milliseconds: 1000), curve: Curves.fastOutSlowIn);
    }
  }

  void _handleHeightScaleChanged(int scalePoints) {
    /// scale only understands scale points.
    /// So we need to convert scale points into our measurement unit by dividing scale point with 20.
    ///  i.e measurement unit = scale point / 20.
    int inchOffest = scalePoints ~/ 20;
    int feet = inchOffest ~/ 12;
    int inch = inchOffest % 12;

    feetController.text = feet.toString();
    inchController.text = inch.toString();
  }

  ///Weight related methods
  _setWeight() {
    double moveToFeet = double.tryParse(kilogramController.text) ?? 0;
    double moveToPixel =
        moveToFeet / 0.1 * 20; //scale points = measurement unit * 20.

    if (_weightController.hasClients) {
      _weightController.animateTo(moveToPixel,
          duration: Duration(milliseconds: 1000), curve: Curves.fastOutSlowIn);
    }
  }

  void _handleWeightScaleChanged(int scalePoints) {
    int gram = scalePoints ~/ 20; //measurement unit = scale point / 20.
    double kg = ((gram * 100) / 1000);
    kilogramController.text = kg.toString();
  }
}
