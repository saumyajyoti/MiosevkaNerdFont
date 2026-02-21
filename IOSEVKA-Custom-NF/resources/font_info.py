import os
import sys
from fontTools.ttLib import TTFont

folder = sys.argv[1] if len(sys.argv) > 1 else "."

for filename in sorted(os.listdir(folder)):
    if filename.lower().endswith((".ttf", ".otf")):
        path = os.path.join(folder, filename)
        font = TTFont(path)
        print(f"{filename}")
        print(f"  sTypoAscender:  {font['OS/2'].sTypoAscender}")
        print(f"  sTypoDescender: {font['OS/2'].sTypoDescender}")
        print(f"  italicAngle:    {font['post'].italicAngle}")
        print(f"  unitsPerEm:     {font['head'].unitsPerEm}")
