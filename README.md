# tinyCI demo repository

This repository contains the vagrant demo for tinyCI. It, by default, runs one
instance of the tinyCI VM for UI and other services, and another for a docker
runner (overlay-runner). You can customize it to run multiple runners.

Before anything, you need the following tools installed and operational:

* VirtualBox
* Vagrant 
* Ansible

Firstly, setup an [oauth account](https://github.com/settings/developers). Make it look like this:

<center><img width="640" src="github-oauth-settings.png" /></center>

* Clone this repository.
* Get a copy of the release as `release.tar.gz`, and put it at the root of this
  repository's clone.
* Create a `customize.rb` from the sample file. Be sure to include the client
  values from the oauth creation step above!
* Run `make setup`.
* Assuming `make setup` succeeds, run `make start`.

If you want a really quick start and want to see the jobs run:

* Fork `tinyci/ci-ui` (a few small jobs) or `tinyci/ci-agents` (lots of jobs).
* In the UI, add this fork with the "Add" button on the hamburger
  menu/repository list.
* Then, "Submit" the repository's master branch using the UI element at the top
  of the web page.
