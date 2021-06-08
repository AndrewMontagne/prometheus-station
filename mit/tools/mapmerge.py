import sys, os, re, hashlib, datetime, time, math

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

def version():
    return "1.2"

def mapmerge(filepath, test_only=False):
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

    skip = False
    loadprog = 0

    with open(filepath) as fp:

        lineNum = 0
        # PARSE MAP
        while True:
            try:
                line = fp.readline()
            except UnicodeDecodeError:
                print(filepath + " does not appear to be a *.dmm!", flush=True)
                skip = True
                break

            lineNum += 1

            if lineNum is 1:
                if test_only:
                    if line.startswith("// Merged with version " + version()):
                        print(filepath + ' is merged.', flush=True)
                        skip = True
                        break
                    else:
                        print(filepath + " needs map merging!", flush=True)
                        exit(1)
                else:
                    if line.startswith("// Merged with version " + version()):
                        print(filepath + " does not need merging!", flush=True)
                        skip = True
                        break
                    else:
                        print('Merging ' + filepath + '...', end='', flush=True)

            if lineNum / 1000 > loadprog:
                print('.', end='', flush=True)
                loadprog += 1

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
                    print("Could not parse tile: '" + line + "'", flush=True)
                    skip = True
                    break

                oldhash = match.group(1)
                if hashLength is 0:
                    hashLength = len(oldhash)
                data = match.group(2)
                area = data.split(',')[-1]
                tiles[oldhash] = {"oldhash" : oldhash, "data": data, "area": area, "count": 0}

            elif state == PARSE_MAP_HEADER:
                match = mapHeaderRegex.match(line)

                if match is None:
                    print("Could not parse map header: '" + line + "'", flush=True)
                    skip = True
                    break

                currentMap = match.group(1)
                maps[currentMap] = []
                state = PARSE_MAP_BODY

            elif state == PARSE_MAP_BODY:
                if mapwidth == 0:
                    mapwidth = math.floor(len(line) / hashLength)
                if len(line) >= mapwidth * hashLength:
                    split = [line[i:i+hashLength] for i in range(0, len(line), hashLength)]
                    for hsh in split:
                        tiles[hsh]['count'] += 1
                    maps[currentMap].extend(split)

        if skip:
            return

        # HASH TILES
        sortedtiles = sorted(tiles.values(), key=lambda i: len(i['data']))
        sortedtiles = sorted(sortedtiles, key= lambda i: i['count'], reverse=True)
        newhashes = set()
        oldtonew = {}
        lineNum = 0
        loadprog = 0
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
            lineNum += 1
            if lineNum / 1000 > loadprog:
                print('.', end='', flush=True)
                loadprog += 1

        sortedtiles = sorted(sortedtiles, key=lambda i: (i['area'], i['data']))
        print('.', end='', flush=True)

        # SET TILES
        lineNum = 0
        loadprog = 0
        for map, maptiles in maps.items():
            max = len(maptiles)
            for i in range(0, max):
                oldtile =  maptiles[i]
                newtile = oldtonew[oldtile]
                if oldtile is not newtile:
                    maptiles[i] = newtile
                lineNum += 1
                if lineNum / 10000 > loadprog:
                    print('.', end='', flush=True)
                    loadprog += 1

        # OUTPUT MAPS

        if len(sortedtiles) < 2:
            print("\nFATAL: " + filepath + " only has one tile!")
            return

        with open(filepath, 'w') as out:
            out.write('// Merged with version ' + version() + ' at ' + datetime.datetime.now().strftime("%c") + '\n')

            lastarea = None
            for tile in sortedtiles:
                if tile['area'] != lastarea:
                    if lastarea is not None:
                        out.write('// END AREA: ' + lastarea + '\n')
                        out.flush()
                    lastarea = tile['area']
                    out.write('\n// BEGIN AREA: ' + lastarea + '\n')
                out.write('"' + tile['newhash'] + '" = (' + tile['data'] + ')\n')
            print('.', end='', flush=True)

            out.write('// END AREA: ' + lastarea + '\n')

            for map, maptiles in maps.items():
                z_level = map.split(',')[2]
                out.write('\n//BEGIN Z-LEVEL ' + str(z_level) + '\n')
                out.write('(' + map + ') = {"\n')

                chunks = listchunks(maptiles, mapwidth)
                for chunk in chunks:
                    out.write(''.join(chunk) + "\n")

                out.write('"}\n')
                out.write('//END Z-LEVEL ' + str(z_level) + '\n')
                out.flush()
                print('.', end='', flush=True)

        print('done! ' + str(len(sortedtiles)) + ' tiles in map.')

maps = []
test_only = False

for arg in sys.argv[1:]:
    if arg.startswith('--'):
        if arg == '--test-only':
            test_only = True
    else:
        maps.append(arg)

for map_path in maps:
	mapmerge(map_path, test_only)
