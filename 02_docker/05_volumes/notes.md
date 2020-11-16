## Volumes

Volumes are mechanisms to persist data out of the running container, separating the life cycle of the container from the data.

While bind mounts are dependent on the directory structure and OS of the host machine, __volumes are completely managed by Docker__. Volumes have several advantages over bind mounts:

* Volumes are easier to back up or migrate than bind mounts.
* You can manage volumes using Docker CLI commands or the Docker API.
* Volumes work on both Linux and Windows containers.
* Volumes can be more safely shared among multiple containers.
* Volume drivers let you store volumes on remote hosts or cloud providers, to encrypt the contents of volumes, or to add other functionality.
* New volumes can have their content pre-populated by a container.
* Volumes on Docker Desktop have much higher performance than bind mounts from Mac and Windows hosts.

Volumes are often a better choice than persisting data in a container’s writable layer, because a volume does not increase the size of the containers using it, and the volume’s contents exist outside the lifecycle of a given container.

### Choose the -v or --mount flag

In general, `--mount` is more explicit and verbose. The biggest difference is that the `-v` syntax combines all the options together in one field, while the `--mount` syntax separates them. Here is a comparison of the syntax for each flag.

To specify volume driver options, you must use `--mount`


* `-v` or `--volume`: Consists of three fields, separated by colon characters (:). The fields must be in the correct order, and the meaning of each field is not immediately obvious.
    - In the case of named volumes, the first field is the name of the volume, and is unique on a given host machine. For anonymous volumes, the first field is omitted.
    - The second field is the path where the file or directory are mounted in the container.
    - The third field is optional, and is a comma-separated list of options, such as ro. These options are discussed below.

* `--mount`: Consists of multiple key-value pairs, separated by commas and each consisting of a <key>=<value> tuple. The `--mount` syntax is more verbose than `-v` or `--volume`, but the order of the keys is not significant, and the value of the flag is easier to understand.
    - The `type` of the mount, which can be `bind`, `volume`, or `tmpfs`. This topic discusses volumes, so the type is always volume.
    - The `source` of the mount. For named volumes, this is the name of the volume. For anonymous volumes, this field is omitted. May be specified as `source` or `src`.
    - The `destination` takes as its value the path where the file or directory is mounted in the container. May be specified as `destination`, `dst`, or `target`.
    - The `readonly` option, if present, causes the bind mount to be mounted into the container as read-only.
The volume-opt option, which can be specified more than once, takes a key-value pair consisting of the option name and its value.

### Differences between -v and --mount behavior

As opposed to bind mounts, all options for volumes are available for both `--mount` and `-v` flags.

## Create and manage volumes

#### Create a volume 

```bash
$ docker volume create test-vol
```

#### List volumes

```bash
$ docker volume ls 
```

#### Inspect a volume:

```bash
$ docker volume inspect test-vol
[
    {
        "CreatedAt": "2020-11-11T09:43:37Z",
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/test-vol/_data",
        "Name": "test-vol",
        "Options": {},
        "Scope": "local"
    }
]
```

#### Remove a volume:

```bash
$ docker volume rm test-vol
```

## Start a container with a volume

If you start a container with a volume that does not yet exist, Docker creates the volume for you.

```bash
# mount syntax
$ docker run -d \
  --name mynginx \
  --mount source=myvol,target=/app \
  nginx:latest
```

```bash
# -v syntax
$ docker run -d \
  --name mynginx \
  -v myvol:/app \
  nginx:latest
```

```bash
$ docker inspect mynginx
"Mounts": [
            {
                "Type": "volume",
                "Name": "myvol",
                "Source": "/var/lib/docker/volumes/myvol/_data",
                "Destination": "/app",
                "Driver": "local",
                "Mode": "z",
                "RW": true,
                "Propagation": ""
              }
        ]
```

## Populate a volume using a container

If you start a container which creates a new volume, and the container has files or directories in the directory to be mounted, the directory’s contents are copied into the volume. The container then mounts and uses the volume, and other containers which use the volume also have access to the pre-populated content.

