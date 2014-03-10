#!/usr/bin/env python3
import re
import os,sys

import nose.tools as n

if os.path.split(os.getcwd())[-1] != 'wiki.thomaslevine.com':
    print('Run this with nose from the root of the wiki repository.')
    sys.exit(1)

@n.nottest
def test_directory_file_correspondence():
    '''
    Each top-level directory should have an associated
    top-level file, and vice-versa.
    '''
    exceptional_files = {'Makefile', 'index'}
    names = os.listdir()

    basenames = set(name.split('.')[0] for name in names if os.path.isfile(name))
    dirs = set(filter(os.path.isdir, names))

    n.assert_set_equal(basenames.difference(exceptional_files), dirs)

def test_sections_are_documented():
    '''
    Each top-level directory should be referenced in the
    documentation, and each directory referenced in the
    documentation should exist.
    '''
    in_index = set()
    with open('index.rst', 'r') as fp:
        for line in fp:
            a = re.match(r'^`/([^/]+)/ </([^/]+)/>`$', line)
            print(a)
    assert False
