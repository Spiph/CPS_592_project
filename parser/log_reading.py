import sys

# This needs to be done because sometimes soar prints > 1 log entry per step. This collects the last log entry at the end of the step.
# It's easier to debug python than it is to debug soar
def main(file):

    timeDict = {}
    with open(file) as f:
        # Read every line and add to a dictionary to filter out undesired logs
        while True:
            line = f.readline()
            if not line:
                break

            arr = line.split(" ")
            key = arr[1]
            moved = arr[3]
            radar = arr[5] 
            shield = arr[7]
            energy = arr[9]
            state = arr[11]
            resurrected = arr[13]
            timeDict[key] = (moved, radar, shield, energy, state, resurrected)

    # Print CSV
    count = 0
    for key in timeDict.keys():
        entry = timeDict[key]
        if entry[5] == "1":
            count = 0
        else:
            count += 1
        print(entry[0] + "," + entry[1] + "," + entry[2] + "," + entry[3] + "," + entry[4] + "," + str(count))


if __name__ == "__main__":
    # n = bool("true")
    # print(n)
    if len(sys.argv) != 2:
        print("Usage: python log_reading.py <fileToRead>")
        exit(1)
    
    main(sys.argv[1])