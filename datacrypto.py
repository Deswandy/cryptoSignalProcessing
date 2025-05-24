import yfinance as yf

# Downloading data from 2020 onwards
btc = yf.download("BTC-USD", start="2018-01-01")
eth = yf.download("ETH-USD", start="2018-01-01")
xrp = yf.download("XRP-USD", start="2018-01-01")

# Save to CSV
btc.to_csv("btc_usd_2018.csv")
eth.to_csv("eth_usd_2018.csv")
xrp.to_csv("xrp_usd_2018.csv")

print("Files saved successfully.")
