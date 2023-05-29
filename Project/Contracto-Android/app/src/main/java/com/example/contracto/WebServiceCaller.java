package com.example.contracto;

import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapPrimitive;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;


final public class WebServiceCaller {

    public static String ip = "192.168.17.132";
    private String response;
    private int responseCode;
    private SoapObject request;
    private String url;
    private String exception;
    private String soapAction;


    public void setSoapObject(String methodName) {
        request = new SoapObject("http://WB/", methodName);
        url = "http://"+ip+":8084/Contracto/NewWebService";
    }

    public void addProperty(String key, Object value){
        request.addProperty(key, value);
    }

    public void setSoapActon() {
        this.soapAction = "";
    }

    public void setUrl(String url) {

        this.url = url;

    }

    public String getResponse() {

        return response;

    }

    public void callWebService() {

        SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(SoapEnvelope.VER11);

        envelope.setOutputSoapObject(request);

        HttpTransportSE httpTransportSE = new HttpTransportSE(url, 60*1000);

        try {

            httpTransportSE.call(soapAction, envelope);

            response = ((SoapPrimitive)envelope.getResponse()).toString();

        } catch (Exception ex) {

            response =ex.toString();

        }

    }
}
