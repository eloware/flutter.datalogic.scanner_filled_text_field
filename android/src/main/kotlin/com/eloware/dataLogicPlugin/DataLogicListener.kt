package com.eloware.scanner_filled_text_field

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel

/** ScannerFilledTextFieldPlugin */
class ScannerFilledTextFieldPlugin : FlutterPlugin, BroadcastReceiver() {
    companion object {
        lateinit var eventChannel: EventChannel
        lateinit var sink: EventChannel.EventSink
    }

    override fun onReceive(context: Context, intent: Intent) {
        if (!intent.hasCategory("com.datalogic.decodewedge.decode_category"))
            return;

        val payload = intent.getStringExtra("com.datalogic.decode.intentwedge.barcode_string")
        print(payload)
        sink.success(payload)
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        eventChannel = EventChannel(binding.binaryMessenger, "com.eloware.messcanner.barcodeReceived")
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        eventChannel.setStreamHandler(null)
    }
}
