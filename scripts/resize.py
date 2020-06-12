import sys
import os
import sys
from PIL import Image

def main():
    filename = sys.argv[1]

    imageFolder = 'assets/comics'
    resizeFactor = '20'

    def resize(folder, fileName, factor):
        filePath = os.path.join(folder, fileName)
        im = Image.open(filePath)
        w, h  = im.size
        newIm = im.resize((int(w*factor), int(h*factor)), Image.ANTIALIAS)
        # i am saving a copy, you can overrider orginal, or save to other folder
        savePath = os.path.join(folder, 'lowres', fileName)
        newIm.save(savePath, quality=100)

    def bulkResize(imageFolder, factor):
        imgExts = ["png", "bmp", "jpg"]
        print(imageFolder)
        for path, dirs, files in os.walk(imageFolder):
            for fileName in files:
                ext = fileName[-3:].lower()
                if ext not in imgExts:
                    continue

                resize(path, fileName, factor)

    resizeFactor=float(resizeFactor)/100.0# 2nd is resize in %
    # bulkResize(imageFolder, resizeFactor)

    resize('assets/comics', filename, resizeFactor)

if __name__ == "__main__":
    main()

