import 'dart:io';

/// Client-side mirror of the Firebase Storage rule size cap for
/// `spots/{spotId}/...` uploads — checked right after picking a video so
/// an oversized file is rejected with a clear message immediately, instead
/// of failing later mid-upload with Firebase's confusing
/// `storage/unauthorized` (the security rule silently rejecting the write
/// because of size, not permissions).
///
/// Must match the actual rule (`request.resource.size < 70 * 1024 * 1024`
/// for `spots/{spotId}/{mediaType}/{fileName}`) — this constant only
/// short-circuits the upload client-side, it doesn't enforce anything on
/// its own.
///
/// Only videos need this: photos are already downsized (`maxWidth: 1600`,
/// `imageQuality: 85`) before picking, which keeps them well under the
/// limit on its own.
const spotMediaMaxBytes = 70 * 1024 * 1024;

Future<bool> exceedsSpotMediaSizeLimit(String path) async {
  final length = await File(path).length();
  return length >= spotMediaMaxBytes;
}
