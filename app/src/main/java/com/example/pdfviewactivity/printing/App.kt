package com.example.pdfviewactivity.printing

import androidx.multidex.MultiDexApplication

class App : MultiDexApplication() {
    override fun onCreate() {
        super.onCreate()
        DeviceHelper.me().init(this)
        DeviceHelper.me().bindService()

    }

    override fun onTerminate() {
        super.onTerminate()
        DeviceHelper.me().unbindService()
    }
}