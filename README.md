## What do we have here?
A docker image to run [aceproxy](https://github.com/ValdikSS/aceproxy).

As a result, you will be able to watch AceStream live content without having AcePlayer and other dependencies installed locally.

## How to use
1. Download image
```
docker pull michalzielanski/aceproxy:0.9.1-1
```

2. Run image
```
docker run --name aceproxy --detach --publish 8000:8000 michalzielanski/aceproxy:0.9.1-1
```

3. Open stream in VLC
```
vlc http://[SERVER_IP]:8000/pid/{channel_id}/stream.mp4
```

