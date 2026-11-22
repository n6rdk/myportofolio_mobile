import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class SkillFormPage extends StatefulWidget {
  const SkillFormPage({super.key});

  @override
  State<SkillFormPage> createState() => _SkillFormPageState();
}

class _SkillFormPageState extends State<SkillFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _category = '';
  String _techStackInput = '';

  List<String> _parseTechStack(String input) => input
      .split(',')
      .map((technology) => technology.trim())
      .where((technology) => technology.isNotEmpty)
      .toList();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Skill Form'),
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Skill Category',
                    hintText: 'e.g. Data Science',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  onChanged: (value) => _category = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Skill category cannot be empty!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  minLines: 2,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Tech Stack',
                    hintText: 'NumPy, Pandas, Matplotlib',
                    helperText: 'Separate each technology with a comma.',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  onChanged: (value) => _techStackInput = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter at least one technology.';
                    }

                    final entries = value.split(',');
                    if (entries.any((technology) => technology.trim().isEmpty)) {
                      return "Use commas between technologies; don't leave an item empty.";
                    }
                    return null;
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(colors.primary),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;

                      final List<String> techStack =
                          _parseTechStack(_techStackInput);
                      showDialog<void>(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: const Text('Skill added successfully!'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Category: ${_category.trim()}'),
                              const SizedBox(height: 8),
                              const Text('Tech Stack:'),
                              ...techStack.map((technology) => Text('- $technology')),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(dialogContext);
                                _formKey.currentState!.reset();
                                _category = '';
                                _techStackInput = '';
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: colors.onPrimary),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
