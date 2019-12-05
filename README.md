# DevOps Survival Camp: Winter 2020

<img src="https://zadeploy.s3.eu-central-1.amazonaws.com/Logo+with+description+black.png" data-canonical-src="https://zadeploy.s3.eu-central-1.amazonaws.com/Logo+with+description+black.png" width="300" />

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
