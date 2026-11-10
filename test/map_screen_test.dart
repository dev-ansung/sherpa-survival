import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yosemite_survival/geo/compass_controller.dart';
import 'package:yosemite_survival/location/location_service.dart';
import 'package:yosemite_survival/map3d/map3d.dart';
import 'package:yosemite_survival/ui/topo_3d_viewport.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Map3d.available returns false when native channel is unavailable', () async {
    final available = await Map3d.available();
    expect(available, isFalse);
  });

  test('Map3d.open returns false when native channel is unavailable', () async {
    final ok = await Map3d.open(lat: 37.7456, lon: -119.5936);
    expect(ok, isFalse);
  });

  test('CompassController initializes with default pitch and zoom', () {
    final c = CompassController();
    expect(c.heading, 0.0);
    expect(c.pitch, closeTo(42.0, 0.001));
    expect(c.zoom, closeTo(1.0, 0.001));
    expect(c.sensorLocked, isTrue);

    c.zoomIn();
    expect(c.zoom, closeTo(1.2, 0.001));

    c.zoomOut();
    expect(c.zoom, closeTo(1.0, 0.001));

    c.setManualRotation(10, -5);
    expect(c.sensorLocked, isFalse);
    expect(c.heading, closeTo(10.0, 0.001));
    expect(c.pitch, closeTo(37.0, 0.001));

    c.resetOrientation();
    expect(c.pitch, closeTo(42.0, 0.001));
    expect(c.zoom, closeTo(1.0, 0.001));
    expect(c.sensorLocked, isTrue);

    c.dispose();
  });

  testWidgets('Topo3DViewport renders without errors with breadcrumbs', (tester) async {
    final c = CompassController();
    final now = DateTime.now();
    final crumbs = [
      Fix(37.7323, -119.5577, 5, 1220, now.subtract(const Duration(hours: 1))),
      Fix(37.7290, -119.5490, 5, 1280, now.subtract(const Duration(minutes: 30))),
      Fix(37.7258, -119.5413, 5, 1400, now),
    ];
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SizedBox.expand(child: Topo3DViewport(breadcrumbs: crumbs, compass: c)),
      ),
    ));
    await tester.pump();
    expect(find.textContaining('3D PITCH'), findsOneWidget);
    c.dispose();
  });
}
