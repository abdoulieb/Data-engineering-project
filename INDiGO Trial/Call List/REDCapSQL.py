import pandas as pd
import pyodbc
import requests

# Connect to REDCap API
api_url = 'https://ruff.mrc.gm:8443/redcap/api/'
api_token = 'E5FEBF04C14581CF182ABE8107AB8B50'
# Define payload for API request
payload = {
    'token': api_token,
    'content': 'record',
    'format': 'json',
    'type': 'flat',  # flat format exports one row per record
    'rawOrLabel': 'raw',  # raw for field codes, label for field labels
    'rawOrLabelHeaders': 'raw',  # raw for field codes, label for field labels
    'exportCheckboxLabel': 'false',  # false exports checkbox values as 0,1; true exports as label
    # Add any other parameters as needed
}

# Make API request to export records
response = requests.post(api_url, data=payload)
data = response.json()

# Convert data to DataFrame
df = pd.DataFrame(data)

# Group data by instrument name
instrument_groups = df.groupby('redcap_repeat_instrument')

# Connect to SQL Server
conn = pyodbc.connect('DRIVER={SQL Server};'
                      'SERVER=LP-10-CEESAY-Y;'
                      'DATABASE=LEO25071_INDiGO_Trial;'
                      )

# Iterate over each instrument group
for instrument_name, instrument_df in instrument_groups:
    # Insert data into SQL Server for each instrument
    instrument_df.to_sql(instrument_name, conn, if_exists='append', index=False)

# Close connection
conn.close()
