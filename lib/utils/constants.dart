class Constants {
  static const String appName = 'Task Manager Pro';
  static const String weatherApiKey = '550e8400-e29b-41d4-a716-446655440000';
  static const String weatherBaseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const String quotesBaseUrl = 'https://zenquotes.io/api/random';
  
  static const Map<String, String> priorityEmojis = {
    'low': '🟢',
    'medium': '🟡',
    'high': '🔴',
  };
  
  static const Map<String, String> priorityLabels = {
    'low': 'Low Priority',
    'medium': 'Medium Priority',
    'high': 'High Priority',
  };
}