import sys, os, re, hashlib, datetime

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
    return base52(int(data, 16) % 65535)

def debug(s):
    if(False):
        print(s)

def mapmerge(filepath):
    hashLength = 0
    mapwidth = 0
    tiles = {}
    maps = {}
    currentMap = ""

    PARSE_TILES = 1
    PARSE_MAP_HEADER = 2
    PARSE_MAP_BODY = 3
    state = PARSE_TILES

    tilesRegex = re.compile('"([^"]+)" = (.+)')
    mapHeaderRegex = re.compile('\(([^)]+)\) = {"')

    print('Merging ' + filepath, end='')

    with open(filepath) as fp:

        # PARSE MAP
        while True:
            line = fp.readline()
            if line is '':
                break
            line = line.rstrip()

            if line is '' or line is '"}':
                state = PARSE_MAP_HEADER
                continue

            elif state == PARSE_TILES:
                match = tilesRegex.match(line)

                if match is None:
                    print("Could not parse tile: '" + line + "'")
                    sys.exit(1)
                    continue

                oldhash = match.group(1)
                if hashLength is 0:
                    hashLength = len(oldhash)
                data = match.group(2)
                tiles[oldhash] = {"oldhash" : oldhash, "data": data}

            elif state == PARSE_MAP_HEADER:
                match = mapHeaderRegex.match(line)

                if match is None:
                    print("Could not parse map header: '" + line + "'")
                    sys.exit(1)
                    continue

                currentMap = match.group(1)
                maps[currentMap] = []
                state = PARSE_MAP_BODY
                print('.', end='', flush=True)

            elif state == PARSE_MAP_BODY:
                if mapwidth == 0:
                    mapwidth = len(line) // hashLength
                if len(line) > hashLength:
                    maps[currentMap].extend([line[i:i+hashLength] for i in range(0, len(line), hashLength)])

        # HASH TILES
        newhashes = set()
        for oldhash, tile in tiles.items():
            data = tile['data']
            while True:
                md5 = hashlib.sha1(data.encode('utf-8')).hexdigest()
                newhash = hashtobase52(md5)
                if newhash not in newhashes:
                    break
                data += 'a'
            newhashes.add(newhash)
            tile['newhash'] = newhash

        print('.', end='', flush=True)

        # SET TILES
        for map, maptiles in maps.items():
            max = len(maptiles)
            for i in range(0, max):
                oldtile =  maptiles[i]
                newtile = tiles[oldtile]['newhash']
                if oldtile is not newtile:
                    maptiles[i] = newtile

        print('.', end='', flush=True)

        # OUTPUT MAPS
        with open(filepath, 'w') as out:
            out.write('// Merged from ' + filepath + ' at ' + datetime.datetime.now().strftime("%c") + '\n\n')

            for oldhash, tile in tiles.items():
                out.write('"' + tile['newhash'] + '" = ' + tile['data'] + '\n')
            print('.', end='', flush=True)

            for map, maptiles in maps.items():
                out.write('\n')
                out.write('(' + map + ') = {"\n')

                chunks = listchunks(maptiles, mapwidth)
                for chunk in chunks:
                    out.write(''.join(chunk) + "\n")

                out.write('"}\n')
                print('.', end='', flush=True)

        print('done!')

for arg in sys.argv[1:]:
    mapmerge(arg)