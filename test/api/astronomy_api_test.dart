import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_pictures/data/astronomy_api.dart';
import 'package:nasa_pictures/data/astronomy_response.dart';


// Annotate the file with @GenerateMocks to generate mock classes
@GenerateMocks([AstronomyApi])
import 'astronomy_api_test.mocks.dart'; // This will be generated by Mockito

void main() {
  group('Astronomy API Tests', () {
    // Create an instance of your mock API class
    late MockAstronomyApi mockApi;

    setUp(() {
      mockApi = MockAstronomyApi();
    });

    test('should fetch Astronomy Picture of the Day successfully', () async {
      // Arrange: Mock the response you expect from your API
      final mockResponse = AstronomyResponse(
        'image','https://example.com/picture.jpg','This is a description of the picture.'
        
      );

      // When the mock API's `getAstronomyPicture` is called, return the mock response
      when(mockApi.getAstronomyPicture()).thenAnswer((_) async => mockResponse);

      // Act: Call the method
      final result = await mockApi.getAstronomyPicture();

      // Assert: Check that the returned response matches the mock response
      expect(result, equals(mockResponse));
      verify(mockApi.getAstronomyPicture()).called(1);
    });
  });
}
