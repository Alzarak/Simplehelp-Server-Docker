#!/bin/bash
chown -R simplehelpuser:simplehelpuser /opt/SimpleHelp
gosu simplehelpuser /opt/SimpleHelp/serverstart.sh
exec gosu simplehelpuser tail -f /dev/null
