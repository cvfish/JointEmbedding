#!/usr/bin/python3
# -*- coding: utf-8 -*-

import os
import sys
import datetime
from functools import partial
from multiprocessing.dummy import Pool
from subprocess import call


BASE_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.dirname(BASE_DIR))
from global_variables import *

report_step = 100

newer_blender_executable_path = '/home/adrian/blender-2.78/blender'

if __name__ == '__main__':
    if not os.path.exists(g_lfd_images_folder):
        os.mkdir(g_lfd_images_folder)

    shape_list = [line.strip().split(' ') for line in open(g_shape_list_file, 'r')]
    print(len(shape_list), ' shapes are going to be rendered!')

    # print('Generating rendering commands...', end = '')
    commands = []
    for shape_property in shape_list:
        shape_synset = shape_property[0]
        shape_md5 = shape_property[1]
        shape_file = os.path.join(g_shapenet_root_folder, shape_synset, shape_md5, 'model.obj')

        command = '%s ../remeshing.blend --background --python process_geometry_single_shape.py -- %s %s %s ' % (newer_blender_executable_path, shape_file, shape_synset, shape_md5)
        if len(shape_list) > 32:
            command += ' > /dev/null 2>&1'
        commands.append(command)

        # print(command)
        # break # BORRAR, solo para debugar
    print('done(%d commands)'%(len(commands)))


    print('Processing meshes, it takes long time...')
    pool = Pool(g_lfd_rendering_thread_num)
    for idx, return_code in enumerate(pool.imap(partial(call, shell=True), commands)):
        if idx % report_step == 0:
            print('[%s] Mesh processing command %d of %d' % (datetime.datetime.now().time(), idx, len(shape_list)))
        if return_code != 0:
            print('Mesh processing command %d of %d (\"%s\") failed' % (idx, len(shape_list), commands[idx]))
