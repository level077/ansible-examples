#!/bin/env python
import os
import subprocess

descriptors = list()

def get_rt(name):
    try:
        r = subprocess.Popen("tcprstat --no-header  -t {{ refresh }} -p {{ port }} |awk '{print $5}'",shell=True,stdout=subprocess.PIPE)
        rt1 = r.stdout.read().strip()
        rt = float(rt1) 
    except Exception:
        print "something is wrong"    
    return rt

def metric_init(params):
    global descriptors

    d1 = {'name': 'rt_{{ port }}',
        'call_back': get_rt,
        'time_max': 90,
        'value_type': 'float',
        'units': 'us',
        'slope': 'both',
        'format': '%.3f',
        'description': ' {{ port }} RT ',
        'groups':'{{ port }} RT' }

    descriptors = [d1]
    return descriptors

def metric_cleanup():
    '''Clean up the metric module.'''
    pass


if __name__ == '__main__':
    metric_init(None)
    while True:
        try:
            for d in descriptors:
                v = d['call_back'](d['name'])
                print 'value for %s is %.3f' % (d['name'], v)
        except KeyboardInterrupt:
            os._exit(1)
