import 'package:flutter/material.dart';

import '../config/brand.dart';
import '../models/instagram_post.dart';
import '../services/instagram_feed_service.dart';
import '../theme/app_theme.dart';
import '../widgets/brand_logo.dart';
import '../widgets/buttons.dart';
import '../widgets/section.dart';
import '../widgets/site_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scroll = ScrollController();
  final _keys = <String, GlobalKey>{
    'inicio': GlobalKey(),
    'produtos': GlobalKey(),
    'videos': GlobalKey(),
    'instagram': GlobalKey(),
    'contato': GlobalKey(),
  };

  List<InstagramPost> _posts = const [];
  bool _loadingFeed = true;

  @override
  void initState() {
    super.initState();
    _loadFeed();
  }

  Future<void> _loadFeed() async {
    final posts = await InstagramFeedService().fetch();
    if (!mounted) return;
    setState(() {
      _posts = posts;
      _loadingFeed = false;
    });
  }

  void _goTo(String id) {
    final key = _keys[id];
    final ctx = key?.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      alignment: 0.05,
    );
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SiteScaffold(
      onNavigate: _goTo,
      child: SingleChildScrollView(
        controller: _scroll,
        child: Column(
          children: [
            KeyedSubtree(key: _keys['inicio'], child: const _Hero()),
            const _Benefits(),
            KeyedSubtree(key: _keys['produtos'], child: const _Products()),
            const _HowItWorks(),
            KeyedSubtree(key: _keys['videos'], child: const _Videos()),
            KeyedSubtree(
              key: _keys['instagram'],
              child: _Instagram(posts: _posts, loading: _loadingFeed),
            ),
            KeyedSubtree(key: _keys['contato'], child: const _Contact()),
            const _Footer(),
          ],
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    final image = ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: AspectRatio(
        aspectRatio: wide ? 0.92 : 4 / 5,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&w=1400&q=80',
              fit: BoxFit.cover,
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0x66000000)],
                ),
              ),
            ),
            const Positioned(
              left: 20,
              bottom: 20,
              child: Text(
                'Brilho de salão.\nCutícula selada.',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'JI PEIXOTO PROFESSIONAL  ·  #EuAmoLisoEspelhado',
          style: TextStyle(
            color: AppColors.rose,
            letterSpacing: 2.4,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          Brand.headline,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: wide ? 64 : 42,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          Brand.description,
          style: const TextStyle(
            color: AppColors.muted,
            height: 1.6,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            BlackButton(
              label: 'Ver produtos',
              icon: Icons.auto_awesome,
              onTap: () {
                final state = context.findAncestorStateOfType<_HomePageState>();
                state?._goTo('produtos');
              },
            ),
            RoseButton(
              label: 'Falar no WhatsApp',
              icon: Icons.chat_bubble_outline,
              filled: false,
              onTap: () => openUrl(Brand.whatsappUrl),
            ),
            RoseButton(
              label: 'Instagram',
              icon: Icons.camera_alt_outlined,
              filled: false,
              onTap: () => openUrl(Brand.instagramUrl),
            ),
          ],
        ),
      ],
    );

    return ColoredBox(
      color: AppColors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Padding(
            padding: EdgeInsets.fromLTRB(wide ? 48 : 20, 48, wide ? 48 : 20, 24),
            child: wide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 6, child: copy),
                      const SizedBox(width: 48),
                      Expanded(flex: 5, child: image),
                    ],
                  )
                : Column(
                    children: [
                      copy,
                      const SizedBox(height: 28),
                      image,
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _Benefits extends StatelessWidget {
  const _Benefits();

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.auto_awesome, 'Cabelos lisos', 'Selante A do Kit Liso Espelhado.'),
      (Icons.favorite_outline, 'Cabelos saudáveis', 'Passo B trata a fibra.'),
      (Icons.wb_sunny_outlined, 'Cabelos brilhantes',
          'Cauty Liss C fecha o reflexo.'),
    ];
    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: AppColors.line)),
        color: AppColors.offWhite,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: LayoutBuilder(
              builder: (context, c) {
                final row = c.maxWidth > 720;
                final children = [
                  for (final item in items)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Icon(item.$1, color: AppColors.rose),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.$2,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700)),
                                  Text(item.$3,
                                      style: const TextStyle(
                                          color: AppColors.muted, fontSize: 13)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ];
                return row
                    ? Row(children: children)
                    : Column(children: children);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Product {
  final String name;
  final String role;
  final String text;
  final Color color;
  const _Product(this.name, this.role, this.text, this.color);
}

class _Products extends StatelessWidget {
  const _Products();

  static const items = [
    _Product(
      'Espelhado Selante A',
      'Kit profissional · passo A',
      'Selante do Kit Liso Espelhado. Alinha os fios e inicia o efeito espelhado — hidratação pensada para todos os tipos de cabelo.',
      Color(0xFFE2187A),
    ),
    _Product(
      'Espelhado B',
      'Kit profissional · passo B',
      'O passo da saúde no kit. Trata o fio depois do selante para o liso ficar maleável e duradouro.',
      Color(0xFFC2185B),
    ),
    _Product(
      'Cauty Liss C',
      'Kit profissional · passo C',
      'O passo do brilho. Fecha o Kit Liso Espelhado com reflexo intenso e aspecto de salão.',
      Color(0xFFFF4DA0),
    ),
    _Product(
      'Shampoo Caviar Premium',
      'Home care · 500 ml',
      'Hydrat Intensive. Limpa e hidrata no dia a dia sem apagar o liso do procedimento.',
      Color(0xFFB0105C),
    ),
    _Product(
      'Condicionador Caviar Premium',
      'Home care · 500 ml',
      'Hydrat Intensive. Desembaraça e devolve maciez após o shampoo da mesma linha.',
      Color(0xFF9F1259),
    ),
    _Product(
      'Máscara Caviar Premium',
      'Home care · 300 g',
      'Hydrat Intensive. Tratamento intensivo para manter brilho e hidratação entre as visitas ao salão.',
      Color(0xFF7A0E45),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Section(
      eyebrow: 'A linha',
      title: 'Kit Liso Espelhado + home care',
      subtitle:
          'Se você quer cabelos lisos, saudáveis e brilhantes: Selante A, Espelhado B e Cauty Liss C no salão. Em casa, a linha Hydrat Intensive Caviar Premium (shampoo, condicionador e máscara).',
      child: LayoutBuilder(
        builder: (context, c) {
          final cols = c.maxWidth > 900
              ? 3
              : c.maxWidth > 600
                  ? 2
                  : 1;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: cols == 1 ? 1.35 : 0.72,
            ),
            itemBuilder: (context, i) {
              final p = items[i];
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.line),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 110,
                      decoration: BoxDecoration(
                        color: p.color,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'JP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      p.role.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.rose,
                        fontSize: 11,
                        letterSpacing: 1.4,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(p.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        p.text,
                        style: const TextStyle(
                            color: AppColors.muted, height: 1.45),
                      ),
                    ),
                    RoseButton(
                      label: 'Pedir no WhatsApp',
                      compact: true,
                      onTap: () => openUrl(
                        'https://wa.me/${Brand.whatsappNumber}?text=${Uri.encodeComponent('Quero o produto ${p.name}')}',
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _HowItWorks extends StatelessWidget {
  const _HowItWorks();

  @override
  Widget build(BuildContext context) {
    const steps = [
      ('A', 'Selante', 'Espelhado Selante A alinha o fio e abre o efeito liso.'),
      ('B', 'Tratamento', 'Espelhado B cuida da fibra para o liso ficar saudável.'),
      ('C', 'Brilho', 'Cauty Liss C sela o reflexo espelhado.'),
      ('+', 'Home care', 'Caviar Premium mantém hidratação e brilho em casa.'),
    ];
    return Section(
      background: AppColors.offWhite,
      eyebrow: 'Como funciona',
      title: 'Do salão ao espelho',
      subtitle:
          'A proposta da marca é simples de explicar e exigente de executar: liso duradouro com reflexo de vidro.',
      child: LayoutBuilder(
        builder: (context, c) {
          final cols = c.maxWidth > 800 ? 4 : 2;
          return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: cols,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.15,
            children: [
              for (final s in steps)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.line),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.$1,
                          style: const TextStyle(
                              color: AppColors.rose,
                              fontWeight: FontWeight.w800,
                              fontSize: 22)),
                      const Spacer(),
                      Text(s.$2,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18)),
                      const SizedBox(height: 8),
                      Text(s.$3,
                          style: const TextStyle(color: AppColors.muted)),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _Videos extends StatelessWidget {
  const _Videos();

  @override
  Widget build(BuildContext context) {
    return Section(
      eyebrow: 'Resultados em movimento',
      title: 'Vídeos',
      subtitle:
          'Demonstrações reais do Liso Espelhado. Clique para assistir no YouTube.',
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          for (final video in Brand.youtubeVideos)
            SizedBox(
              width: 360,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => openUrl(video.watchUrl),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.network(video.thumbnail, fit: BoxFit.cover),
                          ),
                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              color: AppColors.rose,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.play_arrow,
                                color: Colors.white, size: 36),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(video.title,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  Text(video.subtitle,
                      style: const TextStyle(color: AppColors.muted)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Instagram extends StatelessWidget {
  final List<InstagramPost> posts;
  final bool loading;

  const _Instagram({required this.posts, required this.loading});

  @override
  Widget build(BuildContext context) {
    final live = Brand.beholdFeedUrl.trim().isNotEmpty;
    return Section(
      background: AppColors.offWhite,
      eyebrow: 'Feed vivo',
      title: 'Instagram da marca',
      subtitle: live
          ? 'O que entra no @${Brand.instagramHandle} aparece aqui automaticamente — sem painel e sem backend.'
          : 'Pré-visualização do feed. Conecte o Behold.so em lib/config/brand.dart para espelhar o Instagram real.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              RoseButton(
                label: 'Seguir @${Brand.instagramHandle}',
                icon: Icons.camera_alt_outlined,
                onTap: () => openUrl(Brand.instagramUrl),
              ),
              if (!live)
                const Text(
                  'Modo demonstração',
                  style: TextStyle(color: AppColors.muted),
                ),
            ],
          ),
          const SizedBox(height: 24),
          if (loading)
            const Center(child: CircularProgressIndicator(color: AppColors.rose))
          else
            LayoutBuilder(
              builder: (context, c) {
                final cols = c.maxWidth > 900
                    ? 3
                    : c.maxWidth > 560
                        ? 2
                        : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: posts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cols,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.82,
                  ),
                  itemBuilder: (context, i) {
                    final post = posts[i];
                    return InkWell(
                      onTap: () => openUrl(
                        post.permalink.isEmpty
                            ? Brand.instagramUrl
                            : post.permalink,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(post.imageUrl, fit: BoxFit.cover),
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Color(0xAA111111)],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 14,
                              right: 14,
                              bottom: 14,
                              child: Text(
                                post.caption,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  height: 1.3,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}

class _Contact extends StatelessWidget {
  const _Contact();

  @override
  Widget build(BuildContext context) {
    return Section(
      eyebrow: 'Fale com a marca',
      title: 'Contato',
      subtitle:
          'Pedidos, representantes e dúvidas sobre o Liso Espelhado. O caminho mais rápido é o WhatsApp.',
      child: LayoutBuilder(
        builder: (context, c) {
          final wide = c.maxWidth > 720;
          final card = Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Atendimento',
                  style: TextStyle(color: AppColors.roseSoft, letterSpacing: 1.6),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Quer o liso espelhado no seu salão ou em casa?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  Brand.city,
                  style: const TextStyle(color: Color(0xFFD6D3D1)),
                ),
                Text(
                  Brand.email,
                  style: const TextStyle(color: Color(0xFFD6D3D1)),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    RoseButton(
                      label: 'Abrir WhatsApp',
                      icon: Icons.chat_bubble_outline,
                      onTap: () => openUrl(Brand.whatsappUrl),
                    ),
                    RoseButton(
                      label: 'Abrir Instagram',
                      icon: Icons.camera_alt_outlined,
                      filled: false,
                      onTap: () => openUrl(Brand.instagramUrl),
                    ),
                  ],
                ),
              ],
            ),
          );

          final details = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _InfoLine(Icons.place_outlined, 'Origem', Brand.city),
              const SizedBox(height: 16),
              const _InfoLine(Icons.chat_bubble_outline, 'WhatsApp',
                  'Resposta direta da equipe comercial'),
              const SizedBox(height: 16),
              _InfoLine(Icons.camera_alt_outlined, 'Instagram',
                  '@${Brand.instagramHandle}'),
              const SizedBox(height: 16),
              const _InfoLine(Icons.auto_awesome, 'Conteúdo do site',
                  'Atualizado pelas postagens do Instagram'),
            ],
          );

          return wide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: card),
                    const SizedBox(width: 28),
                    Expanded(child: details),
                  ],
                )
              : Column(
                  children: [
                    card,
                    const SizedBox(height: 24),
                    details,
                  ],
                );
        },
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoLine(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.rose),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 15)),
              Text(value, style: const TextStyle(color: AppColors.muted)),
            ],
          ),
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const BrandLogo(height: 64),
              ),
              const SizedBox(height: 12),
              const Text(
                'LISO ESPELHADO',
                style: TextStyle(
                  color: AppColors.roseSoft,
                  letterSpacing: 3,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '© ${DateTime.now().year} Ji Peixoto Professional. Todos os direitos reservados.',
                style: const TextStyle(color: Color(0xFFA8A29E), fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
