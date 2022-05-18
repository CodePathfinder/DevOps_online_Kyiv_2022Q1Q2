"""parse text from file 'examples.txt' and replace some emotions with emoji’s"""

from emoji import emojize
from emotion_dicts import emoj_dict, kw_dict
import re

examples_file = "examples.txt"

try:
    # open examples_file for reading
    file = open(examples_file, "r")
except FileNotFoundError:
    print(f"[ERROR]: File {examples_file} is not available")
else:
    # get original content of the file
    original = file.read()
    modified = original
    # iterate over the key-words form kw_dict;
    # if found in the original text, it is substituted with the corresponding emoji
    for k in kw_dict:
        # pattern for search of the whole word in the text
        pattern = f"\\b{k}\\b"
        # substitution of key-words, if found; case-insensitive
        modified = re.sub(pattern, emojize(
            emoj_dict[kw_dict[k]]), modified, flags=re.IGNORECASE)
    # close file
    file.close()

print(f"\nORIGINAL TEXT:\n{original}")
print(f"MODIFIED TEXT:\n{modified}")
