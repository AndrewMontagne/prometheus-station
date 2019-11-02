1>2# : ^
'''
@echo off
WHERE python >nul 2>nul
IF %ERRORLEVEL% NEQ 0 ECHO You don't appear to have python installed, go get Python 3.5 or newer! && PAUSE && EXIT /b
python -x "%~f0" %*
exit /b
rem ^
'''

import sys

if sys.version_info < (3, 5):
    print("Python 3.5 or newer is required!")
    exit(-1)

import os, re, hashlib, datetime, time

def listchunks(l, n):
    """Yield successive n-sized chunks from l."""
    for i in range(0, len(l), n):
        yield l[i:i + n]

def baseN(num,b = 52,numerals="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"):
    return ((num == 0) and numerals[0]) or (baseN(num // b, b, numerals).lstrip(numerals[0]) + numerals[num % b])

def base52(num):
    out = baseN(num)
    return 'aaa'[:-len(out)] + out

def hashtobase52(data):
    data = data.encode('utf-8')
    return base52(int(data, 16) % 65533)

def debug(s):
    if(False):
        print(s)

def die(s):
    print('\n\nERROR: ' + s)
    input("\nPress Enter to continue...")
    exit(1)

def mapmerge(filepath):
    hashLength = 0
    mapwidth = 0
    tiles = {}
    maps = {}
    currentMap = ""

    DETERMINE_NEXT = 0
    PARSE_TILES = 1
    PARSE_MAP_HEADER = 2
    PARSE_MAP_BODY = 3
    state = DETERMINE_NEXT

    tilesRegex = re.compile('"([^"]+)" ?= ?\((.+)\)')
    mapHeaderRegex = re.compile('\(([^)]+)\) = {"')
    nonQuotedSpacesRegex = re.compile('\s+(?=([^"]*"[^"]*")*[^"]*$)')

    print('Merging ' + filepath, end='')

    with open(filepath) as fp:

        # PARSE MAP
        while True:
            try:
                line = fp.readline()
            except UnicodeDecodeError:
                die("This does not appear to be a *.dmm!")

            if line is '':
                break

            if line[:2] == '//' or line[:1] == '#':
                continue
            line = line.rstrip()

            if line is '' or line is '"}':
                if len(tiles) > 0:
                    state = DETERMINE_NEXT
                continue

            if state == DETERMINE_NEXT:
                if line[:1] == '"':
                    state = PARSE_TILES
                elif line[:1] == '(':
                    state = PARSE_MAP_HEADER

            if state == PARSE_TILES:
                match = tilesRegex.match(line)

                if match is None:
                    die("Could not parse tile: '" + line + "'")

                oldhash = match.group(1)
                if hashLength is 0:
                    hashLength = len(oldhash)
                data = match.group(2)
                data = nonQuotedSpacesRegex.sub('', data)
                area = data.split(',')[-1]
                tiles[oldhash] = {"oldhash" : oldhash, "data": data, "area": area, "count": 0}

            elif state == PARSE_MAP_HEADER:
                match = mapHeaderRegex.match(line)

                if match is None:
                    die("Could not parse map header: '" + line + "'")

                currentMap = match.group(1)
                maps[currentMap] = []
                state = PARSE_MAP_BODY
                print('.', end='', flush=True)

            elif state == PARSE_MAP_BODY:
                if mapwidth == 0:
                    mapwidth = len(line) // hashLength
                if len(line) > hashLength:
                    split = [line[i:i+hashLength] for i in range(0, len(line), hashLength)]
                    for hsh in split:
                        tiles[hsh]['count'] += 1
                    maps[currentMap].extend(split)

        # HASH TILES
        sortedtiles = sorted(tiles.values(), key=lambda i: len(i['data']))
        sortedtiles = sorted(sortedtiles, key= lambda i: i['count'], reverse=True)
        newhashes = set()
        oldtonew = {}
        for tile in sortedtiles:
            data = tile['data']
            while True:
                md5 = hashlib.sha1(data.encode('utf-8')).hexdigest()
                newhash = hashtobase52(md5)
                if newhash not in newhashes:
                    break
                data += 'a'
            newhashes.add(newhash)
            oldtonew[tile['oldhash']] = newhash
            tile['newhash'] = newhash

        sortedtiles = sorted(sortedtiles, key=lambda i: (i['area'], i['data']))
        print('.', end='', flush=True)

        # SET TILES
        for map, maptiles in maps.items():
            max = len(maptiles)
            for i in range(0, max):
                oldtile =  maptiles[i]
                newtile = oldtonew[oldtile]
                if oldtile is not newtile:
                    maptiles[i] = newtile

        print('.', end='', flush=True)

        # OUTPUT MAPS

        if len(sortedtiles) < 10:
            die("This does not appear to be a *.dmm!")

        with open(filepath, 'w') as out:
            out.write('// Merged at ' + datetime.datetime.now().strftime("%c") + '\n')

            lastarea = None
            for tile in sortedtiles:
                if tile['area'] != lastarea:
                    if lastarea is not None:
                        out.write('// END AREA: ' + lastarea + '\n')
                    lastarea = tile['area']
                    out.write('\n// BEGIN AREA: ' + lastarea + '\n')
                out.write('"' + tile['newhash'] + '"=(' + tile['data'] + ')\n')
            print('.', end='', flush=True)

            for map, maptiles in maps.items():
                out.write('\n')
                out.write('(' + map + ') = {"\n')

                chunks = listchunks(maptiles, mapwidth)
                for chunk in chunks:
                    out.write(''.join(chunk) + "\n")

                out.write('"}\n')
                print('.', end='', flush=True)

        print('done! ' + str(len(sortedtiles)) + ' tiles in map.')

if len(sys.argv) <= 1:
    print('Usage: Drag one or more *.dmm files onto this batch file to mapmerge them!')
    input("\nPress Enter to continue...")
else:
    for arg in sys.argv[1:]:
        mapmerge(arg)

    print('\nAll tasks complete, closing in 5 seconds', end='', flush=True)
    for i in range(0,5):
        print('.', end='', flush=True)
        time.sleep(1)
    print('.')