#!/usr/bin/python3
# -*- coding: utf-8 -*-

"""
@author: lzp
@contact: liuzhangpei@126.com
"""

if __name__ == '__main__':
    with open('requirements.txt') as fp:
        line_list = []
        for line in fp.readlines():
            line = line.rstrip("\n")
            line_node = line.split('==')[0]
            if line_node not in line_list:
                line_list.append(line_node)
            else:
                print(line_node)