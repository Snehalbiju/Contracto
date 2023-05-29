package com.example.contracto;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.squareup.picasso.Picasso;

import java.util.List;

import de.hdodenhof.circleimageview.CircleImageView;

public class HomeJobAdapter extends RecyclerView.Adapter<HomeJobAdapter.ViewHolder> {
    Context context;
    String name[],category[],place[],status[],photo[],work_id[],district[];
    String imgString="http://"+WebServiceCaller.ip+":8084/Contracto/Assets/Files/ClientPhoto/";
    public HomeJobAdapter( Context context,String name[],String category[],String district[],String place[],String status[],String photo[],String work_id[]) {
        this.context=context;
        this.name=name;
        this.category=category;
        this.district=district;
        this.place=place;
        this.status=status;
        this.photo=photo;
        this.work_id=work_id;
    }


    @NonNull
    @Override
    public HomeJobAdapter.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view= LayoutInflater.from(parent.getContext()).inflate(R.layout.search_list,parent,false);
        return new HomeJobAdapter.ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull HomeJobAdapter.ViewHolder holder, int position) {

        holder.client_name.setText(name[position]);
        holder.category.setText(category[position]);
        holder.place.setText(place[position]+" ,"+district[position]);

        String statusValue=status[position];
        if(statusValue.equals("0")){
            holder.status.setText("Actively searching");
        }
        if(statusValue.equals("1")){
            holder.status.setText("Some applied");
        }
        if(statusValue.equals("2")){
            holder.status.setText("No longer Receiving");
        }


        String imageUrl = imgString+photo[position];
        Picasso.get()
                .load(imageUrl)
                .into(holder.client_photo);
        String workid=work_id[position];
        holder.workid=workid;

        holder.client_photo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent(context,FullImageView.class);
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                intent.putExtra("zoom_image",imageUrl);
                context.startActivity(intent);
            }
        });


    }

    @Override
    public int getItemCount() {
        return name.length;
    }

    //view holder class



    public class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        public String workid;
        private CircleImageView client_photo;
        private TextView client_name;
        private TextView category;
        private TextView place;
        private TextView status;

        public ViewHolder(@NonNull View itemView) {
            super(itemView);
            //here use xml ids
            //give different name not like constructor
            client_photo = itemView.findViewById(R.id.imageview);
            client_name = itemView.findViewById(R.id.name);
            category = itemView.findViewById(R.id.category);
            place = itemView.findViewById(R.id.place);
            status = itemView.findViewById(R.id.status);
            itemView.setOnClickListener(this);
        }


        @Override
        public void onClick(View v) {
            Intent intent = new Intent(context, ViewJobActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.putExtra("workid",workid);
            context.startActivity(intent);
        }
    }

}
