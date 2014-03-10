#!/usr/bin/env python3
import os,sys
import nose.tools as n

if os.path.split(os.getcwd())[-1] != 'wiki.thomaslevine.com':
    print('Run this with nose from the root of the wiki repository.')
    sys.exit(1)

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
