"""display current date and time"""

from datetime import datetime

now = datetime.now()

print()
print("CURRENT DATE: ", now.strftime("%d %b %Y"))
print("CURRENT TIME: ", now.strftime("%H:%M:%S"))
print()
