import sys

def main(file):

    timeDict = {}
    with open(file) as f:
        # Read every line and add to a dictionary to filter out undesired logs
        while True:
            line = f.readline()
            if not line:
                break

            arr = line.split(" ")
            key = int(arr[1])
            moved = int(arr[3])
            radar = int(arr[5])
            shield = int(arr[7])
            energy = int(arr[9])
            state = arr[11]
            resurrected = arr[13]
            timeDict[key] = (moved, radar, shield, energy, state, resurrected)


    # Print stats
    # Define array to tabulate the results
    result_arr = [0,0,0,0, [0,0,0,0], 0]
    for key in timeDict.keys():
        entry = timeDict[key]

        result_arr[0] += int(entry[0])
        result_arr[1] += int(entry[1])
        result_arr[2] += int(entry[2])
        result_arr[3] += int(entry[3])
        state = entry[4]
        if state == "attack":
            result_arr[4][0] += 1
        elif state == "wander":
            result_arr[4][1] += 1
        elif state == "retreat":
            result_arr[4][2] += 1
        elif state == "chase":
            result_arr[4][3] += 1
        else:
            print("bad state")

        result_arr[5] += int(entry[5])

    count = len(timeDict.keys())
    print(f"Results: {result_arr}\nTotal logs: {count}")


if __name__ == "__main__":
    # n = bool("true")
    # print(n)
    if len(sys.argv) != 2:
        print("Usage: python log_stats.py <fileToRead>")
        exit(1)
    
    main(sys.argv[1])