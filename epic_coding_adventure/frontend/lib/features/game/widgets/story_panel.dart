import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class StoryPanel extends StatelessWidget {
  final String title;
  final String description;
  final String output;

  const StoryPanel({
    super.key,
    required this.title,
    required this.description,
    required this.output,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1518531933037-9a62bf0d0194?q=80&w=2071&auto=format&fit=crop'), // Placeholder Jungle
          fit: BoxFit.cover,
          opacity: 0.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: GoogleFonts.cinzel(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4CAF50),
              letterSpacing: 2,
              shadows: [
                const Shadow(color: Colors.greenAccent, blurRadius: 10),
              ],
            ),
          ).animate().fadeIn().slideX(),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                description,
                style: GoogleFonts.lora(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.6,
                ),
              ).animate().fadeIn(delay: 300.ms),
            ),
          ),
          const SizedBox(height: 16),
          // Output Console
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF121212),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF333333)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.terminal, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      "TERMINAL OUTPUT",
                      style: GoogleFonts.sourceCodePro(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(color: Color(0xFF333333)),
                Text(
                  output.isEmpty ? "> Waiting for spell..." : output,
                  style: GoogleFonts.sourceCodePro(
                    color: output.contains("[ERROR]") ? Colors.redAccent : Colors.greenAccent,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2),
        ],
      ),
    );
  }
}
