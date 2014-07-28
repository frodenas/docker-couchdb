#!/bin/bash
USER=${COUCHDB_USERNAME:-couchdb}
PASS=${COUCHDB_PASSWORD:-$(pwgen -s -1 16)}
DB=${COUCHDB_DBNAME:-}

# Start CouchDB service
/usr/local/bin/couchdb -b
while ! nc -vz localhost 5984; do sleep 1; done

# Create User
echo "Creating user: \"$USER\"..."
curl -X PUT http://127.0.0.1:5984/_config/admins/$USER -d '"'${PASS}'"'

# Create Database
if [ ! -z "$DB" ]; then
    echo "Creating database: \"$DB\"..."
    curl -X PUT http://$USER:$PASS@127.0.0.1:5984/$DB
fi

# Stop CouchDB service
/usr/local/bin/couchdb -d

echo "========================================================================"
echo "CouchDB User: \"$USER\""
echo "CouchDB Password: \"$PASS\""
if [ ! -z "$DB" ]; then
    echo "CouchDB Database: \"$DB\""
fi
echo "========================================================================"

rm -f /.firstrun
