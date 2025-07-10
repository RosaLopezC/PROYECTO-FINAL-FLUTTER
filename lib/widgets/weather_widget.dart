import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  Weather? weather;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    try {
      final weatherData = await WeatherService().getWeather('Lima');
      setState(() {
        weather = weatherData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  String _translateDescription(String description) {
    final translations = {
      'sunny': 'soleado',
      'clear': 'despejado',
      'cloudy': 'nublado',
      'overcast': 'muy nublado',
      'rainy': 'lluvioso',
      'stormy': 'tormentoso',
      'snowy': 'nevado',
      'clear sky': 'cielo despejado',
      'few clouds': 'pocas nubes',
      'scattered clouds': 'nubes dispersas',
      'broken clouds': 'muy nublado',
      'shower rain': 'lluvia ligera',
      'rain': 'lluvia',
      'thunderstorm': 'tormenta',
      'snow': 'nieve',
      'mist': 'neblina',
    };
    
    return translations[description.toLowerCase()] ?? description;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    }

    if (weather == null) {
      return SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              _getWeatherIcon(weather!.description),
              color: Colors.white,
              size: 24,
            ),
          ),
          
          SizedBox(width: 16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${weather!.temperature.round()}°C',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _translateDescription(weather!.description).toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                weather!.cityName,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Text(
                '💧 ${weather!.humidity.round()}%',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(String description) {
    final desc = description.toLowerCase();
    if (desc.contains('sun') || desc.contains('clear')) {
      return Icons.wb_sunny;
    } else if (desc.contains('cloud')) {
      return Icons.cloud;
    } else if (desc.contains('rain')) {
      return Icons.water_drop;
    } else if (desc.contains('snow')) {
      return Icons.ac_unit;
    } else if (desc.contains('storm')) {
      return Icons.flash_on;
    } else {
      return Icons.wb_cloudy;
    }
  }
}