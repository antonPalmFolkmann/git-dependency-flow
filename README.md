# DISCLAIMER: Student project

The content of this repository is for educational purposes only. 

This project is used for a bachelor's thesis at the IT-University of Copenhagen.

## Pull docker image from Docker Hub:

```python
docker pull antonfolkmann/flowmethod
```

Run docker image:

```python
docker run -it antonfolkmann/flowmethod bash
```

Inside the docker container go to the scripts folder and execute the scripts in the following sequence from the root directory:

- `./scripts/clone_repos.sh`
    - Here, it is important to give your git username and a Git Authentication Token, as passwords don’t work for GitHub CLI
- `./scripts/run_codeql.sh`
- `./scripts/generate_flowtree.sh`

The flowtree has now been created, and is ready for `mapequation.org/infomap`
