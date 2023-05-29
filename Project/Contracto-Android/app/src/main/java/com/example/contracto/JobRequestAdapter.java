package com.example.contracto;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.squareup.picasso.Picasso;

import java.util.List;

import de.hdodenhof.circleimageview.CircleImageView;

public class JobRequestAdapter extends RecyclerView.Adapter<JobRequestAdapter.ViewHolder> {
    Context context;
    String name[], category[], place[], status[], cphoto[], wphoto[],phone[], district[];
    String imgStringc = "http://" + WebServiceCaller.ip + ":8084/Contracto/Assets/Files/ClientPhoto/";

    String imgStringw = "http://" + WebServiceCaller.ip + ":8084/Contracto/Assets/Files/WorkPhoto/";

    public JobRequestAdapter(Context context, String name[], String phone[],String category[], String district[], String place[], String status[], String cphoto[], String wphoto[]) {
        this.context = context;
        this.name = name;
        this.phone = phone;
        this.category = category;
        this.district = district;
        this.place = place;
        this.status = status;
        this.cphoto = cphoto;
        this.wphoto = wphoto;
    }


    @NonNull
    @Override
    public JobRequestAdapter.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.work_request_list, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull JobRequestAdapter.ViewHolder holder, int position) {

        holder.client_name.setText(name[position]);
        holder.client_phone.setText(phone[position]);
        holder.category.setText(category[position]);
        holder.place.setText(place[position] + " ," + district[position]);

        String statusValue = status[position];
        if (statusValue.equals("0")) {
            holder.status.setText("Pending");
        }
        if (statusValue.equals("1")) {
            holder.status.setText("Accepted");
        }



        String imageUrlc = imgStringc + cphoto[position];
        Picasso.get()
                .load(imageUrlc)
                .into(holder.client_photo);

        String imageUrlw = imgStringw + wphoto[position];
        Picasso.get()
                .load(imageUrlw)
                .into(holder.work_photo);


        holder.client_photo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(context, FullImageView.class);
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                intent.putExtra("zoom_image", imageUrlc);
                context.startActivity(intent);
            }
        });

        holder.work_photo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(context, FullImageView.class);
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                intent.putExtra("zoom_image", imageUrlw);
                context.startActivity(intent);
            }
        });


    }

    @Override
    public int getItemCount() {
        return name.length;
    }

//view holder class


    public class ViewHolder extends RecyclerView.ViewHolder  {
        public String workid;
        private CircleImageView client_photo;
        private TextView client_name;

        private TextView client_phone;
        private TextView category;
        private TextView place;
        private TextView status;

        private ImageView work_photo;

        public ViewHolder(@NonNull View itemView) {
            super(itemView);
            //here use xml ids
            //give different name not like constructor
            client_photo = itemView.findViewById(R.id.c_image);
            client_name = itemView.findViewById(R.id.c_name);
            client_phone=itemView.findViewById(R.id.c_phone);
            category = itemView.findViewById(R.id.w_category);
            place = itemView.findViewById(R.id.w_location);
            status = itemView.findViewById(R.id.request_status);
            work_photo = itemView.findViewById(R.id.work_image);
        }

    }

}
