# Example of a dummy Python script for Robot testing purposes
# Author: @ponchotitlan

import argparse

def main():
    parser = argparse.ArgumentParser(description='Network Device dummy script')

    # Network device arguments
    parser.add_argument('--device_name', required=True, help='Device hostname')
    parser.add_argument('--location', required=True, help='Device location')
    parser.add_argument('--ip_address', required=True, help='Device IP address')
    args = parser.parse_args()

    # This dummy script will just return a confirmation of the inputs provided. Nothing fancy
    print(f"Success!!!")

if __name__ == '__main__':
    main()