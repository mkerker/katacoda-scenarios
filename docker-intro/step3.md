## Lab 3: Background Containers

--------

#### Objectives

Our first containers were *interactive*.

We will now see how to:

-   Run a non-interactive container.

-   Run a container in the background.

-   List running containers.

-   Check the logs of a container.

-   Stop a container.

-   List stopped containers.

--------

#### Step 1: A non-interactive container

We will run a small custom container, more about this container will explain in lab 5.

This container just displays the time every second.
```
 $ docker run hcscompany/clock
  ...
 Fri Feb 20 00:28:53 UTC 
 Fri Feb 20 00:28:54 UTC 
 Fri Feb 20 00:28:55 UTC
 ...
```
-   This container will run forever.

-   To stop it, press ^C.

-   Docker has automatically downloaded the image hcscompany/clock.

-   This image is a user image, created by hcscompany.

-   We will hear more about user images (and other types of images) later.

--------

#### Step 2: Run a container in the background

Containers can be started in the background, with the `-d` flag (daemon mode):
```
 $ docker run -d hcscompany/clock 
 47d677dcfba4277c6cc68fcaa51f932b544cab1a187c853b7d0caf4e8debe5ad
```
-   We don't see the output of the container.

-   But don't worry: Docker collects that output and logs it!

-   Docker gives us the ID of the container.

--------

#### Step 3: List running containers

How can we check that our container is still running?

With `docker ps`, just like the UNIX ps command, lists running processes.
```
$ docker ps
  CONTAINER ID  IMAGE             ...  CREATED        STATUS        ...
  47d677dcfba4  hcscompany/clock  ...  2 minutes ago  Up 2 minutes  ...
```
Docker tells us:

-   The (truncated) ID of our container.

-   The image used to start the container.

-   That our container has been running (Up) for a couple of minutes.

-   Other information (COMMAND, PORTS, NAMES) that we will explain later.

--------

#### Step 4: Starting more containers

Let's start two more containers.
```
 $ docker run -d hcscompany/clock 
 57ad9bdfc06bb4407c47220cf59ce21585dce9a1298d7a67488359aeaea8ae2a 
 
 $ docker run -d hcscompany/clock 
 068cc994ffd0190bbe025ba74e4c0771a5d8f14734af772ddee8dc1aaf20567d
```
Check that `docker ps` correctly reports all 3 containers.

--------

#### Step 5: Two useful flags for `docker ps`

To see only the last container that was started:
```
 $ docker ps -l
 CONTAINER ID  IMAGE           ...  CREATED        STATUS        ...
 068cc994ffd0  hcscompany/clock  ...  2 minutes ago  Up 2 minutes  ...
```
To see only the ID of containers:
```
 $ docker ps -q 
 068cc994ffd0 
 57ad9bdfc06b 
 47d677dcfba4
```
Combine those flags to see only the ID of the last container started!
```
 $ docker ps -lq 
 068cc994ffd0
```

--------

#### Step 6: View the logs of a container

We told you that Docker was logging the container output.

Let's see that now.
```
 $ docker logs 068
 Fri Feb 20 00:39:52 UTC 
 Fri Feb 20 00:39:53 UTC
 ...
```
-   We specified a *prefix* of the full container ID.

-   You can, of course, specify the full ID.

-   The logs command will output the *entire* logs of the container. (Sometimes, that will be too much. Let's see how to address that.)

--------

#### Step 7: View only the tail of the logs

To avoid being spammed with eleventy pages of output, we can use the `--tail` option:
```
 $ docker logs --tail 3 068 
 Fri Feb 20 00:55:35 UTC 
 Fri Feb 20 00:55:36 UTC 
 Fri Feb 20 00:55:37 UTC
```
-   The parameter is the number of lines that we want to see.

--------

#### Step 8: Follow the logs in real time

Just like with the standard UNIX command `tail -f`, we can `follow` the logs of our container:
```
 $ docker logs --tail 1 --follow 068 
 Fri Feb 20 00:57:12 UTC
 Fri Feb 20 00:57:13 UTC
```
-   This will display the last line in the log file.

-   Then, it will continue to display the logs in real time.

-   **Use ^C to exit**.

--------

#### Step 9: Stop our container

There are two ways we can terminate our detached container.

-  Killing it using the `docker kill` command.

-  Stopping it using the `docker stop` command.

The first one stops the container immediately, by using the KILL signal.

The second one is more graceful. It sends a TERM signal, and after 10 seconds, if the container has not stopped, it sends KILL.

Reminder: the KILL signal cannot be intercepted, and will forcibly terminate the container.

Let's stop one of those containers:
```
 $ docker stop 47d6 
 47d6
```
This will take 10 seconds:

-   Docker sends the TERM signal;

-   the container doesn't react to this signal (it's a simple Shell script with no special signal handling);

-   10 seconds later, since the container is still running, Docker sends the KILL signal;

-   this terminates the container.

Let's be less patient with the two other containers and kill the remaining containers:
```
 $ docker kill 068 57ad 
 068
 57ad
```
The stop and kill commands can take multiple container IDs.

Those containers will be terminated immediately (without the 10 seconds delay). Let's check that our containers don't show up anymore:
```
 $ docker ps
```

--------

#### Step 10: List stopped containers

We can also see stopped containers, with the `-a (--all)` option.

```
$ docker ps -a
  CONTAINER ID  IMAGE             ...  CREATED      STATUS
  068cc994ffd0  hcscompany/clock  ...  21 min. ago  Exited (137) 3 min. ago
  57ad9bdfc06b  hcscompany/clock  ...  21 min. ago  Exited (137) 3 min. ago
  47d677dcfba4  hcscompany/clock  ...  23 min. ago  Exited (137) 3 min. ago
  5c1dfd4d81f1  hcscompany/clock  ...  40 min. ago  Exited (0) 40 min. ago
  b13c164401fb  ubuntu            ...  55 min. ago  Exited (130) 53 min. ago
```
