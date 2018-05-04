## The naming scheme

- The naming of a gist: `gid?vid="version_id"?tol="time_str"`. Here `vid` and `tol` are both optional parameters.
- `tol` is a threshold value that indicates a gist's tolerance for the time it exists on the local cache. Any gist that exists on a user's local cache longer than `tol` is deemed outdated and thus requires update the `vid` from the Gist server before being used.
  * If `tol` is not set, `zoo` will always try to use the latest locally cached version.
  * Currently the format of `time_str` is simple: a string of numbers that indicates seconds.
- `vid` specifies the id of certain version of a gist. When `vid` is not set, it defaults to the latest gist version that exists on local cache for no longer than `tol`; if such version does not exist, then the newest version from Gist server will be used. When `vid` is set, the `tol` parameter will be ignored.

## How each command understands "gist"

- `run_gist`, `load_file`, `show_info`: need the whole gist name.
- `download_gist`: needs a gist id and optionally a version id; if version id is not provided, then the up-to-date version id from Gist server will be fetched before downloading.
- `update_gist`: needs a gist id array; for each gist id, the most up-to-date version id from Gist server will always be fetched before downloading. If no parameters are provided, the latest version from Gist server of all local cached gists will be downloaded.
- `remove_gist`, `list_gist`: only need gist id. For `list_gist`, it lists all versions of a given gist; if gist id is "", it lists all the local gists.
- `eval`, `upload_gist`, `preprocess`, `run`, `print_info`, `start_toplevel`: do not need gist information.


## Misc.

- Prerequisite: users need to install and login to `gist` and `git`.
- Uploading a folder to Gist requires a `#readme.md` file in that folder. The first line of this file will be used as a short description for the shared scripts in the same folder. The hashtag is used to make sure this file is always shown at the top in `gist.github.com`, where files in a Gist are displayed in the alphabetical order.
- When users need to use a file A in the same gist folder, they should extend its path with `Owl_zoo_path.extend_zoo_path A`, so that its path can be found when downloaded to local cache.
