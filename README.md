# Grayhive

A Proof-of-Concept repository for automating Graylog and connecting it with The Hive. **NOTE:** Some Terraform modules, the Docker Compose file, Python script and this README contain empty strings/values, so make sure to fill them in correctly, according to your own situation/environment. Besides: this repository was initially a Proof-of-Concept, so some features (such as sending an alert to The Hive) is done in a basic way to show its purpose/goal. Feel free to create a PR to improve this.

## Stacks

This repository makes use of a single Terraform stack, namely:

- [graylog](./terraform/graylog)

However, you can apply modules to your own liking instead of having to apply them all.

## Used VM configuration

We're making use of an Ubuntu Minimal 22.04 instance running on a hypervisor.

| Resources | Values |
| ------ | ------ |
| CPUs | 4 |
| Memory | 8GB |
| Storage | 12GB |

## Set-up and (post)configuration for Graylog

1. Install updates

    ```shell
    apt update && apt upgrade
    ```

1. Make sure you've installed a text editor (e.g. Nano or Vim). So for example:

    ```shell
    apt install nano -y
    ```

1. Change hostname and hosts (otherwise Graylog may not function properly)

    ```shell
    nano /etc/hostname
    nano /etc/hosts
    ```

    Now reboot to apply the changes.

1. Because it's a bad security practice to execute everything under **root**,
   we'll create our own user.

    ```shell
    adduser <user>
    ```

1. Assign user variable to username

    ```shell
    export USER="test-user"
    ```

1. Make user sudo-er

    ```shell
    usermod -aG sudo $USER
    ```

1. Move SSH-keys from root to the by you made user and change ownership of the file

    ```shell
    cp -R /root/.ssh/ /home/$USER/
    chown -R $USER:$USER /home/$USER/.ssh
    ```

1. Only permit the user you made to login with SSH; disallow root to login with SSH, so change/add the following lines:

    ```shell
    nano /etc/ssh/sshd_config
    ```

    Change the following lines:

    ```shell
    PermitRootLogin no
    AllowUsers  test-user
    ```

    Restart the service so that the changes take effect

    ```shell
    systemctl restart sshd
    ```

1. Now switch to the user you just created

    ```shell
    su <username>
    ```

## Docker Compose

In this repository we already have created a `docker-compose.yml`. See <https://github.com/AnonymousWP/Grayhive/blob/master/docker/docker-compose.yml> in case you didn't create one yet.

1. Verify you have Docker Compose installed

    ```shell
    sudo docker-compose -v
    ```

1. If you don't have Docker Compose installed, install it

    <https://docs.docker.com/compose/install/>

1. Execute the following to start the containers in the background

    ```shell
    sudo docker-compose up -d
    ```

    _N.B. Execute this command in the directory where the
    docker-compose.yml file is located!_

1. Create input to test if log messages are received

    Navigate to <http://HOSTNAME:9000/system/inputs> and launch a RAW/Plaintext TCP input with the following values:

    - Enter the desired settings
    - Click save

1. In case you don’t have netcat installed yet, enter the following command:

    ```shell
    sudo apt install netcat
    ```

    We can then send a plaintext message by entering the following command:

    ```shell
    sudo echo 'First log message' | nc <fully qualified domain name of the machine> 5555
    ```

1. See if sent log data is present on the Graylog server

    Go back to <http://HOSTNAME:9000/system/inputs> and click “Show received messages”.

    The page should look similar to this (and most importantly, contain the log message):

    ![Result](https://user-images.githubusercontent.com/50231698/141489725-450e7992-9b6b-4031-a75a-b5ebd8cec227.png)

### Cleaning up

1. In case you want to start all over again regarding containers (e.g. for testing purposes), you can use <https://github.com/AnonymousWP/Grayhive/blob/master/docker/clean_start.sh>, which stops the containers, then deletes them, including the images and volumes.

## The Hive

The Python scripts used come from [Recon InfoSec](https://github.com/ReconInfoSec/graylog2thehive). They have also written [a blog](https://blog.reconinfosec.com/integrating-graylog-with-thehive/) about it. Credits to them for making these scripts.

**NOTE:** following/executing the next steps assume that the Dockerfile is already on the server. It's also recommended to execute the steps as sudo'er.

1. Configure SSL certificate paths in `app.py`, or comment out all context lines if not using SSL

1. Set your Hive API key in `/etc/systemd/system/graylog2thehive.service` for the `HIVE_SECRET_KEY`

1. Set your Hive and Graylog URLs in `config.py`

1. **Optional:** `app/__init__.py`, configure any other IP, hash, URL, or filename fields in place of src_ip and dst_ip to include them as artifacts/observables in your alert

1. Run the [Dockerfile](./graylog2thehive/Dockerfile): `docker build -t graylog2thehive .`

1. Runs at <https://0.0.0.0:5000>, accepts POST requests

    - Point your Graylog HTTP Notification to <https://[YOURSERVER>]:5000/create_alert_http (see `/terraform/the_hive/terraform.tfvars` for the value). You can find the IP-address of your Docker Graylog container by using

    ```shell
    sudo docker inspect <containerID>
    ```

1. Run the Docker container with the image you just built: `docker run -dp 3000:3000 graylog2thehive`

1. Check whether it runs correctly or not: `docker ps -a`

    - If not, run `docker logs <containerID>`

## Terraform modules

This Proof-of-Concept uses the following Terraform provider: <https://registry.terraform.io/providers/zahiar/graylog/latest/docs>. In order to execute all modules, do the following:

1. Switch to the corresponding directory to execute the first stack

    ```shell
    cd terraform/graylog
    ```

1. To make sure you'll push the correct configuration, check all values and attributes within the modules, such as putting the `web_endpoint_uri` in [graylog.tf](/terraform/graylog/graylog.tf#L11). It should look similar to `http://<domain-name-or-IP:9000/api>`

1. In the same directory, you have to install the provider, which you can do by the following

    ```shell
    terraform init
    ```

1. Now you have to validate whether the modules are written correctly

    ```shell
    terraform validate
    ```

1. In order to see what will be applied once you run `terraform apply`, you have to run the following command:

    ```shell
    terraform plan
    ```

1. Last but not least, we're now going to apply the actual modules to the server

    ```shell
    terraform apply
    ```
