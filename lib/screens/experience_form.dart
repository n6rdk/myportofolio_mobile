import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _ExperienceName = "";
  String _description = "";
  String _category = "Volunteer"; // default
  String _yearStarted = "";
  String _yearEnded = "";

  final List<String> _categories = [
    'Internship',
    'Research',
    'Volunteer',
    'Part-Time',
    'Full-Time',
    'Freelance',
    'Competition',
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Experience Form',
          ),
        ),
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
              // === Experience Name ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Experience Name",
                    labelText: "Experience Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _ExperienceName = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Experience name cannot be empty!";
                    }
                    return null;
                  },
                ),
              ),

              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Experience Description",
                    labelText: "Experience Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Experience description cannot be empty!";
                    }
                    return null;
                  },
                ),
              ),

              // === Category ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Experience Category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  initialValue: _category,
                  items: _categories
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),

              // === Year Started ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Year Started",
                    hintText: "2021",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  onChanged: (value) => _yearStarted = value,
                  validator: (value) {
                    final year = int.tryParse(value ?? "");
                    if (year == null || (value?.length ?? 0) != 4) {
                      return "Enter a valid start year (YYYY).";
                    }
                    return null;
                  },
                ),
              ),

              // === Year Ended ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Year Ended (leave empty if ongoing)",
                    hintText: "2026",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  onChanged: (value) => _yearEnded = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) return null;

                    final endYear = int.tryParse(value);
                    final startYear = int.tryParse(_yearStarted);
                    if (endYear == null || value.length != 4) {
                      return "Enter a valid end year (YYYY).";
                    }
                    if (startYear != null && endYear < startYear) {
                      return "End year must be after start year.";
                    }
                    return null;
                  },
                ),
              ),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(colors.primary),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Experience added successfully!'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Experience Name: $_ExperienceName'),
                                      Text('Description: $_description'),
                                      Text('Category: $_category'),
                                      Text('Year Started: $_yearStarted'),
                                      Text(
                                        'Year Ended: ${_yearEnded.isEmpty ? "Ongoing" : _yearEnded}',
                                      ),
                                    ],
                                  ),
                                ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(color: colors.onSurface),
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
