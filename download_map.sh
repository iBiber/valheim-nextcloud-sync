#!/bin/sh
echo "= nextcloud-sync DOWNLOADING MAP ="
echo "=== Settings ==="
echo "Nextcloud URL: $NEXTCLOUD_URL/$NEXTCLOUD_MODE$NEXTCLOUD_PATH"
echo "Nextcloud user: $NEXTCLOUD_USER"
echo "Map name: $WORLD_NAME"

echo "Get latest file name from: $NEXTCLOUD_URL/$NEXTCLOUD_MODE$NEXTCLOUD_PATH/latest_file.txt"
export datetimestamp=$(curl -u $NEXTCLOUD_USER:$NEXTCLOUD_PASSWORD $NEXTCLOUD_URL/$NEXTCLOUD_MODE$NEXTCLOUD_PATH/latest_file.txt)

echo "Download map archive from: $NEXTCLOUD_URL/$NEXTCLOUD_MODE$NEXTCLOUD_PATH/$datetimestamp.tar.gz"
curl -u $NEXTCLOUD_USER:$NEXTCLOUD_PASSWORD $NEXTCLOUD_URL/$NEXTCLOUD_MODE$NEXTCLOUD_PATH/$datetimestamp.tar.gz > $WORLD_NAME.tar.gz

echo "Extract map archive to valheim-server"
tar -v --touch --overwrite --extract --gunzip --file=$WORLD_NAME.tar.gz

echo "Clean up"
rm $WORLD_NAME.tar.gz

echo "= nextcloud-sync DOWNLOADING MAP finished ="