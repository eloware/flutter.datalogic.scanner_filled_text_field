package com.eloware.scanner_filled_text_field_example

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import android.util.Log
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.OnLifecycleEvent
import com.eloware.dataLogicPlugin.DataLogicListener
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.EventChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity(), LifecycleObserver {
    private var _barcodeReader: DataLogicListener? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this.flutterEngine!!)

        Log.v("PLUGIN", "onCreate")
        EventChannel(flutterEngine?.dartExecutor?.binaryMessenger, DataLogicListener.CHANNEL_NAME)
                .setStreamHandler(object : EventChannel.StreamHandler {

                    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                        Log.v("PLUGIN", "Registering Intent-Receiver")
                        DataLogicListener.sink = events!!
                        registerReceiver(_barcodeReader, IntentFilter("com.datalogic.decodewedge.decode_action"))
                        startBarcode()
                    }

                    override fun onCancel(arguments: Any?) {
                        unregisterReceiver(_barcodeReader)
                    }
                })
    }

    fun startBarcode() {
       DataLogicListener.active = true
    }

    private fun stopBarcode() {
        DataLogicListener.active = false
    }

    override fun finish() {
        super.finish()
        unregisterReceiver(_barcodeReader)
    }

    override fun onResume() {
        super.onResume()
        startBarcode()
    }

    override fun onPause() {
        super.onPause()
        stopBarcode()
    }

}
