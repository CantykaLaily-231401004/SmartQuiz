import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/back_button_widget.dart';
import '../config/theme.dart';
import '../widgets/gradient_background.dart';
import '../widgets/blob_decoration.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String _selectedCategory = 'Semua';

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: GradientBackground(
        child: Consumer<QuizProvider>(
          builder: (context, provider, _) {
            final filteredLeaderboard = _selectedCategory == 'Semua'
                ? provider.leaderboard
                : provider.leaderboard
                    .where((result) => result.category == _selectedCategory)
                    .toList();

            return SafeArea(
              child: Stack(
                children: [
                  // Blob Decorations
                  Positioned(
                    top: -50,
                    right: -50,
                    child: BlobDecoration(
                      size: 200,
                      color: isDarkMode
                          ? const Color.fromRGBO(33, 150, 243, 0.1)
                          : const Color.fromRGBO(255, 255, 255, 0.2),
                    ),
                  ),
                  Positioned(
                    bottom: -80,
                    left: -60,
                    child: BlobDecoration(
                      size: 250,
                      color: isDarkMode
                          ? const Color.fromRGBO(63, 81, 181, 0.1)
                          : const Color.fromRGBO(255, 255, 255, 0.15),
                    ),
                  ),
                  Column(
                    children: [
                      // Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 24),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? const Color.fromRGBO(39, 39, 58, 0.5)
                              : const Color(0xFF4A70A9),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Row(
                          children: [
                            BackButtonWidget(),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Papan Peringkat',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ThemeToggle(),
                          ],
                        ),
                      ),

                      // Category filter
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: Row(
                          children: [
                            _buildCategoryChip('Semua'),
                            const SizedBox(width: 8),
                            _buildCategoryChip('Matematika'),
                            const SizedBox(width: 8),
                            _buildCategoryChip('Pengetahuan Umum'),
                          ],
                        ),
                      ),

                      // Leaderboard list
                      Expanded(
                        child: filteredLeaderboard.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.emoji_events_outlined,
                                      size: 80,
                                      color: isDarkMode
                                          ? Colors.white24
                                          : Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Belum ada data',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: isDarkMode
                                            ? Colors.white54
                                            : Colors.grey[600],
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Selesaikan kuis untuk muncul di sini',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isDarkMode
                                            ? Colors.white38
                                            : Colors.grey[500],
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                itemCount: filteredLeaderboard.length,
                                itemBuilder: (context, index) {
                                  final result = filteredLeaderboard[index];
                                  final rank = index + 1;

                                  return Dismissible(
                                    key: Key(
                                        '${result.playerName}_${result.completedAt.millisecondsSinceEpoch}'),
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.only(right: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    confirmDismiss: (direction) async {
                                      return await showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          backgroundColor: isDarkMode
                                              ? AppTheme.darkCard
                                              : Colors.white,
                                          title: Text(
                                            'Hapus Data',
                                            style: TextStyle(
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          content: Text(
                                            'Yakin ingin menghapus data ini?',
                                            style: TextStyle(
                                              color: isDarkMode
                                                  ? Colors.white70
                                                  : Colors.black87,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(ctx, false),
                                              child: const Text('Batal'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(ctx, true),
                                              child: const Text(
                                                'Hapus',
                                                style:
                                                    TextStyle(color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    onDismissed: (direction) {
                                      provider.removeFromLeaderboard(
                                        filteredLeaderboard.indexOf(result),
                                        _selectedCategory,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Data ${result.playerName} dihapus'),
                                          action: SnackBarAction(
                                            label: 'BATAL',
                                            onPressed: () {},
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 12),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: isDarkMode
                                            ? AppTheme.darkCard
                                            : Colors.white,
                                        borderRadius: 
                                            BorderRadius.circular(10),
                                        border: rank <= 3
                                            ? Border.all(
                                                color: _getRankColor(rank),
                                                width: 2,
                                              )
                                            : null,
                                        boxShadow: const [
                                          BoxShadow(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.1),
                                            blurRadius: 8,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          // Rank badge
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: _getRankColor(rank),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: rank <= 3
                                                  ? const Icon(
                                                      Icons.emoji_events,
                                                      color: Colors.white,
                                                      size: 24,
                                                    )
                                                  : Text(
                                                      '$rank',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          // Player info
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  result.playerName,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                    color: isDarkMode
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    Text(
                                                      result.category,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: isDarkMode
                                                            ? AppTheme.accentBlue
                                                            : const Color(
                                                                0xFF4A70A9),
                                                        fontFamily: 'Poppins',
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      '• ${_formatDate(result.completedAt)}',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: isDarkMode
                                                            ? Colors.white54
                                                            : Colors.grey[600],
                                                        fontFamily: 'Poppins',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Score
                                          Column(
                                            children: [
                                              Text(
                                                '${result.score}/${result.totalQuestions}',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                  color: isDarkMode
                                                      ? AppTheme.accentBlue
                                                      : const Color(
                                                          0xFF4A70A9),
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                              Text(
                                                '${result.percentage.toStringAsFixed(0)}%',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: isDarkMode
                                                      ? Colors.white54
                                                      : Colors.grey[600],
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isSelected = _selectedCategory == category;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDarkMode ? AppTheme.accentBlue : const Color(0xFF4A70A9))
              : (isDarkMode ? AppTheme.darkButton : Colors.grey[300]),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : (isDarkMode ? Colors.white70 : Colors.black),
            fontSize: 12,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return const Color(0xFFFFD700); // Gold
      case 2:
        return const Color(0xFFC0C0C0); // Silver
      case 3:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
