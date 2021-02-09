package com.eloware.scanner_filled_text_field

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import io.flutter.plugin.common.EventChannel

/** ScannerFilledTextFieldPlugin */
class BarcodeReader : BroadcastReceiver() {
    companion object {
        lateinit var eventChannel: EventChannel.EventSink
    }

    override fun onReceive(context: Context, intent: Intent) {
        if (!intent.hasCategory("com.datalogic.decodewedge.decode_category"))
            return;

        val payload = intent.getStringExtra("com.datalogic.decode.intentwedge.barcode_string")
        eventChannel.success(payload)
    }

}