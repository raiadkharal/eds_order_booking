package com.optimus.order_booking

import android.content.Intent
import android.os.Bundle
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity(){
    private val CHANNEL = "com.optimus.eds/autoTime"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        flutterEngine?.let {
            MethodChannel(it.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
                if (call.method == "isAutoDateTimeEnabled") {
                    val isAutoTimeEnabled = isAutoDateTimeEnabled()
                    result.success(isAutoTimeEnabled)
                }else if (call.method == "openDateTimeSettings") {
                    openDateTimeSettings()
                    result.success(null)
                }else if (call.method == "isDeveloperOptionsEnabled") {
                    val isDeveloperOptionsEnabled = isDeveloperOptionsEnabled()
                    result.success(isDeveloperOptionsEnabled)
                }
                else {
                    result.notImplemented()
                }
            }
        }
    }

    private fun isAutoDateTimeEnabled(): Boolean {
        return try {
            val autoTimeEnabled = Settings.Global.getInt(contentResolver, Settings.Global.AUTO_TIME) == 1
            val autoTimeZoneEnabled = Settings.Global.getInt(contentResolver, Settings.Global.AUTO_TIME_ZONE) == 1
            autoTimeEnabled && autoTimeZoneEnabled
        } catch (e: Settings.SettingNotFoundException) {
            false
        }
    }


    private fun isDeveloperOptionsEnabled(): Boolean {
        return try {
            Settings.Global.getInt(contentResolver, Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, 0) == 1
        } catch (e: Settings.SettingNotFoundException) {
            e.printStackTrace()
            false
        }
    }

    private fun openDateTimeSettings() {
        val intent = Intent(Settings.ACTION_DATE_SETTINGS)
        startActivity(intent)
    }

}
