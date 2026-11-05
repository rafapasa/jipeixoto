/// Centralize aqui os dados da marca.
/// Não precisa de backend: o feed do site lê o Instagram via Behold (JSON público).
class Brand {
  static const name = 'Ji Peixoto';
  static const legalName = 'Ji Peixoto Professional';
  static const tagline = 'Liso Espelhado';
  static const campaign = '#EuAmoLisoEspelhado';
  static const headline = 'O liso que vira espelho.';
  static const subtitle =
      'Kit profissional e linha home care com o brilho da marca.';
  static const description =
      'Ji Peixoto Professional entrega o Liso Espelhado em dois momentos: '
      'o kit de salão (Selante A, Espelhado B e Cauty Liss C) para alisar, '
      'tratar e brilhar — e a linha Hydrat Intensive Caviar Premium para '
      'manter o resultado em casa. Hidratação pensada para todos os tipos de cabelo. '
      'O site acompanha o Instagram da marca.';

  /// Troque pelo WhatsApp oficial com DDI + DDD (somente números).
  static const whatsappNumber = '5549999999999';
  static const whatsappMessage =
      'Olá! Quero saber mais sobre o Liso Espelhado Ji Peixoto.';

  /// Perfil público usado nos botões e no embed.
  static const instagramHandle = 'jipeixotoprofessional';

  /// URL JSON do Behold.so (ou equivalente).
  /// 1. Crie uma conta gratuita em https://behold.so
  /// 2. Conecte o Instagram da marca
  /// 3. Cole aqui a URL do feed (ex.: https://feeds.behold.so/XXXXXXXX)
  /// Enquanto estiver vazio, o site mostra um feed de demonstração.
  static const beholdFeedUrl = '';

  /// Logo 3D gerada para o site (arquivo original VXKLm.jpg).
  static const logoAsset = 'assets/images/logo_ji_peixoto.jpg';

  static const siteHost = 'espelhadojipeixoto.com.br';
  static const siteUrl = 'https://espelhadojipeixoto.com.br';
  static const city = 'São Miguel do Oeste — SC';
  static const email = 'contato@espelhadojipeixoto.com.br';

  static const youtubeVideos = <YoutubeVideo>[
    YoutubeVideo(
      id: 'jFxP1GYsggw',
      title: 'Resultado Liso Espelhado Ji Peixoto',
      subtitle: 'Kit Definitiva em procedimento profissional',
    ),
  ];

  static String get instagramUrl =>
      'https://www.instagram.com/$instagramHandle/';

  static String get whatsappUrl {
    final text = Uri.encodeComponent(whatsappMessage);
    return 'https://wa.me/$whatsappNumber?text=$text';
  }
}

class YoutubeVideo {
  final String id;
  final String title;
  final String subtitle;

  const YoutubeVideo({
    required this.id,
    required this.title,
    required this.subtitle,
  });

  String get thumbnail => 'https://img.youtube.com/vi/$id/hqdefault.jpg';
  String get watchUrl => 'https://www.youtube.com/watch?v=$id';
  String get embedUrl => 'https://www.youtube.com/embed/$id';
}
