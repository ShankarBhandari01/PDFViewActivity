package com.example.pdfviewactivity

import android.os.Bundle
import android.os.RemoteException
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.view.animation.TranslateAnimation
import androidx.appcompat.app.AppCompatActivity
import com.example.pdfviewactivity.adapter.AdapterDetails
import com.example.pdfviewactivity.databinding.ActivityMainBinding
import com.example.pdfviewactivity.printing.DeviceHelper
import com.example.pdfviewactivity.utiils.root_dections.RootUtil
import com.usdk.apiservice.aidl.printer.AlignMode
import com.usdk.apiservice.aidl.printer.OnPrintListener


class MainActivity : AppCompatActivity(), DeviceHelper.ServiceReadyListener {
    private val binding by lazy {
        ActivityMainBinding.inflate(layoutInflater)
    }

    var testVal = emptyArray<String>()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(binding.root)
        DeviceHelper.me().setServiceListener(this)
        if (RootUtil.isDeviceRooted()) finish()

        testVal = arrayOf(
            "      Taste Town Pvt. Ltd\r\n       Kathmandu , Nepal\r\n      VAT No. : 610307863\r\n          CREDIT NOTE\r\n                \r\nCN. No.: CN18-TFC-79/80     \r\nDate   : 11/28/2022         \r\nMiti   : 12/08/2079         \r\nName   :                          \r\nAddress:                    \r\nPAN No.:                    \r\nRef Bill No  : TI1061-TFC-79/80   \r\nRemarks: @remarks           \r\n--------------------------------\r\nSn|     Particulars    | Amount|\r\n--------------------------------\r\n1  MIX LAPHING DRY         97.35\r\nQty: 1\r\nRate: 97.35\r\n2  8848 VODKA HALF       1592.92\r\nQty: 1\r\nRate: 1592.92\r\n       -------------------------\r\n          Gross Amount:  1690.27\r\n          Discount    :     0.00\r\n          S. Charge   :     0.00\r\n          taxable     :  1690.27\r\n          nontaxable  :     0.00\r\n          VAT 13%     :   219.73\r\n          Net Amount  :  1910.00\r\n       -------------------------\r\n       Tender      :     1910.00\r\n       Change      :        0.00\r\n--------------------------------\r\nRs. One thousand nine hundred   \r\nten only                        \r\n                                \r\nThank You For Visiting Us.      \r\nHope You Had A Good Time.       \r\nCounter : Laphing   ( 3:35PM  ) \r\nCashier : Admin     \r\n-\r\n",
            "      Taste Town Pvt. Ltd\r\n       Kathmandu , Nepal\r\n            KOT MEMO\r\nBill No: CN18-TFC-79/80        \r\nDate   : 11/28/2022            \r\nTime   : 3:35PM                \r\n--------------------------------\r\nSn|       Particulars      |Qty|\r\n--------------------------------\r\n1  MIX LAPHING DRY             1\r\n2  8848 VODKA HALF             1\r\n--------------------------------\r\n-\r\n-\r\n-\r\n-\r\n-\r\n"
        )

        binding.rvView.adapter = AdapterDetails(testVal)
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.menu, menu)
        return super.onCreateOptionsMenu(menu)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean = when (item.itemId) {
        R.id.mybutton -> {

            slideUp(binding.root)
            print()
            true
        }
        else -> super.onOptionsItemSelected(item)
    }

    private fun print() {
        val printer = DeviceHelper.me().printer
//            for (profile in testVal) {
        try {
            printer.addText(AlignMode.LEFT, testVal.toString())
            printer.feedLine(2)
            printer.startPrint(object : OnPrintListener.Stub() {
                override fun onFinish() {}
                override fun onError(error: Int) {}
            })
        } catch (_: RemoteException) {
        }

//        }

    }

    private fun slideUp(view: View) {
        view.visibility = View.VISIBLE
        val animate = TranslateAnimation(
            0F,  // fromXDelta
            0F,  // toXDelta
            0F,  // fromYDelta
            -view.height.toFloat()
        ) // toYDelta
        animate.duration = 2000
        animate.fillAfter = false
        view.startAnimation(animate)
    }

    private fun register(useEpayModule: Boolean = true) {
        try {
            DeviceHelper.me().register(useEpayModule)
        } catch (e: IllegalStateException) {
//            SweetToast.error(this@LoginView, "register fail: " + e.message)
        }
    }

    override fun onReady(version: String?) {
        register()
    }
}



