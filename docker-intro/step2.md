## Lab 2: Our First Containers

--------

#### Objectives

At the end of this lab, you will have:

-   Seen Docker in action.

-   Started your first containers.

#### Docker architecture

Docker is a client-server application.

-   **The Docker Engine (or "daemon")**

    - Receives and processes incoming Docker API requests.

-   **The Docker client**

    - Talks to the Docker daemon via the Docker API.
    - We'll use mostly the CLI embedded within the docker binary.

-   **Docker Hub Registry**

    - Collection of public images.
    - The Docker daemon talks to it via the registry API.

--------

#### Step 1: Hello World

In your Docker environment, just run the following command:

`docker run busybox echo hello world`{{execute}}

```
$ docker run busybox echo hello world {{execute}}

...

hello world
```
That was our first container !!

-   We used one of the smallest, simplest linux images available: busybox.

-   Busybox combines tiny versions of many common UNIX utilities into a single small executable.

-   Busybox is typically used in embedded systems (phones, routers...).

-   We ran a single process and echo'ed `hello world`.

--------

#### Step 2: A more useful container

Let's run a more exciting container:
```
$ docker run -it ubuntu {{execute}}
```
-   This is a brand new container.

-   It runs a bare-bones, no-frills ubuntu system.

- `-it` is shorthand for `-i -t`.

-   `-i` tells Docker to connect us to the container's stdin.

-   `-t` tells Docker that we want a pseudo-terminal.


Let's do something in our container. Try to run figlet in our container. Figlet is a funny program that changes letters into ASCI characters.

```
root@04c0bb0a6c07:/# figlet hello
bash: figlet: command not found
```
Alright, we need to install it.

**An observation**

Let's check how many packages are installed here (number of packages may be different).
```
root@04c0bb0a6c07:/# dpkg -l | wc -l 
103
```
- `dpkg -l` lists the packages installed in our container

- `wc -l` counts them

- If you have a Debian or Ubuntu machine, you can run the same command and compare the results.

We want figlet, so let's update Ubuntu... 
```
root@04c0bb0a6c07:/# apt-get update
...

Fetched 1514 kB in 14s (103 kB/s) 
Reading package lists... Done
```

and install it:

```
root@04c0bb0a6c07:/# apt-get install figlet
Reading package lists... Done

...

update-alternatives: using /usr/bin/figlet-figlet to provide /usr/bin/figlet (figlet) in auto mode
```
One minute later, figlet is installed! Let's try figlet:
```
root@04c0bb0a6c07:/# figlet hello
     _          _ _
    | |__   ___| | | ___
    |  _ \ / _ \ | |/ _ \
    | | | |  __/ | | (_) |
    |_| |_|\___|_|_|\___/
```

Just exit the shell, like you would usually do.
(E.g. with ^D or exit)

```
 root@04c0bb0a6c07:/# exit
```
-   Our container is now in a *stopped* state.

-   It still exists on disk, but all compute resources have been freed up.


What if we start a new container, and try to run figlet again?
```
$ docker run -it ubuntu 
root@b13c164401fb:/# figlet 
bash: figlet: command not found
```
-   We started a *brand new container*.

-   The basic Ubuntu image was used, and figlet is not here. This is called “Stateless” the state is not kept when the container is not there anymore.
 
We will see in the next chapters how to bake a custom image with figlet.
