import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart'; // For Markdown parsing
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AIAssistModal extends StatefulWidget {
  const AIAssistModal({super.key});

  @override
  _AIAssistModalState createState() => _AIAssistModalState();
}

class _AIAssistModalState extends State<AIAssistModal> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _chatMessages = [];
  bool _isLoading = false;

  static const _baseUrl = 'https://medacare-be.onrender.com/api/v1';

  Map<String, String> _buildHeaders(String token) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<void> _sendMessage(String message) async {
    const String url = '$_baseUrl/assistance/advice';

    try {
      final token = await _getToken();
      if (token == null || token.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must be logged in to use this feature')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
        _chatMessages.add({'sender': 'user', 'message': message});
      });

      final response = await http.post(
        Uri.parse(url),
        headers: _buildHeaders(token),
        body: message,
      );

      if (response.statusCode == 200) {
        final aiResponse = response.body;

        setState(() {
          _chatMessages.add({'sender': 'ai', 'message': aiResponse});
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String?> _getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('jwt_token');
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard on tap
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9, // Modal height
        decoration: const BoxDecoration(
          color: Colors.white, // Modal background color
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16, // Adjust for keyboard
          ),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'AI Assist',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Color(0xFF1C665E)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Chat Messages
              Expanded(
                child: ListView.builder(
                  itemCount: _chatMessages.length,
                  itemBuilder: (context, index) {
                    final message = _chatMessages[index];
                    final isUser = message['sender'] == 'user';
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        if (!isUser)
                         Stack(
  alignment: Alignment.center,
  children: [
    Image.asset(
      'assets/images/ai_back.png', // Background image
      width: 60,
      height: 60,
      fit: BoxFit.cover,
    ),
    SizedBox(
      width: 36,
      height: 36,
      child: Image.asset(
        'assets/images/ai_icon.png', // AI icon
        fit: BoxFit.contain,
      ),
    ),
  ],
),
                        if (!isUser) const SizedBox(width: 8),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isUser ? Color(0xFF38AAD4) : Color(0xFFEFF9FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: MarkdownBody(
                              data: message['message'] ?? '',
                              styleSheet: MarkdownStyleSheet(
                                p: const TextStyle(fontSize: 14),
                                strong: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        if (isUser) const SizedBox(width: 8),
                        if (isUser)
                          const CircleAvatar(
                            backgroundImage: AssetImage('assets/images/Avatar.png'),
                            radius: 16,
                          ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Input Field
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Write a symptom, we are here to help you',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send , color : Color(0xFFA55D68)),       
                    onPressed: _isLoading
                        ? null
                        : () {
                            final message = _messageController.text.trim();
                            if (message.isNotEmpty) {
                              _messageController.clear();
                              _sendMessage(message);
                            }
                          },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}