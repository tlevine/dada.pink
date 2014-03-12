#!/usr/bin/env python3
import re
import os,sys

import nose.tools as n

exceptional_basenames = {'Makefile', 'index', ''} # dotfiles
exceptional_directories = {'.git','a'} # a for the Amtrak thing because I linked to it

if os.path.split(os.getcwd())[-1] != 'wiki.thomaslevine.com':
    print('Run this with nose from the root of the wiki repository.')
    sys.exit(1)

def test_directory_file_correspondence():
    '''
    Each top-level directory should have an associated
    top-level file, and vice-versa.
    '''
    names = os.listdir()

    basenames = set(name.split('.')[0] for name in names if os.path.isfile(name))
    dirs = set(filter(os.path.isdir, names))

    n.assert_set_equal(basenames.difference(exceptional_basenames),
                       dirs.difference(exceptional_directories))

def check_sections_are_documented(directory):
    '''
    Each top-level directory should be referenced in the
    documentation, and each directory referenced in the
    documentation should exist.
    '''

    fn = 'index.rst' if directory == '.' else directory + '.rst'
    in_index = set()
    if os.path.isfile(fn):
        # In the documentation
        with open(fn, 'r') as fp:
            for line in fp:
                m = re.match(r'^`/([^/]+)/ </([^/]+)/>`_$', line)
                if m:
                    n.assert_equal(m.group(1), m.group(2))
                    in_index.add(m.group(1))

        # In the filesystem
        dirs = set(filter(os.path.isdir, os.listdir(directory)))

        # Documentation and filesystem should match.
        n.assert_set_equal(in_index, dirs.difference(exceptional_directories))

def test_sections_are_documented():
    for directory in filter(os.path.isdir, os.listdir()):
        yield check_sections_are_documented, directory
