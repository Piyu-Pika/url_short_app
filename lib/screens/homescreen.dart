import 'package:flutter/material.dart';
import 'package:url_short_app/models/url.dart';
import 'package:url_short_app/api/api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UrlModel> urlList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchUrls();
  }

  Future<void> fetchUrls() async {
    setState(() => _isLoading = true);
    try {
      final urls = await Api().getUrls();
      setState(() => urlList = urls);
    } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load URLs: ${e.toString()}')),
          );
        }
      print('Error fetching URLs: $e');
      } finally {
        if (context.mounted) {
          setState(() => _isLoading = false);
        }
      }
    }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open: $url')),
    );
  }
    }
  }
  
  Widget _buildAlertBox() {
    final formKey = GlobalKey<FormState>();
    final urlController = TextEditingController();

    Future<void> createShortUrl() async {
      if (!formKey.currentState!.validate()) return;
      setState(() => _isLoading = true);
      try {
        final originalUrl = urlController.text.trim();
        await Api().createShortUrl(originalUrl);
        await fetchUrls();
        if (context.mounted) {
          Navigator.of(context).pop();
  }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create short URL: ${e.toString()}')),
    );
  }
      } finally {
        if (context.mounted) {
          setState(() => _isLoading = false);
        }
      }
    }

    return AlertDialog(
      title: const Text('Create Short URL'),
      content: Form(
        key: formKey,
                      child: Column(
          mainAxisSize: MainAxisSize.min,
                        children: [
            TextFormField(
              controller: urlController,
              keyboardType: TextInputType.url,
              autofillHints: const [AutofillHints.url],
              decoration: const InputDecoration(
                labelText: 'Original URL',
                hintText: 'https://example.com',
                          ),
              validator: (value) {
                var url = value?.trim() ?? '';
                if (url.isEmpty) return 'Please enter a URL';
                if (!url.contains('://')) url = 'https://$url';
                final uri = Uri.tryParse(url);
                if (uri == null || !uri.isAbsolute) {
                  return 'Please enter a valid URL';
                }
                return null;
              },
            ),
          ],
                    ),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
      ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          icon: _isLoading
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.add_link),
          label: Text(_isLoading ? 'Creating...' : 'Create'),
          onPressed: _isLoading ? null : createShortUrl,
        ),
      ],
    );
  }

  Widget _buildUrlItem(UrlModel url) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onLongPress: () => Share.share(url.shortUrl),
        borderRadius: BorderRadius.circular(12),
        onTap: () => _launchURL(url.originalUrl),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Icon(Icons.link, color: Colors.blue, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      url.shortUrl,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${url.clicks} clicks',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                url.originalUrl,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Short Links', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchUrls,
              color: colorScheme.primary,
              child: urlList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.link_off, size: 64, color: colorScheme.primary),
                          const SizedBox(height: 16),
                          const Text('No links found', style: TextStyle(fontSize: 18)),
                          TextButton(
                            onPressed: fetchUrls,
                            child: const Text('Refresh'),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 16),
                      itemCount: urlList.length,
                      itemBuilder: (context, index) => _buildUrlItem(urlList[index]),
                    ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => _buildAlertBox(),
        ),
        icon: const Icon(Icons.add_link),
        label: const Text('New Short Link'),
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
    );
  }
}