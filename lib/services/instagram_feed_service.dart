import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/brand.dart';
import '../models/instagram_post.dart';

/// Lê o feed público gerado pelo Behold (ou serviço equivalente).
/// Sem backend: o token do Instagram fica no Behold, o site só consome JSON.
class InstagramFeedService {
  static const _demo = <InstagramPost>[
    InstagramPost(
      id: 'demo-1',
      imageUrl:
          'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&w=900&q=80',
      permalink: 'https://www.instagram.com/${Brand.instagramHandle}/',
      caption: 'Liso espelhado recém-selado. O reflexo que virou assinatura.',
    ),
    InstagramPost(
      id: 'demo-2',
      imageUrl:
          'https://images.unsplash.com/photo-1519699047748-de8e457a634e?auto=format&fit=crop&w=900&q=80',
      permalink: 'https://www.instagram.com/${Brand.instagramHandle}/',
      caption: 'Antes e depois com o Kit Definitiva Liso Espelhado.',
    ),
    InstagramPost(
      id: 'demo-3',
      imageUrl:
          'https://images.unsplash.com/photo-1560066984-138dadb4c035?auto=format&fit=crop&w=900&q=80',
      permalink: 'https://www.instagram.com/${Brand.instagramHandle}/',
      caption: 'Bastidores no salão — aplicação profissional.',
    ),
    InstagramPost(
      id: 'demo-4',
      imageUrl:
          'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?auto=format&fit=crop&w=900&q=80',
      permalink: 'https://www.instagram.com/${Brand.instagramHandle}/',
      caption: 'Manutenção em casa: shampoo + sérum de brilho.',
    ),
    InstagramPost(
      id: 'demo-5',
      imageUrl:
          'https://images.unsplash.com/photo-1595475884562-073c30d45670?auto=format&fit=crop&w=900&q=80',
      permalink: 'https://www.instagram.com/${Brand.instagramHandle}/',
      caption: 'Linha rosa e preta. Embalagem que combina com o resultado.',
    ),
    InstagramPost(
      id: 'demo-6',
      imageUrl:
          'https://images.unsplash.com/photo-1487412947147-5cebf100ffc2?auto=format&fit=crop&w=900&q=80',
      permalink: 'https://www.instagram.com/${Brand.instagramHandle}/',
      caption: 'O brilho que o Instagram mostra — e o site replica na hora.',
    ),
  ];

  Future<List<InstagramPost>> fetch({int limit = 9}) async {
    final url = Brand.beholdFeedUrl.trim();
    if (url.isEmpty) return _demo.take(limit).toList();

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) return _demo.take(limit).toList();

      final decoded = jsonDecode(response.body);
      final rawList = decoded is List
          ? decoded
          : (decoded['posts'] ??
              decoded['data'] ??
              decoded['items'] ??
              const []);

      final posts = <InstagramPost>[];
      for (final item in rawList) {
        if (item is Map<String, dynamic>) {
          final post = InstagramPost.fromBehold(item);
          if (post.imageUrl.isNotEmpty) posts.add(post);
        } else if (item is Map) {
          final post = InstagramPost.fromBehold(Map<String, dynamic>.from(item));
          if (post.imageUrl.isNotEmpty) posts.add(post);
        }
      }
      if (posts.isEmpty) return _demo.take(limit).toList();
      return posts.take(limit).toList();
    } catch (_) {
      return _demo.take(limit).toList();
    }
  }
}
