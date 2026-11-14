import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String npm = '2506593613';
  final String nama = 'Nabila Oktavia Ramadhani';
  final String kelas = 'PBP B';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final List<ItemHomepage> viewItems = [
      ItemHomepage(
        'Lihat Proyek',
        Icons.folder_outlined,
        colors.primary,
        colors.onPrimary,
        colors.onPrimary,
      ),
      ItemHomepage(
        'Lihat Skill',
        Icons.auto_awesome_outlined,
        colors.secondary,
        colors.onSecondary,
        colors.onSecondary,
      ),
      ItemHomepage(
        'Lihat Pengalaman',
        Icons.work_outline,
        colors.tertiary,
        colors.onTertiary,
        colors.onTertiary,
      ),
    ];

    final List<ItemHomepage> addItems = [
      ItemHomepage(
        'Tambah Proyek',
        Icons.add_rounded,
        colors.primary,
        colors.onSurface,
        colors.onPrimary,
        outlined: true,
      ),
      ItemHomepage(
        'Tambah Skill',
        Icons.add_rounded,
        colors.secondary,
        colors.onSurface,
        colors.onSecondary,
        outlined: true,
      ),
      ItemHomepage(
        'Tambah Pengalaman',
        Icons.add_rounded,
        colors.tertiary,
        colors.onSurface,
        colors.onTertiary,
        outlined: true,
      ),
    ];

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 16, 22, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '~/MyPortfolio',
                      style: TextStyle(
                        color: colors.primary,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(29),
                    onTap: () {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Kamu telah menekan tombol Logout!',
                            ),
                          ),
                        );
                    },
                    child: CircleAvatar(
                      radius: 29,
                      backgroundColor: colors.error.withValues(alpha: 0.18),
                      child: Icon(Icons.logout_rounded, color: colors.error),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colors.surfaceContainer,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: colors.primary,
                      child: Text(
                        nama[0].toUpperCase(),
                        style: TextStyle(color: colors.onPrimary, fontSize: 27),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r"$ whoami",
                            style: TextStyle(
                              color: colors.onSurface,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 7,
                            children: [
                              InfoCard(title: 'NPM', content: npm),
                              InfoCard(title: 'Nama', content: nama),
                              InfoCard(title: 'Kelas', content: kelas),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              Text(
                'Selamat datang di MyPortfolio Mobile!',
                style: TextStyle(
                  color: colors.onSurfaceVariant,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'View',
                style: TextStyle(
                  color: colors.onSurfaceVariant,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 14),
              GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.82,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: viewItems.map((item) => ItemCard(item)).toList(),
              ),
              const SizedBox(height: 24),
              Text(
                'Add',
                style: TextStyle(
                  color: colors.onSurfaceVariant,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 14),
              GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.82,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: addItems.map((item) => ItemCard(item)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Tooltip(
      message: title,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
        decoration: BoxDecoration(
          color: colors.secondary.withValues(alpha: 0.28),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              content,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;
  final Color textColor;
  final Color iconColor;
  final bool outlined;

  ItemHomepage(
    this.name,
    this.icon,
    this.color,
    this.textColor,
    this.iconColor, {
    this.outlined = false,
  });
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.outlined
          ? item.color.withValues(alpha: 0.18)
          : item.color,
      borderRadius: BorderRadius.circular(27),
      child: InkWell(
        borderRadius: BorderRadius.circular(27),
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Kamu telah menekan tombol ${item.name}!'),
              ),
            );
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(27),
            border: item.outlined
                ? Border.all(color: item.color, width: 1.5)
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 21,
                    backgroundColor: item.outlined
                        ? item.color
                        : item.iconColor.withValues(alpha: 0.16),
                    child: Icon(item.icon, color: item.iconColor, size: 22),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              Text(
                item.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: item.textColor,
                  fontSize: 15,
                  height: 1.25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
