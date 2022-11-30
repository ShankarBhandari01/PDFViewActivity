package com.example.pdfviewactivity.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.pdfviewactivity.databinding.RvViewBinding


class AdapterDetails constructor(
    private val previewList: Array<String>
) :
    RecyclerView.Adapter<AdapterDetails.myHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): myHolder {
        return myHolder(
            RvViewBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        )
    }

    override fun onBindViewHolder(holder: myHolder, position: Int) {
        holder.binding.tvDetails.text = previewList[position]
    }

    override fun getItemCount(): Int {
        return previewList.size
    }

    inner class myHolder(val binding: RvViewBinding) : RecyclerView.ViewHolder(binding.root)
}