#!/bin/sh
echo "= nextcloud-sync UPLOADING MAP ="
echo "=== Settings ==="
echo "Nextcloud URL: $NEXTCLOUD_URL/$NEXTCLOUD_MODE$NEXTCLOUD_PATH"
echo "Nextcloud user: $NEXTCLOUD_USER"
echo "Map name: $WORLD_NAME"

# local variables
export datetimestamp=$(date '+%Y-%m-%dT%H%M')

echo "Create tar.gz of map $WORLD_NAME"
tar -v --create --gzip --file=$WORLD_NAME.$datetimestamp.tar.gz /config/worlds_local/$WORLD_NAME.db /config/worlds_local/$WORLD_NAME.fwl /config/valheimplus/valheim_plus.cfg

baseUrl=$NEXTCLOUD_URL/$NEXTCLOUD_MODE$NEXTCLOUD_PATH/$WORLD_NAME

url="$baseUrl/$datetimestamp.tar.gz"
echo "Upload map archive to $url"
curl -u $NEXTCLOUD_USER:$NEXTCLOUD_PASSWORD -T $WORLD_NAME.$datetimestamp.tar.gz $url

url="$baseUrl/latest_file.txt"
echo "Update latest_file.txt with $datetimestamp to $url"
echo $datetimestamp | curl -u $NEXTCLOUD_USER:$NEXTCLOUD_PASSWORD -T - $url

echo "Clean up"
rm $WORLD_NAME.$datetimestamp.tar.gz

echo "= nextcloud-sync UPLOADING finished ="
