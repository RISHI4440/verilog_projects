import intelhex
import argparse

def calculate_checksum(record_type, address, data):
    byte_count = len(data)
    checksum = byte_count + (address >> 8) + (address & 0xFF) + record_type
    checksum += sum(data)
    checksum = (-checksum) & 0xFF
    return checksum

def reformat_ihex(input_file, output_file):
    ihex = intelhex.IntelHex(input_file)
    address = ihex.minaddr() // 4  # Word address
    
    with open(output_file, 'w') as out_file:
        for addr in range(ihex.minaddr(), ihex.maxaddr(), 4):
            # Extract 4 bytes for each new line
            data = [ihex[addr + i] for i in range(4)]
            byte_count = 4
            record_type = 0x00
            
            # Convert word address to 2-byte hex address
            word_address = address & 0xFFFF
            address += 1
            
            # Calculate the checksum for the new format
            checksum = calculate_checksum(record_type, word_address, data)
            
            # Format and write the line to output file
            out_file.write(f":{byte_count:02X}{word_address:04X}{record_type:02X}")
            out_file.write(''.join(f"{byte:02X}" for byte in data))
            out_file.write(f"{checksum:02X}\n")
        
        # Write the end-of-file record
        out_file.write(":00000001FF\n")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Reformat Intel HEX file to word-addressed format.")
    parser.add_argument("input_file", help="Path to the input .ihex file")
    parser.add_argument("output_file", help="Path to the output .ihex file")
    args = parser.parse_args()

    reformat_ihex(args.input_file, args.output_file)

