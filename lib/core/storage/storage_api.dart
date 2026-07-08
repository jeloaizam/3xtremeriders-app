import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_api.g.dart';

/// Uploads files to Firebase Storage and returns their public download URL.
/// Used for spot photos/videos — the backend only ever stores a URL
/// (`Photo.url`/`Video.url`), it never touches the file itself.
class StorageApi {
  Future<String> uploadFile({required String path, required File file}) async {
    final ref = FirebaseStorage.instance.ref(path);
    await ref.putFile(file);
    return ref.getDownloadURL();
  }
}

@riverpod
StorageApi storageApi(Ref ref) => StorageApi();
