import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../code_editor/code_editor_widget.dart';
import 'widgets/game_hud.dart';
import 'widgets/story_panel.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  String _code = 'print("Ssssalutations!")';
  String _output = '';
  bool _isLoading = false;
  String _selectedLanguage = 'python';

  // Game State (Mock)
  int _level = 1;
  int _xp = 0;
  final int _maxXp = 100;
  int _hp = 100;
  final int _maxHp = 100;
  int _mana = 100;
  final int _maxMana = 100;

  final Map<String, String> _defaultCode = {
    'python': 'print("Ssssalutations!")',
    'javascript': 'console.log("Hello Web")',
    'c#': 'Console.WriteLine("Shield Up");',
  };

  Future<void> _runCode() async {
    setState(() {
      _isLoading = true;
      _output = "> Casting spell in $_selectedLanguage...";
    });

    try {
      final dio = Dio();
      // Try 127.0.0.1 which is often more reliable than localhost for some setups
      final response = await dio.post(
        'http://127.0.0.1:8000/execute',
        data: {
          'code': _code,
          'language': _selectedLanguage,
        },
        options: Options(
          sendTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      );

      final data = response.data;
      setState(() {
        _output = "> ${data['output']}\n\n[${data['status'].toString().toUpperCase()}] ${data['message']}";
        if (data['status'] == 'success') {
          _xp += 50;
          if (_xp >= _maxXp) {
            _level++;
            _xp = 0;
          }
          // Heal on success
          _mana = (_mana + 10).clamp(0, _maxMana);
        } else {
          _mana = (_mana - 10).clamp(0, _maxMana);
          _hp = (_hp - 5).clamp(0, _maxHp);
        }
      });
    } catch (e) {
      setState(() {
        _output = "[SYSTEM ERROR] Connection to the Archmage lost.\n\nPossible fixes:\n1. Ensure 'start_game.bat' is running.\n2. Check if the backend terminal is open.\n3. Refresh this page.\n\nTechnical Error: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            // HUD
            GameHUD(
              level: _level,
              xp: _xp,
              maxXp: _maxXp,
              hp: _hp,
              maxHp: _maxHp,
              mana: _mana,
              maxMana: _maxMana,
            ),
            
            // Main Content Split
            Expanded(
              child: Row(
                children: [
                  // Story & Output Panel
                  Expanded(
                    flex: 5,
                    child: StoryPanel(
                      title: "Level $_level: The ${_selectedLanguage.toUpperCase()} Realm",
                      description: _getMissionDescription(),
                      output: _output,
                    ),
                  ),
                  
                  // Code Editor Area
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(left: BorderSide(color: Color(0xFF333333))),
                        color: Color(0xFF272822),
                      ),
                      child: Column(
                        children: [
                          // Editor Toolbar
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            color: const Color(0xFF1E1E1E),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Language Selector
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey[800]!),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _selectedLanguage,
                                      dropdownColor: const Color(0xFF1E1E1E),
                                      style: GoogleFonts.sourceCodePro(color: Colors.white),
                                      icon: const Icon(Icons.arrow_drop_down, color: Colors.green),
                                      items: ['python', 'javascript', 'c#'].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Row(
                                            children: [
                                              Icon(
                                                value == 'python' ? Icons.data_object : 
                                                value == 'javascript' ? Icons.javascript : Icons.code,
                                                size: 16,
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(value.toUpperCase()),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        if (newValue != null) {
                                          setState(() {
                                            _selectedLanguage = newValue;
                                            _code = _defaultCode[newValue]!;
                                            _output = "";
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                
                                // Run Button
                                ElevatedButton.icon(
                                  onPressed: _isLoading ? null : _runCode,
                                  icon: _isLoading 
                                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                      : const Icon(Icons.play_arrow),
                                  label: Text(_isLoading ? "CASTING..." : "CAST SPELL"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4CAF50),
                                    foregroundColor: Colors.white,
                                    elevation: 4,
                                    shadowColor: Colors.greenAccent.withOpacity(0.4),
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                  ),
                                ).animate(target: _isLoading ? 0 : 1).shimmer(duration: 2.seconds, delay: 1.seconds),
                              ],
                            ),
                          ),
                          // Editor
                          Expanded(
                            child: CodeEditorWidget(
                              initialCode: _code,
                              onCodeChanged: (value) {
                                _code = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMissionDescription() {
    switch (_selectedLanguage) {
      case 'python':
        return "The giant stone snake blocks your path. The Archmage whispers:\n\n'This Guardian speaks the tongue of Python. It waits for a greeting. Use the print() function to say \"Ssssalutations!\" to awaken it.'";
      case 'javascript':
        return "A digital spider weaves a web of asynchronous callbacks. It blocks the gateway to the DOM.\n\n'Log \"Hello Web\" to the console to disrupt its frequency!'";
      case 'c#':
        return "The Iron Golem stands guard. It only respects strict types and compiled orders.\n\n'Command it to raise its shield! Use Console.WriteLine(\"Shield Up\");'";
      default:
        return "Unknown Realm";
    }
  }
}
