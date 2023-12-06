#!/usr/bin/python3
from fabric.api import local
from datetime import datetime
import os

def do_pack():
    """ generates a .tgz archive from the contents of the web_static folder """
    try:
        local("mkdir -p versions")

        now = datetime.utcnow()
        time_format = "%Y%m%d%H%M%S"
        archive_name = "web_static_{}.tgz".format(now.strftime(time_format))

        local("tar -cvzf versions/{} web_static".format(archive_name))
        return os.path.join("versions", archive_name)
    except Exception as e:
        return None
