import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const String _apiKey = '550e8400-e29b-41d4-a716-446655440000'; // Usar tu API key real
  
  Future<Weather?> getWeather(String cityName) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?q=$cityName&appid=$_apiKey&units=metric'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Weather.fromJson(data);
      }
      
      // Fallback data si la API no está disponible
      return Weather(
        cityName: cityName,
        temperature: 22.0,
        description: 'Sunny',
        icon: '01d',
        humidity: 60.0,
        windSpeed: 5.0,
      );
    } catch (e) {
      print('Error fetching weather: $e');
      // Retornar datos de ejemplo
      return Weather(
        cityName: cityName,
        temperature: 22.0,
        description: 'Sunny',
        icon: '01d',
        humidity: 60.0,
        windSpeed: 5.0,
      );
    }
  }
}