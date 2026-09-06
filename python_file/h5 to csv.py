import pandas as pd


path = r"Data_Engineering_UC14_ESDP\New folder\newdatasets\sap_hcm\hcm_employees.h5"
key = 'departments'  

df = pd.read_hdf(path, key=key)

# 📂 SPECIFY THE EXACT STORAGE PATH HERE:
output_path = r"Data_Engineering_UC14_ESDP\New folder\newdatasets\sap_hcm\csv_file\hcm_departments.csv"
df.to_csv(output_path, index=False)

print(f"Conversion complete! File stored at: {output_path}")