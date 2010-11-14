#! /usr/bin/env python

"""Keywords (from "graminit.c")

This file is automatically generated; please don't muck it up!

To update the symbols in this file, 'cd' to the top directory of
the python source tree after building the interpreter and run:

    python Lib/keyword.py
"""

__all__ = ["iskeyword", "kwlist"]

kwlist = [
#--start keywords--
        'and',
        'assert',
        'break',
        'class',
        'continue',
        'def',
        'del',
        'elif',
        'else',
        'except',
        'exec',
        'finally',
        'for',
        'from',
        'global',
        'if',
        'import',
        'in',
        'is',
        'lambda',
        'not',
        'or',
        'pass',
        'print',
        'raise',
        'return',
        'try',
        'while',
        'yield',
#--end keywords--
        ]

kwdict = {}
for keyword in kwlist:
    kwdict[keyword] = 1

iskeyword = kwdict.has_key

def main():
    import sys, re

    args = sys.argv[1:]
    iptfile = args and args[0] or "Python/graminit.c"
    if len(args) > 1: optfile = args[1]
    else: optfile = "Lib/keyword.py"

    # scan the source file for keywords
    fp = open(iptfile)
    strprog = re.compile('"([^"]+)"')
    lines = []
    while 1:
        line = fp.readline()
        if not line: break
        if line.find('{1, "') > -1:
            match = strprog.search(line)
            if match:
                lines.append("        '" + match.group(1) + "',\n")
    fp.close()
    lines.sort()

    # load the output skeleton from the target
    fp = open(optfile)
    format = fp.readlines()
    fp.close()

    # insert the lines of keywords
    try:
        start = format.index("#--start keywords--\n") + 1
        end = format.index("#--end keywords--\n")
        format[start:end] = lines
    except ValueError:
        sys.stderr.write("target does not contain format markers\n")
        sys.exit(1)

    # write the output file
    fp = open(optfile, 'w')
    fp.write(''.join(format))
    fp.close()

if __name__ == "__main__":
    main()
