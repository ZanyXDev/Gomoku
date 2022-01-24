package io.github.zanyxdev.gomoku;

import android.util.DisplayMetrics;

import org.qtproject.qt5.android.bindings.QtActivity;

public class GomokuActivity extends QtActivity
{
    public int getScreenDpi()
    {
        DisplayMetrics metrics = getResources().getDisplayMetrics();

        return metrics.densityDpi;
    }
}
