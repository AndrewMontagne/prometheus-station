import os, datetime, subprocess

print('// BEGIN_ENV_VARS')

for key in os.environ:
	print('#define ENV_%s "%s"' % (key.upper(), os.environ[key].replace('"', '\\"').replace('\n', '\\n')))

print('#define ENV_BUILD_TIME %s' % datetime.datetime.now().isoformat())

print('// END_ENV_VARS\n\n')
