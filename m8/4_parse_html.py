"""Task 6: Read html document, parse it, and show its title."""

import sys
from bs4 import BeautifulSoup

# check arguments
if len(sys.argv) != 2:
    print("Usage: sys.argv[0] FILENAME.html")
else:
    # get file name and open the file
    filename = sys.argv[1]
    try:
        file = open(filename, "r")
    except FileNotFoundError:
        print(f"\n[ERROR]: FILE {filename} IS NOT AVAILABLE\n")
    else:
        # create BeautifulSoup object soup (the text is parsed)
        soup = BeautifulSoup(file, 'html.parser')
        try:
            # try extraction the value of soup.title.string property
            print(f"\n[SUCCESS]: HTML DOCUMENT TITLE: {soup.title.string}\n")
        except AttributeError:
            print(
                f"\n[ERROR]: THE DOCUMENT {filename} HAS NO TITLE TAG\n")
        finally:
            file.close()
