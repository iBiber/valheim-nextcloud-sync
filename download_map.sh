#!/bin/sh
echo "= nextcloud-sync DOWNLOADING MAP ="
echo "=== Settings ==="
echo "Nextcloud URL: $NEXTCLOUD_URL/$NEXTCLOUD_MODE$NEXTCLOUD_PATH"
echo "Nextcloud user: $NEXTCLOUD_USER"
echo "Map name: $WORLD_NAME"

baseUrl="$NEXTCLOUD_USER:$NEXTCLOUD_PASSWORD $NEXTCLOUD_URL/$NEXTCLOUD_MODE$NEXTCLOUD_PATH/$WORLD_NAME"
url="$baseUrl/latest_file.txt"
echo "Get latest file name from: $url"
export datetimestamp=$(curl -u $url)

url="$baseUrl/$datetimestamp.tar.gz"
echo "Download map archive from: $url"
curl -u $NEXTCLOUD_USER:$NEXTCLOUD_PASSWORD $url > $WORLD_NAME.tar.gz

echo "Extract map archive to valheim-server"
tar -v --touch --overwrite --extract --gunzip --file=$WORLD_NAME.tar.gz

echo "Clean up"
rm $WORLD_NAME.tar.gz

echo "= nextcloud-sync DOWNLOADING MAP finished ="
