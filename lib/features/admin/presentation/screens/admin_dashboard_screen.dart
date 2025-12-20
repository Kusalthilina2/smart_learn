import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/gradient_background.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.go('/home'),
          ),
        ],
      ),
      body: GradientBackground(
        child: GridView.count(
          padding: const EdgeInsets.all(24),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _AdminTile(
              icon: Icons.subject,
              label: 'Manage Subjects',
              onTap: () => context.push('/admin/subjects'),
            ),
            _AdminTile(
              icon: Icons.quiz,
              label: 'Manage Quizzes',
              onTap: () => context.push('/admin/quizzes'),
            ),
            _AdminTile(
              icon: Icons.menu_book,
              label: 'Manage Stories',
              onTap: () => context.push('/admin/stories'),
            ),
            _AdminTile(
              icon: Icons.style,
              label: 'Manage Flashcards',
              onTap: () => context.push('/admin/flashcards'),
            ),
            _AdminTile(
              icon: Icons.video_library,
              label: 'Manage Videos',
              onTap: () => context.push('/admin/videos'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AdminTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Theme.of(context).primaryColor),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
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
