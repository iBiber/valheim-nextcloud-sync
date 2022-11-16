#!/bin/sh
echo "= nextcloud-sync UPLOADING MAP ="
echo "=== Settings ==="
echo "Nextcloud URL: $NEXTCLOUD_URL/$NEXTCLOUD_MODE$NEXTCLOUD_PATH"
echo "Nextcloud user: $NEXTCLOUD_USER"
echo "Map name: $WORLD_NAME"

# local variables
export datetimestamp=$(date '+%d-%b-%YT%H%M')

echo "Create tar.gz of map $WORLD_NAME"
tar -v --create --gzip --file=$WORLD_NAME.$datetimestamp.tar.gz /config/worlds_local/$WORLD_NAME.db /config/worlds_local/$WORLD_NAME.fwl /config/valheimplus/valheim_plus.cfg

echo "Upload map archive to $NEXTCLOUD_URL/$NEXTCLOUD_MODE$NEXTCLOUD_PATH/$datetimestamp.tar.gz"
curl -u $NEXTCLOUD_USER:$NEXTCLOUD_PASSWORD -T $WORLD_NAME.$datetimestamp.tar.gz $NEXTCLOUD_URL/$NEXTCLOUD_MODE$NEXTCLOUD_PATH/$datetimestamp.tar.gz

echo "Update latest_file.txt with $datetimestamp to $NEXTCLOUD_URL/$NEXTCLOUD_MODE$NEXTCLOUD_PATH/latest_file.txt"
echo $datetimestamp | curl -u $NEXTCLOUD_USER:$NEXTCLOUD_PASSWORD -T - $NEXTCLOUD_URL/$NEXTCLOUD_MODE$NEXTCLOUD_PATH/latest_file.txt

echo "Clean up"
rm $WORLD_NAME.$datetimestamp.tar.gz

echo "= nextcloud-sync UPLOADING finished ="
