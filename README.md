# CSV EXPORTER
#### Video Demo:  <https://www.youtube.com/watch?v=S8i16b6NpeY>
#### Description:
CSV_Exporter is a custom Expert Advisor (EA) script build by eka in 2023. The purpose of this EA is to export historical price and volume data of MetaTrader 4 to a CSV (Comma-Separated Values) file, which can be used for further analysis in external tools or platforms.

The EA is designed to provide traders and analysts with a convenient way to access historical data from the MetaTrader4 platform in a structured format. by exporting the data to a CSV file, users can leverage various spreadsheet and data analisis tools to gain insights into price movements and trading volumes over time.

This data export capability can be particularly valuable for traders who prefer to perform in-depth technical analysis, develop trading strategies, or conduct research using specialized software beyond the capabilities of MetaTrader 4 alone. Whether for backtesting strategies or conducting statistical analysis, the exported CSV file offer versatility and flexibility in working with historical data.

As a result, CSV_Exporter serves as a useful tool to enhance traders' decision-making processes and broaden their analytical capabilities in the financial markets. The EA's simplicity and customizable parameters make it accessible for traders of different experience levels, and its potential benefits extend beyond the standard functionalities of the MetaTrader 4 platform.a

##### Features:
###### Customizable File Name :
The EA allows users to specify a custom file name for the CSV output file. By default, the file name is set to "Data_Set", but users can modify it as per their preference.
###### Simple Moving Average (SMA) Calculation :
 The EA calculates the SMA for the closing price of the financial instrument over a defined period. The period for SMA calculation can be adjusted using the SMA_Period parameter.
##### How It Works :
Upon execution, the EA iterates through the historical price and volume data of the financial instrument. It calculates the SMA for the closing price and volume data and stores the values in corresponding arrays. The SMA values are then exported along with the date, open price, close price, low price, high price, volume, and the calculated volume moving average to a CSV file.

The exported CSV file is named using the specified FileName, followed by the symbol name of the financial instrument, and the timeframe of the chart data. The file extension is set to ".csv".

##### Usage :
1. attach the CSV_Exporter EA to the chart of the desired financial instrument(chart).
2. Adjust the input parameters, such as FileName, SMA_Period, and SMA_VOLUME, as needed.
3. The EA will automatically calculate the SMAs and export the data to a CSV file when executed.
4. The exported CSV file will be available in the "Files" tab of the Terminal window.
5. Please note that the EA requires sufficient historical data to calculate the SMAs correctly. If the chart data is limited, it may not produce meaningful results.
##### Disclaimer :
Trading and financial analysis involve significant risks, and the use of this EA or the data it exports does not guarantee any specific outcomes or profits. Users are solely responsible for their trading decisions and should perform due diligence and risk assessment before implementing any trading strategies.