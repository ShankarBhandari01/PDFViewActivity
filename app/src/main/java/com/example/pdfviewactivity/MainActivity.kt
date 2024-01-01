package com.example.pdfviewactivity

import android.graphics.*
import android.graphics.pdf.PdfRenderer
import android.os.Bundle
import android.os.Environment
import android.os.ParcelFileDescriptor
import android.os.ParcelFileDescriptor.MODE_READ_ONLY
import android.os.RemoteException
import android.util.Log
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.view.animation.TranslateAnimation
import androidx.appcompat.app.AppCompatActivity
import com.example.pdfviewactivity.adapter.AdapterDetails
import com.example.pdfviewactivity.databinding.ActivityMainBinding
import com.example.pdfviewactivity.printing.DeviceHelper
import com.example.pdfviewactivity.utiils.root_dections.RootUtil
import com.usdk.apiservice.aidl.vectorprinter.Alignment
import com.usdk.apiservice.aidl.vectorprinter.TextSize
import com.usdk.apiservice.aidl.vectorprinter.UVectorPrinter
import com.usdk.apiservice.aidl.vectorprinter.VectorPrinterData
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.io.File
import java.io.FileOutputStream
import java.io.IOException


class MainActivity : AppCompatActivity(), DeviceHelper.ServiceReadyListener {
    private val binding by lazy {
        ActivityMainBinding.inflate(layoutInflater)
    }
    lateinit var uVectorPrinter: UVectorPrinter
    var testVal = emptyArray<String>()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(binding.root)
        DeviceHelper.me().setServiceListener(this)
        if (RootUtil.isDeviceRooted()) finish()


        val fileDescriptor = ParcelFileDescriptor.open(getPDF(), MODE_READ_ONLY);
        val renderer = PdfRenderer(fileDescriptor);
        val pageCount = renderer.pageCount

