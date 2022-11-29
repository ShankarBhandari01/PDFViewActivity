package com.example.pdfviewactivity

import androidx.multidex.MultiDexApplication
import com.example.pdfviewactivity.root_dections.RootUtil

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