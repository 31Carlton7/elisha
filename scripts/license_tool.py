from os import listdir
from os.path import isfile, join, dirname, relpath, isdir

curdir = dirname(__file__)
rootdir = relpath('../lib', curdir)

files = [f for f in listdir(rootdir) if isfile(join(rootdir, f))]


def getListOfFiles(dirName):
    # create a list of file and sub directories
    # names in the given directory
    listOfFile = listdir(dirName)
    allFiles = list()
    # Iterate over all the entries
    for entry in listOfFile:
        # Create full path
        fullPath = join(dirName, entry)
        # If entry is a directory then get the list of files in this directory
        if isdir(fullPath):
            allFiles = allFiles + getListOfFiles(fullPath)
        else:
            allFiles.append(fullPath)

    return allFiles


# GPL 3.0 License Header
license_text = "/*\nElisha iOS & Android App\nCopyright (C) 2022 Carlton Aikins\n\nThis program is free software: you can redistribute it and/or modify\nit under the terms of the GNU General Public License as published by\nthe Free Software Foundation, either version 3 of the License, or\nany later version.\n\nThis program is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\nGNU General Public License for more details.\n\nYou should have received a copy of the GNU General Public License\nalong with this program.  If not, see <https://www.gnu.org/licenses/>.\n*/"


def line_prepender(filename: str, line):
    # Add text to beginning of file,
    # and prevent rewriting of license.
    if filename[-5:] == ".dart":
        with open(filename, 'r+') as f:
            content = f.read()
            if content.find(license_text) == -1:
                f.seek(0, 0)
                f.write(line.rstrip('\r\n') + '\n\n' + content)

            f.close()


for file in getListOfFiles(rootdir):
    line_prepender(file, license_text)
