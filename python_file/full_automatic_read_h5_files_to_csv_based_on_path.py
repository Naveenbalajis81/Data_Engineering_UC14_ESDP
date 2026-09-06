from pathlib import Path
from concurrent.futures import ProcessPoolExecutor
import h5py
import pandas as pd

def convert_single_h5(input_path, output_dir):
    """Worker function to process a single H5 file."""
    try:
        # Convert string paths to Path objects for reliability
        input_path = Path(input_path)
        output_dir = Path(output_dir)
        
        # 1. Dynamically find the first key inside the file
        with h5py.File(input_path, 'r') as f:
            keys = list(f.keys())
            if not keys:
                print(f"⚠️ Skipped {input_path.name}: No keys found inside file.")
                return
            key = keys[0]

        # 2. Define the output file name (.h5 replaced with .csv)
        output_path = output_dir / f"{input_path.stem}.csv"
        
        # 3. Read and convert
        print(f"⚡ Processing: {input_path.name} (Key: '{key}')")
        df = pd.read_hdf(input_path, key=key)
        df.to_csv(output_path, index=False)
        print(f"✅ Completed: {output_path.name}")
        
    except Exception as e:
        print(f"❌ Error converting {input_path.name}: {e}")

if __name__ == '__main__':
    # Define your source and destination directories
    source_dir = Path(r"Data_Engineering_UC14_ESDP\New folder\newdatasets\sap_hcm")
    output_dir = Path(r"Data_Engineering_UC14_ESDP\New folder\newdatasets\sap_hcm\csv_file")
    
    # Create the output directory if it doesn't exist yet
    output_dir.mkdir(parents=True, exist_ok=True)
    
    # 🔍 AUTOMATIC SEARCH: Find all .h5 files in the source directory
    h5_files = list(source_dir.glob("*.h5"))
    
    if not h5_files:
        print("No .h5 files found in the source directory!")
    else:
        print(f"🚀 Found {len(h5_files)} files. Starting multi-process conversion...")
        
        # 🏎️ PARALLEL ACCELERATION: Processes files side-by-side using all CPU cores
        with ProcessPoolExecutor() as executor:
            # Map the worker function to all discovered files
            executor.map(convert_single_h5, h5_files, [output_dir] * len(h5_files))
            
        print("🎉 All files converted successfully!")
