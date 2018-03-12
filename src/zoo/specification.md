## The naming scheme

- The naming of a gist: `gid/[vid|latest]/[pin|unpin]`
- "latest" means the newest version on local cache. To get the up-to-date version from Gist server, the user needs to run `owl -download` command explicitly. The download time as metadata will be saved when downloaded. After a certain period of time, the newest version will also be pulled to local cache at `owl -run` or `#zoo` when "latest" is set.
- When `pin` is set, a file ("$gid-$vid.graph") that contains the zoo gist dependency graph of current script will be loaded, so that fixed versions of dependencies will be loaded. If such file does not exists in current directory, then the current script will be parsed to generate one. `pin` only works when the version id is specified, otherwise this flag will be ignored.
- All three parts of a name do not have to be listed explicitly. Expansion rules:
    + `gid` --> `gid/latest` --> `gid/latest/unpin`
    + `gid/vid` --> `gid/vid/unpin`
    + `gid/vid/pin`
- "latest" will introduce cache inconsistency. The latest version on one machine might not be the same on the other. Ideally, every published service should contain a specific version id, and "latest" should only be used during development. One solution is to replace "latest" with the version id when this gist is uploaded. Without replacing it with version id, the name `gid/latest/pin` is ambiguous.

## How each command understands "gist"

- `run_gist`, `load_file`, `show_info`: need the whole gist name.
- `download_gist`: needs a gist id and optionally a version id; if version id is not provided, then the up-to-date version id from Gist server will be fetched before downloading.
- `update_gist`: needs a gist id array; for each gist id, the most up-to-date version id from Gist server will always be fetched before downloading. If no parameters are provided, the latest version from Gist server of all local cached gists will be downloaded.
- `remove_gist`, `list_gist`: only need gist id. For `list_gist`, it lists all versions of a given gist; if gist id is "", it lists all the local gists.
- `eval`, `upload_gist`, `preprocess`, `run`, `print_info`, `start_toplevel`: do not need gist information.


## Misc.

- Prerequisite: users need to install and login to `gist` and `git`.
- Uploading a folder to Gist requires a `#readme.md` file in that folder. The first line of this file will be used as a short description for the shared scripts in the same folder. The hashtag is used to make sure this file is always shown at the top in `gist.github.com`, where files in a Gist are displayed in the alphabetical order.
