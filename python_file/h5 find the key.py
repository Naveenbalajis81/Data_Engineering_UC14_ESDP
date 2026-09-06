import h5py

path = r"Data_Engineering_UC14_ESDP\New folder\newdatasets\sap_hcm\hcm_departments.h5"

with h5py.File(path, 'r') as f:
    print("Available keys inside your .h5 file:")
    print(list(f.keys()))
