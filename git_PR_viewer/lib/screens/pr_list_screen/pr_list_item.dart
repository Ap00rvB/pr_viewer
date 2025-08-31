import 'package:flutter/material.dart';
import '../../models/pull_requests.dart';
import '../../utils/date_formatter.dart';

class PrListItem extends StatelessWidget {
  final PullRequest pr;

  const PrListItem({super.key, required this.pr});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pr.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (pr.body != null && pr.body!.isNotEmpty) ...[
              Text(
                pr.body!,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
            ],
            Text(
              'Author: ${pr.authorUsername}',
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 4),
            Text(
              'Created: ${DateFormatter.formatDateTime(pr.createdAt)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            // if (pr.htmlUrl.isNotEmpty)
            //   Align(
            //     alignment: Alignment.centerRight,
            //     child: TextButton(
            //       onPressed: () => _launchURL(pr.htmlUrl),
            //       child: const Text('View on GitHub'),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
