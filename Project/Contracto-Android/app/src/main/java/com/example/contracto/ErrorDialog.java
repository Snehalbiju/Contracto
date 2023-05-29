package com.example.contracto;

import android.app.Activity;
import android.app.AlertDialog;
import android.view.LayoutInflater;

public class ErrorDialog {

    private Activity activity;
    private AlertDialog dialog;

    ErrorDialog(Activity myActivity){
        activity=myActivity;
    }

    void startLoadingDialog(){
        AlertDialog.Builder builder=new AlertDialog.Builder(activity);

        LayoutInflater inflater=activity.getLayoutInflater();
        builder.setView(inflater.inflate(R.layout.error,null));
        builder.setCancelable(false);

        dialog=builder.create();
        dialog.show();
    }

    void dismissDialog(){
        dialog.dismiss();
    }
}

