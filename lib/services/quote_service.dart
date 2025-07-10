import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/quote.dart';

class QuoteService {
  // Cambiamos a una API de citas en español
  static const String _baseUrl = 'https://frasedeldia.azurewebsites.net/api/phrase';
  
  Future<Quote?> getRandomQuote() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Quote(
          text: data['phrase'] ?? data['frase'] ?? '',
          author: data['author'] ?? data['autor'] ?? 'Anónimo',
        );
      }
      
      // Fallback: citas en español predefinidas
      return _getSpanishFallbackQuote();
    } catch (e) {
      print('Error fetching quote: $e');
      return _getSpanishFallbackQuote();
    }
  }
  
  Quote _getSpanishFallbackQuote() {
    final spanishQuotes = [
      Quote(
        text: "El único modo de hacer un gran trabajo es amar lo que haces.",
        author: "Steve Jobs"
      ),
      Quote(
        text: "La vida es lo que pasa mientras estás ocupado haciendo otros planes.",
        author: "John Lennon"
      ),
      Quote(
        text: "El futuro pertenece a aquellos que creen en la belleza de sus sueños.",
        author: "Eleanor Roosevelt"
      ),
      Quote(
        text: "No es lo que nos pasa, sino cómo reaccionamos a lo que nos pasa lo que importa.",
        author: "Epicteto"
      ),
      Quote(
        text: "La única forma de hacer lo imposible es creer que es posible.",
        author: "Lewis Carroll"
      ),
      Quote(
        text: "El éxito es ir de fracaso en fracaso sin perder el entusiasmo.",
        author: "Winston Churchill"
      ),
      Quote(
        text: "La educación es el arma más poderosa que puedes usar para cambiar el mundo.",
        author: "Nelson Mandela"
      ),
      Quote(
        text: "Sé tú mismo; todos los demás ya están ocupados.",
        author: "Oscar Wilde"
      ),
      Quote(
        text: "Un viaje de mil millas comienza con un solo paso.",
        author: "Lao Tzu"
      ),
      Quote(
        text: "La innovación distingue entre un líder y un seguidor.",
        author: "Steve Jobs"
      ),
      Quote(
        text: "Lo que no te mata, te hace más fuerte.",
        author: "Friedrich Nietzsche"
      ),
      Quote(
        text: "El tiempo que disfrutas perdiendo no es tiempo perdido.",
        author: "John Lennon"
      ),
      Quote(
        text: "La creatividad es la inteligencia divirtiéndose.",
        author: "Albert Einstein"
      ),
      Quote(
        text: "Haz de cada día tu obra maestra.",
        author: "John Wooden"
      ),
      Quote(
        text: "Los sueños no tienen fecha de caducidad.",
        author: "Anónimo"
      ),
    ];
    
    final random = Random();
    return spanishQuotes[random.nextInt(spanishQuotes.length)];
  }
}