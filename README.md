# DISCLAIMER: Student project

The content of this repository is for educational purposes only. 

This project is used for a bachelor's thesis at the IT-University of Copenhagen.

Date: May 9, 2023

Pull docker image from Docker Hub:

```bash
docker pull antonfolkmann/flowmethod:latest
```

Run docker image:

```bash
docker run --rm -it antonfolkmann/flowmethod:latest bash
```

On M1 macs:

```bash
docker run --rm -it --platform linux/amd64 antonfolkmann/flowmethod:latest bash
```

Inside the docker container go to the scripts folder and execute the scripts with the following commands in sequence:

- `./scripts/flowmethod.sh
    - Here, it is important to give your git username and a Git Authentication Token, as passwords don’t work for GitHub CLI.

The `flowtree` has now been created, and is ready for `mapequation.org/infomap`

To copy the generated `ftree` file from the container, open a new terminal window and run the following command:

- `docker container ls`

This should yield something like this:

```bash
$ docker container ls
CONTAINER ID   IMAGE                             COMMAND   CREATED          STATUS          PORTS     NAMES
74950f75cec7   antonfolkmann/flowmethod:latest   "bash"    10 seconds ago   Up 10 seconds             magical_aryabhata
```

Then use the container id to copy the `ftree` from the container to the folder you’re currently in with the following command:

- `docker cp <container_id>:/root/FlowMethod/git-dependency-flow/flowmethod.ftree .`

Here is an example:

```bash
docker cp 74950f75cec7:/root/FlowMethod/git-dependency-flow/flowmethod.ftree .
```

Next, go to the [Infomap Navigator](https://www.mapequation.org/navigator/), click `Load ftree file`, and select the `ftree` file you just copied to current folder.
