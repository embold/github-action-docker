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

1.	Create remote repository on Embold UI and download repository-configuration.json. 
2.	In your base folder, create repository-configuration.json and replace with below values:
   - "dataDir": "./EMBOLD_DATA",
   - "baseDir": "$GITHUB_WORKSPACE",
Commit the json file.
3.	Secrets: Secrets can be created at 2 levels
 - Repository level secret 
   EMBOLD_TOKEN: This is required to authenticate access to Embold. 
   You can set the EMBOLD_TOKEN environment variable in the "Secrets" settings page of your repository. For more details, refer [EAT documentation here](https://docs.embold.io/embold-access-token-eat/#embold-access-token-eat)
 
  - Organization level secret
   EMBOLD_TOKEN: This is required to authenticate access to Embold. 
   You can set the EMBOLD_TOKEN environment variable in the "Secrets" settings page of your organization. For more details, refer [EAT documentation here](https://docs.embold.io/embold-access-token-eat/#embold-access-token-eat)
 
4.	The workflow is usually declared in .github/workflows/main.yaml, and looks like:

```
# This is a basic workflow to help you get started with Actions

name: CI

# Controls when the workflow will run
on:
  # Triggers the workflow on push or pull request events but only for the main branch
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  # This workflow contains a single job called "build"
  build:
    # The type of runner that the job will run on
    runs-on: ubuntu-latest

    # Steps represent a sequence of tasks that will be executed as part of the job
    steps:
      # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
      - uses: actions/checkout@v2

      # Runs a single command using the runners shell
      - name: Run a one-line script
        run: echo Hello, world!

      # Runs a set of commands using the runners shell
      - name: Run a multi-line script
        run: |
          echo Add other actions to build,
          echo test, and deploy your project.
```



You can change the workflow to below by pasting the .yaml content:
```
on: [push]
jobs:
embold_scan_job:
runs-on: ubuntu-latest
name: Embold scan
steps:
- uses: actions/checkout@v2
with:
fetch-depth: 0
- name: Embold scan step
id: embold
uses: embold/github-action-docker@v0.2
with:
embold-url: 'https://oss.emboldci.dev'
embold-token: ${{ secrets.EMBOLD_TOKEN }}
repo-config: '/github/workspace/repository-configuration.json'
repo-uid: '75561e223bc0821258e1dfb504d57496' 
// change this repoid with your created repo from embold 
```

5.	Github actions will scan your source code.
6.	Go to Embold to see the results. 

## FEEDBACK
Feel free to use [Embold Community](https://community.embold.io) to give feedback, feature requests or reporting a bug. 
## LICENSE
Sources and documentation in this repository are released under the AGPL v3
