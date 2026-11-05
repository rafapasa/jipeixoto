class InstagramPost {
  final String id;
  final String imageUrl;
  final String permalink;
  final String caption;
  final String mediaType;
  final DateTime? timestamp;

  const InstagramPost({
    required this.id,
    required this.imageUrl,
    required this.permalink,
    required this.caption,
    this.mediaType = 'IMAGE',
    this.timestamp,
  });

  factory InstagramPost.fromBehold(Map<String, dynamic> json) {
    final media = (json['mediaUrl'] ??
            json['thumbnailUrl'] ??
            json['media_url'] ??
            json['thumbnail_url'] ??
            '')
        .toString();
    return InstagramPost(
      id: (json['id'] ?? json['mediaId'] ?? media.hashCode).toString(),
      imageUrl: media,
      permalink: (json['permalink'] ?? json['url'] ?? '').toString(),
      caption: (json['caption'] ?? json['prunedCaption'] ?? '').toString(),
      mediaType: (json['mediaType'] ?? json['media_type'] ?? 'IMAGE').toString(),
      timestamp: DateTime.tryParse((json['timestamp'] ?? '').toString()),
    );
  }
}
