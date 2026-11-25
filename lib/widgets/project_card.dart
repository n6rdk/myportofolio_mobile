import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.outlined ? item.color.withValues(alpha: 0.18) : item.color,
      borderRadius: BorderRadius.circular(27),
      child: InkWell(
        borderRadius: BorderRadius.circular(27),
        onTap: () async {
          if (item.name.toLowerCase().contains('logout')) {
            if (context.read<AuthState>().isLoggedIn) {
              await context.read<AuthState>().logout();
            }
            if (!context.mounted) return;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('You have logged out.')),
              );
            return;
          }

          if (item.name.toLowerCase().contains('add project')) {
            if (!await ensureLoggedIn(context) || !context.mounted) return;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProjectFormPage()),
            );
            return;
          }

          if (item.name.toLowerCase().contains('view project')) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProjectListScreen()),
            );
            return;
          }

          if (item.onTap != null) {
            item.onTap!();
            return;
          }

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text('You tapped the ${item.name} button!')),
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
                  if (item.name.toLowerCase().contains('logout'))
                    Icon(item.icon, color: item.iconColor, size: 22)
                  else
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
