import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Standard banner, shown below the comment thread on a photo/video viewer
/// (`PhotoViewerScreen`/`VideoPlayerScreen`) — unlike [SpotExitInterstitial]
/// this never blocks anything, it just quietly collapses to nothing if the
/// ad fails to load or hasn't loaded yet.
class CommentsBannerAd extends StatefulWidget {
  const CommentsBannerAd({super.key});

  @override
  State<CommentsBannerAd> createState() => _CommentsBannerAdState();
}

class _CommentsBannerAdState extends State<CommentsBannerAd> {
  BannerAd? _ad;

  @override
  void initState() {
    super.initState();
    BannerAd(
      adUnitId: const String.fromEnvironment('ADMOB_COMMENTS_BANNER_UNIT_ID'),
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() => _ad = ad as BannerAd);
        },
        onAdFailedToLoad: (ad, _) => ad.dispose(),
      ),
    ).load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ad = _ad;
    if (ad == null) return const SizedBox.shrink();
    return Center(
      child: SizedBox(
        width: ad.size.width.toDouble(),
        height: ad.size.height.toDouble(),
        child: AdWidget(ad: ad),
      ),
    );
  }
}
