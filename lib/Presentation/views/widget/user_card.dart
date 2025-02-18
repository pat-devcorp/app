import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final UserCardItem user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0, // Remove default elevation
      color: theme.colorScheme.surface, // Background color
      shape: RoundedRectangleBorder( // Add rounded corners
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding( // Add padding inside the card
        padding: const EdgeInsets.all(16.0),
        child: Column( // Changed to Column to add Divider
          children: [
            Row( // Use a Row to align items horizontally
              children: [
                // 1. Icon (Rounded Circle)
                CircleAvatar(
                  backgroundColor: theme.colorScheme.primaryContainer, // Example
                  foregroundColor: theme.colorScheme.onPrimaryContainer,
                  child: user.icon ?? // Use provided icon if available
                      Text(
                        user.tittle[0].toUpperCase(), // First letter if no icon
                      ),
                ),

                const SizedBox(width: 16), // Spacing between icon and details

                // 2. Account Details (Account Name, Card Number, Consumed Amount)
                Expanded( // Ensures details take available space
                  flex: 2, // Adjust flex as needed relative to other parts
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center, // Vertically center
                    children: [
                      Text(
                        user.tittle,
                        style: TextStyle(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '**** ${user.detail}',
                        style: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16), // Spacing between details and amount

                // 3. Amount and Arrow
                Expanded(
                  flex: 1, // Adjust flex as needed
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end, // Align to the right
                    children: [
                      Text(
                        user.amount,
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    ],
                  ),
                ),
              ],
            ),

            const Divider( // Add the Divider here
              height: 1, // Adjust height as needed
              thickness: 1, // Adjust thickness as needed
              color: Colors.grey, // Adjust color as needed
            ),
          ],
        ),
      ),
    );
  }
}

class UserCardItem {
  final Widget icon; // could be null
  final String tittle; // change to tittle
  final String detail; // change to detail
  final String amount;

  UserCardItem({
    required this.icon,
    required this.tittle,
    required this.detail,
    required this.amount,
  });
}