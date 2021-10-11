<img src="./images/embold-logo.png">

# EMBOLD Github Actions
[Embold](https://embold.io) Github Actions uncovers potential bugs, vulnerabilities and hard-to-detect anti-patterns that make your code difficult to maintain and can lead to error-prone solutions.
 
Embold is an AI-based software analytics platform that helps teams analyse and improve software quality. It analyses source code across 4 dimensions: code issues, design issues, metrics and duplication, and surfaces issues which impact stability, robustness, security, and maintainability. The Embold Score helps teams understand risk areas and prioritise the most important fixes.
 
## PRE-REQUISITES
1. You have Embold Enterprise License with version 1.9.2.0 and above.
2. You have an Embold Access Token corresponding to your account
3. The repository to be analysed is linked to Embold
4. Languages supported: Java, C/C++, Objective C, SQL, HTML, Apex.



## USAGE

1.	Create remote repository on Embold UI and download its repository-configuration.json. 
2.	Copy the downloaded repository-configuration.json to your base folder and replace the below values:
   - "dataDir": "./EMBOLD_DATA",
   - "baseDir": "$GITHUB_WORKSPACE",
Commit the json file to your repository at the top level.
3.	Secrets: Secrets can be created at 2 levels
 - Repository level secret 
   EMBOLD_TOKEN: This is required to authenticate access to Embold. 
   You can set the EMBOLD_TOKEN environment variable in the "Secrets" settings page of your repository. For more details, refer [EAT documentation here](https://docs.embold.io/embold-access-token-eat/#embold-access-token-eat)
 
  - Organization level secret
   EMBOLD_TOKEN: This is required to authenticate access to Embold. 
   You can set the EMBOLD_TOKEN environment variable in the "Secrets" settings page of your organization. For more details, refer [EAT documentation here](https://docs.embold.io/embold-access-token-eat/#embold-access-token-eat)
 
4.	The workflow is usually declared in .github/workflows/main.yaml, and looks like this:

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
        uses: embold/github-action-docker@v0.2
        with:
          embold-url: <Your Embold Server URL>
          embold-token: ${{ secrets.EMBOLD_TOKEN }}
          repo-config: '/github/workspace/repository-configuration.json'
          repo-uid: <The Embold Repository UID> 
```

5.	Embold Github action will then scan your source code on push.
6.	Once the job is complete, scan results are available on the Embold server

## FEEDBACK
Feel free to use [Embold Community](https://community.embold.io) to give feedback, feature requests or reporting a bug. 
## LICENSE
Sources and documentation in this repository are released under the AGPL v3
