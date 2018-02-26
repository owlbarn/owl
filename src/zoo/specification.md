## The naming scheme

- The naming of a gist: `gid/[vid|latest]/[pin|unpin]`
- "latest" means the newest version on local cache. To get the most up-to-date version from Gist server, the user need to run `owl -download` command explicitly. The download time as metadata will be saved. After a certain period of time, the newest version will also be pulled to local cache by "latest".
- When `pin` is set, a local file that contains the zoo gist dependencies of current script will be loaded; if such file does not exists, generate one. `pin` only works when the version id is specified, otherwise this flag is ignored.
- All three part does not has to be listed explicitly. Expansion rules:
    + `gid` --> `gid/latest` --> `gid/latest/unpin`
    + `gid/vid` --> `gid/vid/unpin`
    + `gid/vid/pin`
- The "latest" name will inevitably introduces cache inconsistency. For example, the latest version on one machine might not be the same on the other. Ideally, all published service should contains a specific `vid`, and "latest" should only be used during development.

## How each command understands "gist"

- `run_gist`, `load_file`, `show_info`: need the whole gist name
- `download`: need gist id and optionally a version id; if version id is not provided, then the most up-to-date version id from Gist server will be fetched before downloading
- `update`: need gist id array; the most up-to-date version id from Gist server will always be fetched before updating
- `remove`, `upload`, `list_gist`: only rely on gist id
- other functions: do not need gist information
