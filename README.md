# Description
This guide can be used to synchronize a valheim map with a Nextcloud instance.
The map of the valheim-server instance is uploaded to the nextcloud share when the valheim-server is stopped (e.g. via `docker-compose down`) and downloaded before it is started (e.g. via `docker-compose up -d`).

# Preparation
1. Prepare a public shared folder with a password in the nextcloud where the valheim server map will be uploaded. Alternatively a real user/password from the nextcloud can be used.
2. Use and setup the Docker valheim server https://hub.docker.com/r/lloesche/valheim-server

# Install the event hook scripts
1. Copy the `upload_map.sh` and `download_map.sh` scripts an own folder (e.g. `nextcloud-sync`)
2. Add the settings from the `nextcloud-sync-valheim.env.template` to the `valheim.env` and set the values.
3. In `docker-compose.yaml`
Add a volume mount to the `nextcloud-sync`:
```
services:
  valheim:
    volumes:
      - <full path to the nextcloud-sync script folder>:/nextcloud-sync
```

# Attention
It may happen that the map status gets lost if the upload fails and the next server start restores an old status.

# How it works
After the valheim-server shutdown is finished:
* archives the map and valheimplus config
* uploads the archive to the nextcloud
* updates the `latest_files.txt` to the nextcloud

Before the valheim-server is started:
* downloads the latest map archive with the help of the `latest_files.txt`
* extracts the map from the archive
