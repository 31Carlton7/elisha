# Import dependencies
from subprocess import call
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


def commit_file(fileName: str):
    message = 'Update ' + fileName
    # Stage the file
    call('git add ' + fileName, shell=True)

    # Add your commit
    call('git commit -m "' + message + '"', shell=True)

    # Push the new or update files
    call('git push origin master -f', shell=True)


for file in getListOfFiles(rootdir):
    commit_file(file)
