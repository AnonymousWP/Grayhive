from dotenv import load_dotenv
load_dotenv()

import os
basedir = os.path.abspath(os.path.dirname(__file__))

class Config(object):
    API_KEY=os.environ.get('HIVE_SECRET_KEY')
    HIVE_URL=os.environ.get('HIVE_URL')
    LOG_FILE='/graylog2thehive/graylog2thehive.log'
    GRAYLOG_URL=os.environ.get('GRAYLOG_URL')
