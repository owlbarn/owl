## The naming scheme

- The naming of a gist: `gid/[vid|latest]/[pin|unpin]`
- "latest" means the newest version on local cache. To get the up-to-date version from Gist server, the user needs to run `owl -download` command explicitly. The download time as metadata will be saved when downloaded. After a certain period of time, the newest version will also be pulled to local cache by "latest".
- When `pin` is set, a local file that contains the zoo gist dependency graph of current script will be loaded; if such file does not exists in current directory, then generate one. `pin` only works when the version id is specified, otherwise this flag is ignored.
- All three parts of a name do not have to be listed explicitly. Expansion rules:
    + `gid` --> `gid/latest` --> `gid/latest/unpin`
    + `gid/vid` --> `gid/vid/unpin`
    + `gid/vid/pin`
- "latest" will introduce cache inconsistency. The latest version on one machine might not be the same on the other. Ideally, every published service should contain a specific `vid`, and "latest" should only be used during development. One solution is to replace the "latest" with the vid when the gist is uploaded. The name `gid/latest/pin` is not supported for now.

## How each command understands "gist"

- `run_gist`, `load_file`, `show_info`: need the whole gist name.
- `download`: needs a gist id and optionally a version id; if version id is not provided, then the up-to-date version id from Gist server will be fetched before downloading.
- `update`: needs a gist id array; for each gist id, the most up-to-date version id from Gist server will always be fetched before downloading. If no parameters are provides, all local cached gists will be updated to the latest version from Gist server.
- `remove`, `upload`, `list_gist`: only need gist id. For `list_gist`, it lists all versions of a given gist; if no gist id is provided, it lists all the local gists.
- `eval`, `preprocess`, `run`, `print_info`, `start_toplevel`: do not need gist information.
