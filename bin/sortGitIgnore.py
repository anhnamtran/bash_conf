#!/usr/bin/env python3
HELP_DESC="""
Sorts a gitignore file based on the following priority:
1. Patterns
2. Hidden files
3. Regular files
4. Alphabetic
"""
import argparse
import sys
import os

def parse_args():
    parser = argparse.ArgumentParser(description=HELP_DESC)

    parser.add_argument(
        'file',
        type=str,
        action='store',
        help="The gitignore file path. '-' will read from stdin")
    parser.add_argument(
        '-O',
        '--outfile',
        type=str,
        action='store',
        help="Path of file to print results, defaults to stdout")

    return parser.parse_args()

def sort_gitignore(args: argparse.Namespace) -> None:
    open_files = []
    if args.file == '-':
        gitignore_file = sys.stdin
    else:
        if os.path.exists(args.file):
            gitignore_file = open(args.file, 'r')
            open_files.append(gitignore_file)
        else:
            print(f"File {args.file} not found", file=sys.stderr)
            sys.exit(1)

    dot_lines: set[ str ] = set()
    pattern_lines: set[ str ] = set()
    path_lines: set[ str ] = set()
    unknown_lines: set[ str ] = set()

    for line in gitignore_file.readlines():
        if line.startswith('.'):
            dot_lines.add(line)
        elif '*' in line:
            pattern_lines.add(line)
        elif '/' in line:
            path_lines.add(line)
        else:
            unknown_lines.add(line)

    if not args.outfile:
        outfile = sys.stdout
    else:
        outfile = open(args.outfile, 'w+')
        open_files.append(outfile)
    outfile.writelines(
        sorted(dot_lines) +
        sorted(pattern_lines) +
        sorted(path_lines) +
        sorted(unknown_lines)
    )

    for file in open_files:
        file.close()

if __name__ == '__main__':
    sort_gitignore(parse_args())
