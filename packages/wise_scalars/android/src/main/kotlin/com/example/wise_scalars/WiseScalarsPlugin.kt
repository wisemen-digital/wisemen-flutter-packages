package com.example.wise_scalars

import android.content.Context
import android.icu.util.LocaleData
import android.icu.util.LocaleData.MeasurementSystem
import android.icu.util.ULocale
import android.os.Build
import androidx.core.text.util.LocalePreferences
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.text.format.DateFormat
import java.text.SimpleDateFormat
import java.util.Locale

class WiseScalarsPlugin :
    FlutterPlugin,
    MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var applicationContext: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "wise_scalars")
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getTemperatureUnit" -> result.success(getTemperatureUnits())
            "getUsesMetricSystemForDistance" -> result.success(getUsesMetricSystemForDistance())
            "getDateFormatStyles" -> result.success(getDateFormatStyles())
            "getFirstDayOfWeek" -> result.success(getFirstDayOfWeek())
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun getTemperatureUnits(): String {
        return LocalePreferences.getTemperatureUnit()
    }

    private fun getUsesMetricSystemForDistance(): Boolean? {
        val locale = ULocale.getDefault()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.BAKLAVA) {
            return when (locale.getUnicodeLocaleType("ms")) {
                "metric" -> true
                "ussystem" -> false
                "uksystem" -> false
                else -> null
            }
        }
        return when (LocaleData.getMeasurementSystem(locale)) {
            MeasurementSystem.SI -> true
            MeasurementSystem.UK -> false
            MeasurementSystem.US -> false
            else -> null
        }
    }

    private fun getDateFormatStyles(): Map<String, String> {
        val shortFormat = DateFormat.getDateFormat(applicationContext)
        val mediumFormat = DateFormat.getMediumDateFormat(applicationContext)
        val longFormat = DateFormat.getLongDateFormat(applicationContext)
        val fullFormat = java.text.DateFormat.getDateInstance(java.text.DateFormat.FULL, applicationContext.resources.configuration.locale)
        val timeFormat = DateFormat.getTimeFormat(applicationContext)

        return mapOf(
            "short" to (shortFormat as SimpleDateFormat).toLocalizedPattern(),
            "medium" to (mediumFormat as SimpleDateFormat).toLocalizedPattern(),
            "long" to (longFormat as SimpleDateFormat).toLocalizedPattern(),
            "full" to (fullFormat as SimpleDateFormat).toLocalizedPattern(),
            "time" to (timeFormat as SimpleDateFormat).toLocalizedPattern(),
        )
    }

    private fun getFirstDayOfWeek(): Int? {
        return when (LocalePreferences.getFirstDayOfWeek(Locale.getDefault())) {
            "sun" -> 7
            "mon" -> 1
            "tue" -> 2
            "wed" -> 3
            "thu" -> 4
            "fri" -> 5
            "sat" -> 6
            else -> null
        }
    }
}
