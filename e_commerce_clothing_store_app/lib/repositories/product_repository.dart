import 'package:http/http.dart' as http;

class ProductRepository {
  final String baseUrl;
  final http.Client client;

  ProductRepository({
    required this.baseUrl,
    required this.client,
  });
}
