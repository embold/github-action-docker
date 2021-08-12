# Embold Scan

**[ THIS IS A PRE-RELEASE VERSION]**

<img src="./images/embold-logo.png">

Use this Github Action to scan your code with [Embold](https://embold.io) and find design, code quality and security issues.

## Pre-requisites

* You have access to an Embold server instance, accessible from Github
* You have an Embold Access Token corresponding to your account
* The Repository to be analysed is created on Embold

## Steps
* Create a repository-configuration.json (download it from the Embold Repository using the "Download repository configuration" option)
* Modify the following values:
    - `dataDir`: Set it to "./embold_data"
    - `baseDir`: Set it to "`$GITHUB_WORKSPACE`"
* Commit this file to your Github repository at the top-level

The workflow typically looks like:

```yaml
on: [push]
jobs:
  embold_scan_job:
    runs-on: ubuntu-latest
    name: Embold scan
    steps:
      - uses: actions/checkout@v2
      - name: Embold scan step
        id: embold
        uses: embold/github-action-docker@v0.1
        with:
          embold-url: <Your Embold Server URL>
          embold-token: ${{ secrets.EMBOLD_TOKEN }}
          repo-config: '/github/workspace/repository-configuration.json'
          repo-uid: <The Embold Repository UID>
```

## License
Sources and documentation in this repository are released under the AGPL v3
