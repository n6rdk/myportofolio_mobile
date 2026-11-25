import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _techStack = '';
  String _projectUrl = '';
  String _projectImageUrl = '';
  bool _isSubmitting = false;

  String? _validateUrl(String? value, {bool optional = false}) {
    final url = value?.trim() ?? '';
    if (url.isEmpty) return optional ? null : 'Please enter a project URL.';
    final uri = Uri.tryParse(url);
    if (uri == null ||
        !uri.hasAuthority ||
        uri.host.isEmpty ||
        (uri.scheme != 'http' && uri.scheme != 'https')) {
      return 'Enter a valid URL starting with http:// or https://.';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _isSubmitting) return;

    if (!await ensureLoggedIn(context) || !mounted) return;
    final authState = context.read<AuthState>();
    final token = authState.token;
    if (token == null) return;

    setState(() => _isSubmitting = true);
    final newProject = Project(
      title: _title.trim(),
      description: _description.trim(),
      techStack: _techStack.trim(),
      projectUrl: _projectUrl.trim(),
      projectImageUrl: _projectImageUrl.trim(),
    );

    try {
      await context.read<ApiClient>().createProject(newProject, token: token);
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Project added successfully!'),
          content: Text('"${newProject.title}" has been created.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (!mounted) return;
      _formKey.currentState!.reset();
      setState(() {
        _title = '';
        _description = '';
        _techStack = '';
        _projectUrl = '';
        _projectImageUrl = '';
      });
    } on ApiException catch (error) {
      if (!mounted) return;
      if (error.statusCode == 401) {
        await authState.logout();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Session expired. Please log in again.'),
          ),
        );
        final didLogIn = await ensureLoggedIn(context);
        if (didLogIn && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please submit the project again.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not add project (${error.statusCode}).'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  InputDecoration _decoration(String label, {String? hint}) => InputDecoration(
    labelText: label,
    hintText: hint,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(27)),
  );

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Project Form'),
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: _decoration('Title'),
                onChanged: (value) => _title = value,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Title cannot be empty.'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                maxLines: 5,
                decoration: _decoration('Description'),
                onChanged: (value) => _description = value,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Description cannot be empty.'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: _decoration('Tech Stack'),
                onChanged: (value) => _techStack = value,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Tech Stack cannot be empty.'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.url,
                decoration: _decoration('Project URL'),
                onChanged: (value) => _projectUrl = value,
                validator: _validateUrl,
              ),
              const SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.url,
                decoration: _decoration('Project Image URL (Optional)'),
                onChanged: (value) => _projectImageUrl = value,
                validator: (value) => _validateUrl(value, optional: true),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(colors.primary),
                ),
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text('Save', style: TextStyle(color: colors.onPrimary)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
