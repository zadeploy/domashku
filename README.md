# DevOps Survival Camp: Winter 2020

<img src="https://zadeploy.s3.eu-central-1.amazonaws.com/logo.png" data-canonical-src="https://zadeploy.s3.eu-central-1.amazonaws.com/logo.png" width="300" />

# How to submit your homework?

* For passing any home task you need to [fork this repo](http://lmgtfy.com/?q=fork).
* In your repo you need to create a folder named as your full name (Ivan_Ivanov)
* Each home task should be done in a separate [branch](http://lmgtfy.com/?q=github+branch) and in a separate folder under your named folder. For example, your first homework should be in (Ivan_Ivanov/0/).
* If you think that the task is done - create [pull request](http://lmgtfy.com/?q=pull+request) to master branch.
* If everything is great - mentor will merge your PR.

# HomeWork #0

## Setup

1. Download and install [virtualbox](https://www.virtualbox.org/).
2. Download and install [vagrant](http://vagrantup.com).
3. Download [virtualbox base image](https://zadeploy.s3.eu-central-1.amazonaws.com/hm0/devops-test.box).

## Summary

This test simulates real world problems a Dev/Ops Engineer may face and have to solve. You will have to learn how to use (potentially) new tools, diagnose system health issues, write some utilities, and automate the whole process to end up with a reproducible image.

At the end of this you should be able to send a new Vagrantfile and associated scripts/configs that will allow the mentor to recreate your completed and fixed test environment from the same base image provided in the test Vagrantfile.

## Instructions

0. Get home task related files from folder `_hw#0`.
1. Learn the basics of how to use Vagrant, launch the vagrant VM, and login to it via SSH (Note: this will take some time to download the VM image the first time)
2. Analyze the health of the system. Note anything you find and fix if there are issues.
3. Ensure apache is running. If is is not, diagnose and fix.
	- You should be able to see a test page going here in your browser: http://localhost:8080/app
4. Reconfigure apache to run using HTTPS rather than HTTP. Any HTTP links should redirect to HTTPS.
	- You should be able to see the exact same test page as above by going here in your browser: https://localhost:8443/app
	- You will get an exception about an insecure connection due to the self-signed cert. Feel free to ignore this.
	- The redirection should work from the client's perspective. Do not worry about proper redirection from inside the VM. (Port 443 vs 8443)
5. Install memcached
6. Add a cronjob that runs /home/vagrant/exercise-memcached.sh once per minute
7. Write your own vagrant file and provisioning scripts/configs that recreate everything you just did.
8. Prepare PR with your new vagrant file with any associated provisioning scripts/configs.

The mentor should be able to simply use your files, run `vagrant up`, and have your completed and fixed environment running for review.

### Optional task: Write a python web application that outputs memcached stats

>	- Please try not use any 3rd party libraries outside of the python standard library.
>	- It should additionally calculate the "get" hit rate and show it as a percentage ("X% of gets missed the cache")
>	- It should additionally show the percentage of memcached memory used (From the API. Not the percentage of the OS memory.)
>	- Don't worry about the look and style of the page. Just make it functional.
>	- There is a basic python Flask app in /var/www/app you can use as a starting template


# HomeWork #1

## Setup

 Download and install [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) or setup kubernetes using [Docker Desktop](https://www.docker.com/products/docker-desktop).

## Summary
Probably all you heard about Nginx and Rambler story. Today you will try to implement stub page in support of Igor Sysoev

## Instructions

0. Get home task related files from folder `_hw#1`.
1. Learn the basics of how to use Minikube, configure and deploy kubernetes service with Nginx.
2. Install Nginx as [ingress controller](https://github.com/kubernetes/ingress-nginx). Nginx should be avialible on http://localhost:8080/
3. Configure Nginx to made it show stub page instead of default web page on custom date.
 - Add to header "Powered by nginx"
 - Add the HTML-file nginx-blackout folder somewhere to the server (e.g. /var/www/nginx-blackout/index.html)
 Edit your root location in the nginx config to be like this:
```
location /nginx-blackout {
    root /var/www;
    break;
 }

 location / {
    if ($time_iso8601 ~ ^2019-12-31T09:[0-2][0-9]:[0-9][0-9] ) {
    	return 302 /nginx-blackout;
    }
    # ... usual location config
 }
 ```

4. Check that it works with the current date.
5. Prepare PR with your setup.

The mentor should be able to simply use your files, run `kubectl create -f yourfile.yaml`, and have your completed and fixed environment running for review.

### Optional task: made same config by using custom image for nginx

# HomeWork The Last One

## Setup
Fork [github repo](https://github.com/zadeploy/profile_app)

## Summary
It's time to check whether you will to be in the camp! All you need is to deploy the app from the forked repo, but as usually you have to face some difficulties.
## Instructions

1. Get the repo and run it locally. After the launch, just open the root route.
You can use this command to launch the app:
```
rackup
```
2. Choose a CI/CD service (Gitlab/CircleCI/TravisCI/your_favourite_service).
[Here](https://circleci.com/docs/2.0/configuration-reference/) you can find how to configure [CircleCI](https://circleci.com/).
3. Build pipline for the selected service with 3 stages:
  - [rspec](https://rspec.info/)
  - [rubocop](https://www.rubocop.org/en/stable/)
  - deploy
4. Deploy your app to [Heroku](https://heroku.com/).
5. After the deployment you'll get the link where you app lives.
6. Submit this link to the [Form](https://forms.gle/BzqcZveuX15577297).

# Courses HomeWork #1
## Setup
How to [install OS](https://www.raspberrypi.org/documentation/installation/installing-images/)
## Summary
We build our own Data Center.
You've got Rasbperry PI 4. Install Ubuntu - prepare a brick for Data Center.

## Instructions
1. Prepare setup instructions and scripts to repro it.

# Courses HomeWork #2
## Summary
The Division of Economic and Risk Analysis (DERA) has assembled information on
internet search traffic for EDGAR filings through SEC.gov.

The EDGAR Log File Data Set contains information in CSV format extracted from
Apache log files that record and store user access statistics
for the SEC.gov website.
## Instructions
### Part 1
0. Download [file](http://www.sec.gov/dera/data/Public-EDGAR-log-file-data/2017/Qtr2/log20170630.zip) using shell
1. Unpack the log file
2. Change owner of log file to your current user using chown
3. Change set executive bit to a random.sh script using chmod
4. Execute the random.sh script
5. Find the file using find
6. Try to look for errors using your favorite editor
7. Try to find errors using grep
8. Tail last 500 lines of file
9. Find how many index.htm hits were at 30.06.2017 14:00
10. Find how many index.htm hits were at 30.06.2017 17:00-18:00
11. Show the number of times each IP shows up in the log – using sort and uniq utilities
12. Count all 13.94.212.jdf IP hits us
### Part 2
0. Create script which will:
 - Add ubuntu user to adm and root groups using sed
 - Change timezone to Europe/Berlin in /etc/timezone using sed
 - Change timezone to Europe/Minsk using bash shell utilites and apply it using system commands

### Part 3
0. Examine ls using strace command:
- apt-get install strace
- strace ls ./
1. Assess how Linux executes the ./random.sh script
- touch log20170630.csv
- strace ./random.sh
2. Count number of “mv” command paths using pipes and grep for strace ./random.sh
# Courses HomeWork #3
## Setup
## Summary
Today we will fight with DHCP ips registration!

The idea is to use dynamic DNS FQDN registration and create/update the FQDN for
your raspberry each time it goes on reboot.

## Instructions
0. Create a script which will add Cloudflare DNS to your raspberry
```
/etc/resolv.conf

arya.ns.cloudflare.com

chance.ns.cloudflare.com
```
1. Create a script to automatically register your raspberry in Cloudflare
dynamic DNS using REST API (https://api.cloudflare.com/#dns-records-for-a-zone-properties )

Script should check:
  - if the name is already existing – notify user
  - if the name is missing – create new record
  - if the ip is the same – skip registration & exit
  - if the ip is present and is different – update record with new ip

Script should comply with the following reqs
  - TTL should be low
  - Script should handle an error if any and provide user with Cloudflare response messages
  - Check your syntax with BASH -N

2. Create a function to perform curl to Cloudflare API and return response as an
array, Function should accept array of arguments with data required to do a
requestScript should accept only one argument – FQDN you want to assign to raspberry

```
register_pi_name student_lastname.lab.zadeploy.com
```
3. Create autostart systemd script to enable your script on [Pi boot](https://askubuntu.com/a/719157)
