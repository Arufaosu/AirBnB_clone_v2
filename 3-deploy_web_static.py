#!/usr/bin/python3
from fabric.api import env, local
from os.path import exists
from 1-pack_web_static import do_pack
from 2-do_deploy_web_static import do_deploy

env.hosts = ['<IP web-01>', '<IP web-02>']
env.user = 'ubuntu'
env.key_filename = '~/.ssh/my_ssh_private_key'

def deploy():
    """ creates and distributes an archive to your web servers """
    archive_path = do_pack()
    if not archive_path:
        return False
    return do_deploy(archive_path)

if __name__ == "__main__":
    result = deploy()
    if result:
        print("Deployment successful!")
    else:
        print("Deployment failed.")
