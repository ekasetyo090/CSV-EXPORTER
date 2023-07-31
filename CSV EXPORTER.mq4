//+------------------------------------------------------------------+
//|                                                     CSV_Exporter |
//+------------------------------------------------------------------+
#property copyright "Built on 2023, by eka."
#property link      "https://github.com/ekasetyo090"
#property version   "1.00"
#property strict
extern string   FileName = "Data_Set"; // defined file name that able to costumized by user
extern int      SMA_Period = 20;          // defined SMA period
extern int      SMA_VOLUME = 20;          // Periode SMA volume period
string extension = ".csv"; // fomat file.

// defined function that calculated SMA vol, if used MaOnArray() painfully slow computers
double CalculateMAV(const double& data[], int period)
{
    double sum = 0;
    for (int i = 0; i < period; i++)
    {
        sum += data[i];
    }
    return sum / period;
}

void OnTick()
{
    // defined limit for iteration on FOR LOOP
    int limit = MathMax(Bars - SMA_Period + 1, 0);
    // define full filename for name on export, include symbol name and timeframe
    string full_filename = FileName + "_" + Symbol() + "_" + IntegerToString(Period()) + extension;
    // condition if no bars to calculated
    if (limit <= 0)
    {
        Print("Error: Not enough bars to calculate SMA");
        return;
    }

    // define some array
    double SMA_Buffer[];
    double OpenBuffer[];
    double CloseBuffer[];
    double LowBuffer[];
    double HighBuffer[];
    double VolumeBuffer[];
    double MAVolumeBuffer[];
    datetime TimeBuffer[];

    // resizezing array base on limit
    ArrayResize(SMA_Buffer, limit);
    ArrayResize(OpenBuffer, limit);
    ArrayResize(CloseBuffer, limit);
    ArrayResize(LowBuffer, limit);
    ArrayResize(HighBuffer, limit);
    ArrayResize(VolumeBuffer, limit);
    ArrayResize(MAVolumeBuffer, limit);
    ArrayResize(TimeBuffer, limit);

    // store value on prev array by FOR loop
    for (int i = 0; i < limit; i++)
    {
        SMA_Buffer[i] = iMA(Symbol(), Period(), SMA_Period, SMA_Period, MODE_SMA, PRICE_CLOSE, i); // Callculating SMA by built in function
        TimeBuffer[i] = Time[i]; // store value of time
        OpenBuffer[i] = Open[i]; // store value of time
        CloseBuffer[i] = Close[i]; // store value of time
        LowBuffer[i] = Low[i]; // store value of time
        HighBuffer[i] = High[i]; // store value of time
        VolumeBuffer[i] = Volume[i]; // store value of time

        // special case for calculated SMA volume
        if (i > SMA_VOLUME - 1)
        {
            MAVolumeBuffer[i] = CalculateMAV(VolumeBuffer, SMA_VOLUME);
        }
        else
        {
            MAVolumeBuffer[i] = 0;
        }
    }
    // defined handle of csv file and write
    int file_handle = FileOpen(full_filename, FILE_CSV | FILE_WRITE, ',');
    // check if file existing file ( prevent error special case when user change name while ea running)
    if (!FileIsExist(full_filename))
    {
        Print("File does not exist, creating new file...");
        file_handle = FileOpen(full_filename, FILE_CSV | FILE_WRITE, ',');
        if (file_handle == INVALID_HANDLE)
        {
            Print("Error: FileOpen failed, error code:", GetLastError());
            return;
        }
    }
    // defined condition if handle invalid
    if (file_handle == INVALID_HANDLE)
    {
        Print("Error: FileOpen failed, error code:", GetLastError());
        return;
    }

    // add header (first thing ea write) as header
    FileWrite(file_handle, "Date", "Open", "Close", "Low", "High", "Volume", "VOLUME_MA(" + IntegerToString(SMA_VOLUME) + ")", "SMA(" + IntegerToString(SMA_Period) + ")");
    // iterating for loop for storing value by bar sequences
    for (int i = limit - 1; i >= 0; i--)
    {
        string datetime_str = TimeToString(TimeBuffer[i], TIME_DATE | TIME_MINUTES);
        FileWrite(file_handle, datetime_str, DoubleToString(OpenBuffer[i], Digits), DoubleToString(CloseBuffer[i], Digits), DoubleToString(LowBuffer[i], Digits), DoubleToString(HighBuffer[i], Digits), DoubleToString(VolumeBuffer[i], 0), DoubleToString(MAVolumeBuffer[i], 0), DoubleToString(SMA_Buffer[i], Digits));
    }
    // Printing DONE in EA Journal for indicated that ea succesfully export data.
    Print("DONE");
    // close and save file and that was CS50
    FileClose(file_handle);
}
