package com.eloware.scanner_filled_text_field_example

import android.content.IntentFilter
import android.os.Bundle
import com.eloware.scanner_filled_text_field.BarcodeReader
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.EventChannel

class MainActivity : FlutterActivity() {
    private val _channel = "com.eloware.messcanner.barcodeReceived"
    private lateinit var barcodeReader: BarcodeReader

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        barcodeReader = BarcodeReader()

        EventChannel(flutterEngine?.dartExecutor?.binaryMessenger, _channel).setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                if (events != null) {
                    BarcodeReader.eventChannel = events

                    barcodeReader = BarcodeReader()
                    registerReceiver(barcodeReader, IntentFilter("com.datalogic.decodewedge.decode_action"))
                }
            }

            override fun onCancel(arguments: Any?) {
                unregisterReceiver(barcodeReader)
            }
        })
    }

    override fun finish() {
        unregisterReceiver(barcodeReader)
        super.finish()
    }
}
