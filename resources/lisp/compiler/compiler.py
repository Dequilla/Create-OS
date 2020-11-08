import sys, getopt

infile = ""
outfile = ""

try:
    options = getopt.getopt(sys.argv[1:], 'i')

    for opt, value in options:
        if opt == "-i":
            infile = value
        elif opt == "-o":
            outfile = value
    
    if not infile:
        print("Need an infile (option -i).")
        sys.exit(1)
    if not outfile:
        print("Need an outfile (option -o).")
        sys.exit(2)
except getopt.GetoptError as err:
    print(err)
    sys.exit(3)

print(infile, outfile)