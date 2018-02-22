## The naming scheme

- The naming of a gist: `gid/[vid|remote|latest]/[pin|unpin]`
- "remote" means the latest version on Gist server, and "latest" means the up-to-date version on local machine. They can be the same, but quite likely not.
- When `pin` is set, a local file that contains the zoo gist dependencies of current script will be loaded; if such file does not exists, generate one.
- All three part does not has to be listed explicitly. Expansion rules:
    + `gid` --> `gid/latest/unpin`
    + `gid/vid` --> `gid/vid/unpin`
    + `gid/remote` --> `gid/remote/unpin`
    + `gid/latest` --> `gid/latest/unpin`
    + `gid/vid/pin`, `gid/vid/unpin`
    + `gid/remote/pin`, `gid/remote/unpin`
    + `gid/latest/pin`, `gid/latest/unpin`

## How each command understands "gist"

- `remove`, `upload`, `list_gist`: only rely on gist id
- `download`, `run_gist`, `show_info`, `load_file`: need gist id and a specific version id, thus the whole gist name
- `update`: need gist id array, and a `gid` will always be interpreted as `gid/remote` before downloading
- other functions: do not need gist information
