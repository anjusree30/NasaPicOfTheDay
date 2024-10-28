// test/presentation/astronomy_picture_day_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:nasa_pictures/presentation/astronomy_picture_day.dart';
import 'package:video_player/video_player.dart'; 

void main() {
 testWidgets('Astronomy Picture Widget shows CircularProgressIndicator when loading', (WidgetTester tester) async {
  // Arrange: Pump the widget into the widget tree
  await tester.pumpWidget(MaterialApp(home: AstronomyPictureDay()));

  // Act: Allow the FutureBuilder to build and settle
  await tester.pump(); // Initial pump to start loading
  await tester.pumpAndSettle(); // Wait for animations to complete

  // Assert: CircularProgressIndicator should be found while data is loading
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});

  testWidgets('Astronomy Picture Widget displays image when data is loaded', (WidgetTester tester) async {
    // Arrange: Pump the widget into the widget tree
    await tester.pumpWidget(MaterialApp(home: AstronomyPictureDay()));

    // Act: Simulate a delay for data fetching
    await tester.pump(Duration(seconds: 2)); // Simulate loading delay

    // Assert: After loading, an Image widget should be present
    expect(find.byType(Image), findsOneWidget);
   
  });

  testWidgets('Astronomy Picture Widget displays error message when there is an error', (WidgetTester tester) async {
    // Arrange: Pump the widget into the widget tree
    await tester.pumpWidget(MaterialApp(home: AstronomyPictureDay()));

    // Act: Simulate a delay and error state
    await tester.pump(Duration(seconds: 2)); // Simulate loading delay

    // Assert: Error message should be found if an error occurs
    expect(find.text('Failed to fetch data'), findsOneWidget);
  });
}
