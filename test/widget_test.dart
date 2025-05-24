import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map/main.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:mockito/mockito.dart';

class FakeGeolocatorPlatform extends Mock implements GeolocatorPlatform {}

void main() {
  final fakePlatform = FakeGeolocatorPlatform();

  setUpAll(() {
    GeolocatorPlatform.instance = fakePlatform;
    when(
      fakePlatform.getCurrentPosition(
        locationSettings: anyNamed('locationSettings'),
      ),
    ).thenAnswer(
      (_) async => Position(
        longitude: 79.8707,
        latitude: 6.9062,
        timestamp: DateTime.now(),
        accuracy: 1.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        headingAccuracy: 1.0,
        altitudeAccuracy: 1.0,
      ),
    );

    when(
      fakePlatform.checkPermission(),
    ).thenAnswer((_) async => LocationPermission.always);
    when(
      fakePlatform.requestPermission(),
    ).thenAnswer((_) async => LocationPermission.always);
  });

  testWidgets('MapScreen loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MapScreen()));
    await tester.pumpAndSettle();

    expect(find.byType(GoogleMap), findsOneWidget);
  });
}
