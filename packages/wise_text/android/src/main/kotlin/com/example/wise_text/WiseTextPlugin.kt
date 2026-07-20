package com.example.wise_text

import android.content.Context
import android.view.textclassifier.TextClassificationManager
import android.view.textclassifier.TextClassifier
import android.view.textclassifier.TextLinks
import androidx.annotation.Keep
import kotlinx.coroutines.*

/**
 * Wraps the platform [TextClassifier] (obtained from [TextClassificationManager]).
 * The Dart side reaches this class through the jnigen-generated bindings, so the
 * public surface is kept intentionally small: a single [classifyText] method that
 * takes a [String] and returns an [IntArray].
 *
 * Only the *detected* ranges are reported, packed as flat (start, length,
 * typeCode) triples. An int array maps cheaply across JNI to a Dart `JIntArray`
 * with no string encoding; the Dart side already holds the source text and
 * rebuilds the plain-text gaps from these offsets.
 *
 * A [Context] is required because the system text classifier is obtained from
 * [TextClassificationManager]; the Dart side supplies the cached application
 * context when constructing this object.
 */
@Keep
class WiseTextPlugin(private val context: Context) {

    /**
     * Classifies [text] and returns the detected ranges as a flat int array of
     * (start, length, typeCode) triples, sorted by start and non-overlapping.
     *
     * `typeCode` is a stable contract shared with the Dart side
     * (`WiseTextItemType.fromCode`): `0 = date, 1 = address, 2 = link,
     * 3 = phoneNumber`. Offsets are UTF-16 code-unit based, matching Dart
     * `String` indexing. On any failure an empty array is returned, which the
     * Dart side renders as a single plain-text span.
     */
    @Keep
    suspend fun classifyText(text: String): IntArray = withContext(Dispatchers.Default) {
        try {
            classify(text)
        } catch (t: Throwable) {
            IntArray(0)
        }
    }

    private fun classify(text: String): IntArray {
        if (text.isEmpty()) return IntArray(0)

        val manager = context.getSystemService(Context.TEXT_CLASSIFICATION_SERVICE)
            as? TextClassificationManager
            ?: return IntArray(0)

        val classifier = manager.textClassifier

        val request = TextLinks.Request.Builder(text)
            .setEntityConfig(
                // Restrict detection to the entity types
                TextClassifier.EntityConfig.createWithExplicitEntityList(SUPPORTED_ENTITIES),
            )
            .build()

        val links = classifier.generateLinks(request).links.sortedBy { it.start }

        val triples = ArrayList<Int>(links.size * 3)
        var cursor = 0

        for (link in links) {
            // generateLinks should not overlap, but guard against it so the
            // emitted ranges never run backwards.
            if (link.start < cursor) continue

            // Unsupported entity types are skipped; by not advancing the cursor
            // they fall into the next "text" gap on the Dart side, matching iOS
            // which only recognizes date/address/link/phoneNumber.
            val code = typeCode(link) ?: continue

            triples.add(link.start)
            triples.add(link.end - link.start)
            triples.add(code)
            cursor = link.end
        }

        return triples.toIntArray()
    }

    /** Maps a link's highest-confidence entity to a stable integer identifier. */
    private fun typeCode(link: TextLinks.TextLink): Int? {
        if (link.entityCount == 0) return null
        return when (link.getEntity(0)) {
            TextClassifier.TYPE_DATE, TextClassifier.TYPE_DATE_TIME -> 0
            TextClassifier.TYPE_ADDRESS -> 1
            TextClassifier.TYPE_URL -> 2
            TextClassifier.TYPE_EMAIL -> 3
            TextClassifier.TYPE_PHONE -> 4
            else -> null
        }
    }

    private companion object {
        val SUPPORTED_ENTITIES = listOf(
            TextClassifier.TYPE_DATE,
            TextClassifier.TYPE_DATE_TIME,
            TextClassifier.TYPE_ADDRESS,
            TextClassifier.TYPE_URL,
            TextClassifier.TYPE_EMAIL,
            TextClassifier.TYPE_PHONE,
        )
    }
}
