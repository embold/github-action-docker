# Embold Scan Action

This action downloads the BrowserStack CQ Scanner (Embold scanner CLI) and runs static code analysis on your repository locally.

## License

Sources and documentation in this repository are released under the AGPL v3.
See [LICENSE](./LICENSE).

## Inputs

#### `emboldUrl`

**Required** URL of your Embold instance. e.g. : `https://demo.embold.io/`

#### `emboldToken`

**Required** Your Embold access token (recommended: Use a [secret](https://docs.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets))

#### `emboldRepoUid`

**Required** Repository UID of the Embold repository where the results will be published. [How to get your repository UID?](https://docs.embold.io/projects-repositories/#get-repository-uid)

#### `scannerDownloadUrl`

**Optional** URL to download the BrowserStack CQ Scanner. Default: `https://v1.embold.io/nfs/CLI/browserstack-codequality-scanner.tar.gz`

#### `repositoryConfigPath`

**Optional** Path to the repository configuration JSON file. Default: `repository-configuration.json`

#### `downloadConfig`

**Optional** Download repository configuration from Embold server. Default: `false`

#### `configDownloadPath`

**Optional** Path where downloaded config will be saved. Default: `repository-configuration.json`

#### `tempDirectory`

**Optional** Temporary directory for scanner artifacts. Default: `./temp`

#### `baseDirectory`

**Optional** Base directory of the source code to scan. Default: `.`

#### `verbose`

**Optional** Enable verbose logging. Default: `true`

#### `qualityGate`

**Optional** Enable quality gate checking. Default: `false`

#### `continueOnError`

**Optional** Continue workflow execution even if scan fails. Default: `true`

#### `snapshotLabel`

**Optional** Label to identify the snapshot published on the Embold UI after a successful scan. Accepts a plain string or an environment variable (e.g., `$GITHUB_SHA` or `$GITHUB_REF_NAME`). Default: `` (empty — no label)

## Outputs

#### `status`

Status of the scan

#### `qualityGateStatus`

Quality gate status (PASSED/FAILED)

#### `qualityGateData`

Quality gate detailed data

## Example Usage

### Basic Usage

```yaml
- name: Run Embold Scan
  uses: embold/github-action-docker@v1.0
  with:
    emboldUrl: https://demo.embold.io/
    emboldToken: ${{ secrets.EMBOLD_TOKEN }}
    emboldRepoUid: ${{ secrets.EMBOLD_REPO_UID }}
```

### Download Repository Config Automatically

```yaml
- name: Run Embold Scan
  uses: embold/github-action-docker@v1.0
  with:
    emboldUrl: https://demo.embold.io/
    emboldToken: ${{ secrets.EMBOLD_TOKEN }}
    emboldRepoUid: 81aba9b3940bbf35aac36dd3e4a45562
    downloadConfig: 'true'
```

### Enable Quality Gate

```yaml
- name: Run Embold Scan with Quality Gate
  id: embold-scan
  uses: embold/github-action-docker@v1.0
  with:
    emboldUrl: https://demo.embold.io/
    emboldToken: ${{ secrets.EMBOLD_TOKEN }}
    emboldRepoUid: 81aba9b3940bbf35aac36dd3e4a45562
    qualityGate: 'true'

- name: Check Quality Gate Result
  if: steps.embold-scan.outputs.qualityGateStatus == 'FAILED'
  run: |
    echo "Quality gate failed!"
    exit 1
```

### Complete Workflow Example

```yaml
name: Embold Code Quality Analysis

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  embold-scan:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4
      
      - name: Run Embold Scan
        uses: embold/github-action-docker@v1.0
        with:
          emboldUrl: https://demo.embold.io/
          emboldToken: ${{ secrets.EMBOLD_TOKEN }}
          emboldRepoUid: ${{ secrets.EMBOLD_REPO_UID }}
          repositoryConfigPath: repository-configuration.json
          verbose: true
          qualityGate: 'true'
          snapshotLabel: ${{ github.ref_name }}-${{ github.sha }}
```

## Prerequisites

- A repository configuration JSON file (default: `repository-configuration.json` in the root directory) or enable `downloadConfig`
- Embold access token stored as a GitHub secret
- Embold repository UID

## How It Works

1. Optionally downloads the repository configuration from Embold server
2. Downloads the BrowserStack CQ Scanner from the specified URL
3. Extracts the scanner archive
4. Runs the Embold scanner with the provided configuration
5. Publishes results to the specified Embold repository
6. Optionally checks and outputs the quality gate status

## Support

For issues and questions, please visit the [Embold documentation](https://docs.embold.io/) or contact Embold support.
