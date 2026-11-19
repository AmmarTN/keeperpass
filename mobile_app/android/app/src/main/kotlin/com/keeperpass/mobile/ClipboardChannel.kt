package com.keeperpass.mobile

import android.content.ClipData
import android.content.ClipboardManager
import android.content.Context
import android.os.Build
import android.os.PersistableBundle
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import java.util.UUID

/**
 * The clipboard for KeeperPass (plan Part 14, `ClipboardService` in Dart).
 * A secret is marked sensitive, so Android 13+ keeps it out of the
 * clipboard preview; each copy carries a marker, so a clear only removes
 * what KeeperPass itself put there.
 */
class ClipboardChannel(private val context: Context) {
    fun attach(messenger: BinaryMessenger) {
        MethodChannel(messenger, CHANNEL).setMethodCallHandler { call, result ->
            val clipboard =
                context.getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
            when (call.method) {
                "copy" -> {
                    val marker = UUID.randomUUID().toString()
                    val clip = ClipData.newPlainText(LABEL, call.argument<String>("text") ?: "")
                    clip.description.extras = PersistableBundle().apply {
                        putString(EXTRA_MARKER, marker)
                        if (call.argument<Boolean>("sensitive") == true) {
                            putBoolean(EXTRA_IS_SENSITIVE, true)
                        }
                    }
                    clipboard.setPrimaryClip(clip)
                    result.success(marker)
                }
                "clearIfOurs" -> {
                    // Readable only while KeeperPass is in front (Android 10+);
                    // the Dart side never asks from the background.
                    val current = clipboard.primaryClipDescription?.extras?.getString(EXTRA_MARKER)
                    val marker = call.argument<String>("marker")
                    if (marker != null && current == marker) {
                        if (Build.VERSION.SDK_INT >= 28) {
                            clipboard.clearPrimaryClip()
                        } else {
                            clipboard.setPrimaryClip(ClipData.newPlainText("", ""))
                        }
                        result.success(true)
                    } else {
                        result.success(false)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private companion object {
        const val CHANNEL = "keeperpass/clipboard"
        const val LABEL = "KeeperPass"
        const val EXTRA_MARKER = "com.keeperpass.mobile.CLIP_MARKER"

        /** `ClipDescription.EXTRA_IS_SENSITIVE` (API 33); older versions read the same key. */
        const val EXTRA_IS_SENSITIVE = "android.content.extra.IS_SENSITIVE"
    }
}