For example, we can do this:

```bash
# mount
$ docker run -d \
  --name=nginxtest \
  --mount source=nginx-vol,destination=/usr/share/nginx/html \
  nginx:latest
```

```bash
# -v
$ docker run -d \
  --name=nginxtest \
  -v nginx-vol:/usr/share/nginx/html \
  nginx:latest
```

Now that we have a container that populates a volume, let's check that we have access from other container

```bash
$ docker run -v nginx-vol:/usr -it busybox
Unable to find image 'busybox:latest' locally
latest: Pulling from library/busybox
9758c28807f2: Pull complete 
Digest: sha256:a9286defaba7b3a519d585ba0e37d0b2cbee74ebfe590960b0b1d6a5e97d1e1d
Status: Downloaded newer image for busybox:latest
/ # ls
bin   dev   etc   home  proc  root  sys   tmp   usr   var
/ # ls usr
50x.html    index.html
/ # cat usr/index.html
```

## Use a read-only volume

For some development applications, the container needs to write into the bind mount so that changes are propagated back to the Docker host. At other times, the container only needs read access to the data. Remember that multiple containers can mount the same volume, and it can be mounted read-write for some of them and read-only for others, at the same time.

```bash
# mount
$ docker run -d \
  --name=nginxtest \
  --mount source=nginx-vol,destination=/usr/share/nginx/html,readonly \
  nginx:latest
```

```bash
# -v
$ docker run -d \
  --name=nginxtest \
  -v nginx-vol:/usr/share/nginx/html:ro \
  nginx:latest
```

```bash
$ docker inspect nginxtest
"Mounts": [
    {
        "Type": "volume",
        "Name": "nginx-vol",
        "Source": "/var/lib/docker/volumes/nginx-vol/_data",
        "Destination": "/usr/share/nginx/html",
        "Driver": "local",
        "Mode": "",
        "RW": false,
        "Propagation": ""
    }
],
```

## Backup, restore, or migrate data volumes

Volumes are useful for backups, restores, and migrations. Use the `--volumes-from` flag to create a new container that mounts that volume.

This open an interesting door to us, because we can specify a path on host where we can place some files, so when the container starts and the volume is initialized, the container is goig to have those files

## Use bind mounts

Bind mounts have limited functionality compared to volumes.

When you use a __bind mount__, a __file or directory on the host machine is mounted into a container__. The file or directory is referenced by its __absolute path on the host machine__. By contrast, when you use a volume, a new directory is created within Docker’s storage directory on the host machine, and Docker manages that directory’s contents.

The file or directory does not need to exist on the Docker host already. It is created on demand if it does not yet exist. Bind mounts are very performant, but they rely on the host machine’s filesystem having a specific directory structure available. If you are developing new Docker applications, consider using `named volumes` instead. You can’t use Docker CLI commands to directly manage bind mounts.

### Choose the -v or --mount flag

We have the same options as `volumes`

### Differences between -v and --mount behavior

If you use `-v` or `--volume` to bind-mount a file or directory that does not yet exist on the Docker host, `-v` _creates the endpoint for you_. __It is always created as a directory.__

If you use `--mount` to bind-mount a file or directory that _does not yet exist on the Docker host_, Docker does not automatically create it for you, but __generates an error__.

[Demo Setup App with Volumes]('05_volumes/00_setup_app')

## Use tmpfs mounts

`Volumes` and `bind mounts` let you share files between the host machine and container so that you can persist data even after the container is stopped.

If you’re running Docker on Linux, you have a third option: `tmpfs` mounts. When you create a container with a `tmpfs` mount, the container can create files outside the container’s writable layer.

As opposed to volumes and bind mounts, a `tmpfs` mount is temporary, and only persisted in the host memory. When the container stops, the `tmpfs` mount is removed, and files written there won’t be persisted.

This is useful to temporarily store sensitive files that you don’t want to persist in either the host or the container writable layer.