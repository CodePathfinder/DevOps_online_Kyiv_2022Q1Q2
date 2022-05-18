"""parse user’s input text and replace some emotions with emoji’s"""

from emoji import emojize
from emotion_dicts import emoj_dict, kw_dict
import re

test = True
while test:
    # prompt for input emotional phrase
    inputtext = input(
        "Enter a text expressing the feelings (happy, surprised, scared, etc): "
    )
    converted_text = inputtext
    # iterate over the key-words form kw_dict;
    # if found in the original text, it is substituted with the corresponding emoji
    for k in kw_dict:
        pattern = f"\\b{k}\\b"
        converted_text = re.sub(
            pattern,
            emojize(emoj_dict[kw_dict[k]]),
            converted_text,
            flags=re.IGNORECASE
        )
    # check if any substitution took place
    if id(converted_text) == id(inputtext):
        # if not, offer to repeate
        play = input("\nNo emotions recognized, sorry. Try again? [Y/n]: ")
        test = True if play.lower() in ["", "y", "yes"] else False
    else:
        # break the loop and out put results
        test = False
        print("\nYou have entered:  ", inputtext)
        print("-" * (len(inputtext.strip()) + 20))
        print("Modified text:     ", converted_text)
        print()