        CoroutineScope(Dispatchers.IO).launch {
            val imagesList = mutableListOf<Bitmap>()
            for (i in 0 until pageCount) {
                val page = renderer.openPage(i)
                val bitmap = Bitmap.createBitmap(page.width, page.height, Bitmap.Config.ARGB_8888)
                val canvas = Canvas(bitmap)
                canvas.drawColor(Color.WHITE)
                page.render(bitmap, null, null, PdfRenderer.Page.RENDER_MODE_FOR_DISPLAY)
                page.close()

                if (bitmap != null && !bitmapIsBlankOrWhite(bitmap)) {
                    imagesList.add(bitmap)
                }
            }
            withContext(Dispatchers.Main) {
                // Assuming you have a bitmap named 'originalBitmap' that you want to scale up
                val originalWidth = imagesList[0].width
                val originalHeight =  imagesList[0].height
                val displayMetrics = resources.displayMetrics
                val screenWidthPixels = displayMetrics.widthPixels

                val scaleFactor = 0.9f // Adjust this according to your requirement
                val scaleWidth = (screenWidthPixels * scaleFactor).toInt()
                val scaleHeight = originalHeight * 2 // Double the height

                val scaledBitmap = Bitmap.createScaledBitmap(imagesList[0], scaleWidth, scaleHeight, true)

                binding.imageView.setImageBitmap(scaledBitmap)
                initPrintData(scaledBitmap)
            }

            // Here, you can use the imagesList as needed without saving to the device
            // For example, iterate through the list and perform operations on the bitmaps
//            for (image in imagesList) {
//                // Perform operations on each bitmap, like displaying or processing them
//                initPrintData(image)
//            }
        }


//        testVal = arrayOf(
//            "      Taste Town Pvt. Ltd\r\n       Kathmandu , Nepal\r\n      VAT No. : 610307863\r\n          CREDIT NOTE\r\n                \r\nCN. No.: CN18-TFC-79/80     \r\nDate   : 11/28/2022         \r\nMiti   : 12/08/2079         \r\nName   :                          \r\nAddress:                    \r\nPAN No.:                    \r\nRef Bill No  : TI1061-TFC-79/80   \r\nRemarks: @remarks           \r\n--------------------------------\r\nSn|     Particulars    | Amount|\r\n--------------------------------\r\n1  MIX LAPHING DRY         97.35\r\nQty: 1\r\nRate: 97.35\r\n2  8848 VODKA HALF       1592.92\r\nQty: 1\r\nRate: 1592.92\r\n       -------------------------\r\n          Gross Amount:  1690.27\r\n          Discount    :     0.00\r\n          S. Charge   :     0.00\r\n          taxable     :  1690.27\r\n          nontaxable  :     0.00\r\n          VAT 13%     :   219.73\r\n          Net Amount  :  1910.00\r\n       -------------------------\r\n       Tender      :     1910.00\r\n       Change      :        0.00\r\n--------------------------------\r\nRs. One thousand nine hundred   \r\nten only                        \r\n                                \r\nThank You For Visiting Us.      \r\nHope You Had A Good Time.       \r\nCounter : Laphing   ( 3:35PM  ) \r\nCashier : Admin     \r\n-\r\n",
//            "      Taste Town Pvt. Ltd\r\n       Kathmandu , Nepal\r\n            KOT MEMO\r\nBill No: CN18-TFC-79/80        \r\nDate   : 11/28/2022            \r\nTime   : 3:35PM                \r\n--------------------------------\r\nSn|       Particulars      |Qty|\r\n--------------------------------\r\n1  MIX LAPHING DRY             1\r\n2  8848 VODKA HALF             1\r\n--------------------------------\r\n-\r\n-\r\n-\r\n-\r\n-\r\n"
//        )
//
//        binding.rvView.adapter = AdapterDetails(testVal)
    }

    private fun getPDF(): File? {
        val assetManager = assets
        val fileName = "55_mm.pdf"
        return try {
            val inputStream = assetManager.open(fileName)
            val outputFile =
                File(getExternalFilesDir(Environment.DIRECTORY_DOCUMENTS), fileName)

            val outputStream = FileOutputStream(outputFile)
            val buffer = ByteArray(1024)
            var read: Int
            while (inputStream.read(buffer).also { read = it } != -1) {
                outputStream.write(buffer, 0, read)
            }
            outputStream.flush()
            outputStream.close()
            inputStream.close()

            outputFile // Return the File object representing the copied PDF
        } catch (e: IOException) {
            e.printStackTrace()
            null
        }

    }

    private fun initPrintData(bitmap: Bitmap?) {
        initUVectorPrinter()
        val textFormat = Bundle()
        textFormat.putInt(VectorPrinterData.ALIGNMENT, Alignment.CENTER)
        textFormat.putInt(VectorPrinterData.TEXT_SIZE, TextSize.NORMAL)
        textFormat.putBoolean(VectorPrinterData.UNDERLINE, false)
        textFormat.putBoolean(VectorPrinterData.BOLD, false)


        uVectorPrinter.addImage(textFormat, bitmap)
        uVectorPrinter.addText(
            textFormat,
            noOfLine(53) + "\n"
        )
    }

    private fun noOfLine(no: Int): String {
        return String(CharArray(no)).replace('\u0000', '-')
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.menu, menu)
        return super.onCreateOptionsMenu(menu)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean = when (item.itemId) {
        R.id.mybutton -> {
            slideUp(binding.root)
            startPrinting()
            true
        }
        else -> super.onOptionsItemSelected(item)
    }

    private fun initUVectorPrinter() {
        try {
            uVectorPrinter = DeviceHelper.me().vectorPrinter

            /*
             * Init Setup For Vector Print
             * */
            val initFormat = Bundle()
            initFormat.putString(
                VectorPrinterData.CUSTOM_TYPEFACE_PATH,
                "fonts/source_sans_pro_regular.ttf"
            )
            initFormat.putInt(VectorPrinterData.SYSTEM_TYPEFACE_NAME, Typeface.NORMAL)
            initFormat.putInt(VectorPrinterData.LINE_SPACING, Typeface.NORMAL)
            uVectorPrinter.init(initFormat)
        } catch (e: RemoteException) {
            e.printStackTrace()
        }
    }

    private fun print() {

//        for (profile in testVal) {
//            try {
//                uVectorPrinter.addText(AlignMode.LEFT, profile)
//                uVectorPrinter.feedLine(2)
//                uVectorPrinter.startPrint(object : OnPrintListener.Stub() {
//                    override fun onFinish() {}
//                    override fun onError(error: Int) {}
//                })
//            } catch (_: RemoteException) {
//            }
//
//        }
    }

    private fun startPrinting() {
        try {
            uVectorPrinter.startPrint(object :
                com.usdk.apiservice.aidl.vectorprinter.OnPrintListener.Stub() {
                @Throws(RemoteException::class)
                override fun onFinish() {
                    println("finished")
                }

                @Throws(RemoteException::class)
                override fun onStart() {
                    println("printing")
                }

                @Throws(RemoteException::class)
                override fun onError(i: Int, s: String) {
                    println("error $s")
                }
            })
        } catch (e: RemoteException) {
            e.printStackTrace()
        }
    }


    private fun bitmapIsBlankOrWhite(bitmap: Bitmap?): Boolean {
        if (bitmap == null) return true
        val w = bitmap.width
        val h = bitmap.height
        for (i in 0 until w) {
            for (j in 0 until h) {
                val pixel = bitmap.getPixel(i, j)
                if (pixel != Color.WHITE) {
                    return false
                }
            }
        }
        return true
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



