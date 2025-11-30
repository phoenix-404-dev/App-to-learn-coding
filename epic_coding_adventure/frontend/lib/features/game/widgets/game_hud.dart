import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameHUD extends StatelessWidget {
  final int level;
  final int xp;
  final int maxXp;
  final int hp;
  final int maxHp;
  final int mana;
  final int maxMana;

  const GameHUD({
    super.key,
    required this.level,
    required this.xp,
    required this.maxXp,
    required this.hp,
    required this.maxHp,
    required this.mana,
    required this.maxMana,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E).withOpacity(0.9),
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Level Indicator
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Center(
              child: Text(
                '$level',
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Stats Bars
          Expanded(
            child: Column(
              children: [
                _buildBar(
                  label: "HP",
                  value: hp,
                  max: maxHp,
                  color: Colors.redAccent,
                  icon: Icons.favorite,
                ),
                const SizedBox(height: 4),
                _buildBar(
                  label: "MANA",
                  value: mana,
                  max: maxMana,
                  color: Colors.blueAccent,
                  icon: Icons.bolt,
                ),
                const SizedBox(height: 4),
                _buildBar(
                  label: "XP",
                  value: xp,
                  max: maxXp,
                  color: Colors.amber,
                  icon: Icons.star,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar({
    required String label,
    required int value,
    required int max,
    required Color color,
    required IconData icon,
  }) {
    final double percentage = value / max;
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: 8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: [
                  Container(color: Colors.grey[800]),
                  FractionallySizedBox(
                    widthFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.6),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$value/$max',
          style: GoogleFonts.sourceCodePro(
            fontSize: 10,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }
}
