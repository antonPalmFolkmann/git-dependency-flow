# git-dependency-flow

# Prerequisites

## Setup CodeQL CLI

### For Linux

Using the zip archive:

- Download CodeQL CLI from [the website](https://github.com/github/codeql-cli-binaries/releases)
- [Extract the zip-archive](https://docs.github.com/en/code-security/codeql-cli/using-the-codeql-cli/getting-started-with-the-codeql-cli#2-extract-the-zip-archive)
- Launch CodeQL:
    
    <aside>
    💡 Once extracted, you can run CodeQL processes by running the codeql executable in a couple of ways:
    
    1. By executing <extraction-root>/codeql/codeql, where <extraction-root> is the folder where you extracted the CodeQL CLI package.
    2. By adding <extraction-root>/codeql to your PATH, so that you can run the executable as just codeql.
    
    </aside>
    
### For macOS

Using Homebrew:

```bash
$ brew install --cask codeql
```

Restart the terminal and test if the CLI has been installed correctly:

```bash
$ codeql --version
CodeQL command-line toolchain release 2.12.1.

# Or run
$ codeql resolve languages
```

## Install CodeQL extension for Visual Studio Code

Install [this extension](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-codeql) for Visual Studio Code.

# Using CodeQL

## Creating a database from a Python-based repository

- If the target repository is not local, clone the repository.
- Navigate to the root of the repository.
- [Create a database](https://codeql.github.com/docs/codeql-cli/creating-codeql-databases/) by running the following:

```bash
$ codeql database create <database> --language=<language-identifier>
```

`<database>`: a path for the new database to be created.

`--language`: the identifier for the language to create a database for.

E.g., for a python project where we want to create the database in a folder named “database” at the current location:

```bash
$ codeql database create ./database/ --language=python
Initializing database at /../../database.
Running build command: []
...
```

    
```bash
$ codeql database analyze ./database/ --format=csv --output=data.csv codeql/python-queries --download
Initializing database at /../../database.
Running build command: []
...
```
    
## CodeQL starter workspace

The [CodeQL starter workspace](https://github.com/github/vscode-codeql-starter) contains predefined queries for a selection of languages and folders for custom queries. This is were databases, created with the CodeQL CLI, can be imported and queried.

Firstly, clone the starter workspace:

```bash
git clone https://github.com/github/vscode-codeql-starter
```

Next, open the workspace in Visual Studio Code:

`File` → `Open Workspace from File`

In the file explorer, navigate to the cloned repository and select:

`vscode-codeql-starter.code-workspace`

Finally, press:

`Choose Database folder`.

In Visual Studio Code, open the CodeQL extension. In the `DATABASES` tab, select `From a folder` and select the path for the [database created previously](https://www.notion.so/Repository-guide-with-CodeQL-installation-abac8354e9a742c09fcecefecb6a6382).

## Querying databases

Once the start workspace has been setup in Visual Studio Code and a database has been selected, querying can begin.

The starter workspace features predefined queries in the `ql`-folder, and folders for custom queries in the `/codeql-custom-queries-<language-identifier>` folders.

To use a predefined query for the database previously created, navigate to `/ql/python/ql/src/`. Files with the `.ql` extension can be run by right-clicking the file and selecting `CodeQL: Run Queries in Selected Files`. The results will be displayed in a panel on the right hand side.

To use a custom query for the same database, navigate to `/codeql-custom-queries-python`. In the directory you can use the `example.ql` file or create new files for queries. Use the predefined queries for inspiration or become more familiar with QL via the [tutorials](https://codeql.github.com/docs/writing-codeql-queries/ql-tutorials/). Run the queries like before.

## Future points

- Installation of relevant packages
- File with relevant dependency analysis
- Generates an output file with dependencies in `.csv` format
