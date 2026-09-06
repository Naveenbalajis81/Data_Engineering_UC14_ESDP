import pandas as pd
import h5py

def find_h5_keys(file_path):
    with h5py.File(file_path, 'r') as f:
        print("Available keys inside your .h5 file:")
        print(list(f.keys()))
        return list(f.keys())

def convert_h5_to_csv(file_path,key,output_path):
    df = pd.read_hdf(file_path, key=key)
    df.to_csv(output_path, index=False)
    print(f"Conversion complete! File stored at: {output_path}")


path= r"Data_Engineering_UC14_ESDP\New folder\newdatasets\sap_hcm"
outpath=r"Data_Engineering_UC14_ESDP\New folder\newdatasets\sap_hcm\csv_files"

h5_list=["hcm_employees.h5","hcm_departments.h5","hcm_payroll.h5","hcm_positions.h5"]
csv_list=["hcm_employees.csv","hcm_departments.csv","hcm_payroll.csv","hcm_positions.csv"]

for i in range(len(h5_list)):
    input_filename = h5_list[i]
    output_filename = csv_list[i]
    input_path = f"{path}\\{input_filename}"
    output_path = f"{outpath}\\{output_filename}"
    print(f"Converting {input_filename} to {output_filename}")
    convert_h5_to_csv(input_path,key=find_h5_keys(input_path)[0],output_path=output_path)