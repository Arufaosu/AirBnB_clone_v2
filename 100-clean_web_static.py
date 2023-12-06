#!/usr/bin/python3
from fabric.api import env, run, local
from datetime import datetime
from os.path import exists
from os import listdir

env.hosts = ['<IP web-01>', '<IP web-02>']
env.user = 'ubuntu'
env.key_filename = '~/.ssh/my_ssh_private_key'

def do_clean(number=0):
    """ deletes out-of-date archives """
    number = int(number)
    local_archives = local("ls -1t versions", capture=True).split('\n')
    local_archives_to_keep = local_archives[:number]

    for archive in local_archives:
        if archive not in local_archives_to_keep:
            local("rm versions/{}".format(archive))

    with cd('/data/web_static/releases'):
        remote_archives = run("ls -1t").split('\n')

    remote_archives_to_keep = remote_archives[:number]

    for archive in remote_archives:
        if archive not in remote_archives_to_keep:
            run("rm -rf /data/web_static/releases/{}".format(archive))

if __name__ == "__main__":
    pass
