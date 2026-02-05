package com.MBenDelphi.UssdAutomationDemo;

import android.content.Context;
import android.telephony.TelephonyManager;
import android.telephony.TelephonyManager.UssdResponseCallback;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

public class UssdBridge {

    private Context fContext;
    private TelephonyManager fTelephonyMgr;
    private UssdListener fUssdListener;
    private DelphiLogger fDelphiLogger;
    private Handler fHandler; // Handler tied to the main looper

    // Helper method to decode error codes
    private String getErrorMessage(int aFailureCode) {
        switch (aFailureCode) {
            case -1:
                return "Menu response (code -1) - or Unknown ERROR";
            case 0:
                return "No error";
            case 1:
                return "Radio not available";
            case 2:
                return "Network timeout";
            case 3:
                return "Network not allowed";
            case 4:
                return "Invalid USSD format";
            default:
                return "Error code: " + aFailureCode;
        }
    }

    // UssdCallback-Listener Interface for Delphi to implement
    public interface UssdListener {
        void onResponse(String aResponse);
        void onFailure(String aError);
    }

    // Logger Interface for Delphi to implement
    public interface DelphiLogger {
        /**
         * Logs a message.
         *
         * Note for Delphi developers:
         * The 'final' keyword in Java is equivalent to 'const' in Delphi.
         * It means the parameter cannot be reassigned within the method body.
         *
         * @param aLogMsg the log message (const/final - cannot be reassigned)
         */
        void logMessage(final String aLogMsg);
    }


    public UssdBridge(Context aContext) {
        if (aContext == null) {
            throw new IllegalArgumentException("Context cannot be null !");
        }
        this.fContext = aContext;
        this.fTelephonyMgr = (TelephonyManager) aContext.getSystemService(Context.TELEPHONY_SERVICE);
        this.fHandler = new Handler(Looper.getMainLooper()); // Initialize main looper handler
    }

    public void setListener(UssdListener aListener) {
        this.fUssdListener = aListener;
    }

    public void setDelphiLogger(DelphiLogger aDelphiLogger) {
        this.fDelphiLogger = aDelphiLogger;
    }

    public void sendUssdRequest(String aUssdCode, int aSimSlot) {

        if (aUssdCode == null || aUssdCode.isEmpty()) {
            if (fDelphiLogger != null) {
                fDelphiLogger.logMessage("Invalid USSD code: cannot be null or empty !!");
            }
            return; // Abort if the USSD code is invalid
        }

        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {

            // Logic to select specific SIM subscription would go here based on simSlot
            // For simplicity, using default manager. In production, use SubscriptionManager.

            try {


                fTelephonyMgr.sendUssdRequest(aUssdCode, new UssdResponseCallback() {
                    @Override
                    public void onReceiveUssdResponse(TelephonyManager telephonyManager, String request, CharSequence response) {
                        fHandler.post(() -> {
                            if (fUssdListener != null) {
                                fUssdListener.onResponse(response.toString());
                            }
                        });
                    }

                    @Override
                    public void onReceiveUssdResponseFailed(TelephonyManager telephonyManager, String request, int failureCode) {
                        fHandler.post(() -> {

                        String lErrorMsg = getErrorMessage(failureCode);
                        if (fDelphiLogger != null) {
                            fDelphiLogger.logMessage("USSD Failed - Code: " + failureCode + " (" + lErrorMsg + ")");
                        }

                            if (fUssdListener != null) {
                                fUssdListener.onFailure("Failed with code: " + failureCode);
                            }
                        });
                    }
                }, fHandler);

            } catch (Exception e) {
                if (fDelphiLogger != null) {
                    fDelphiLogger.logMessage("Error while sending USSD Request: " + e.getMessage());
                }
            }

        } else {
            if (fUssdListener != null) {
                fUssdListener.onFailure("API Level 26+ required for Native USSD Bridge");
            }
        }
    }
}
