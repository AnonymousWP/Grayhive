import os
basedir = os.path.abspath(os.path.dirname(__file__))

class Config(object):
    API_KEY=os.environ.get('HIVE_SECRET_KEY')
    HIVE_URL=''
    LOG_FILE='/var/log/graylog2thehive.log'
    GRAYLOG_URL=''
