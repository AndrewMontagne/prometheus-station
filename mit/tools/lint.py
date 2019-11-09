import glob, os, re

regex = re.compile("'([\w\d_-]+\.[\w\d_-]+)'")
filematch = {}
def find_file(search):
    if search in filematch:
        return filematch[search]
    for filename in glob.iglob('**', recursive=True):
        if filename.lower().endswith('/' + search.lower()):
            filematch[search] = filename
            return filename
    
    print('Could not find ' + search)
    filematch[search] = None
    return None


for filename in glob.iglob('**', recursive=True):
    if os.path.isfile(filename) and (filename.endswith('.dm') or filename.endswith('.dmm')): # filter dirs
        edited = False
        with open(filename, 'r') as readfile:
            file = readfile.read()
            matches = regex.findall(file)
            for match in matches:
                find = find_file(match)
                if find is not None:
                    file = file.replace("'" + match + "'", "'" + find + "'")
                    edited = True
        
        if edited:
            print(filename)
            with open(filename, 'w') as writefile:
                writefile.write(file)

        