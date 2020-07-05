<h3 align="center">CloudPush</h3>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![GitHub Issues](https://img.shields.io/github/issues/placid-void/cloudpush.svg)](https://github.com/placid-void/cloudpush/issues)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

</div>

---

<p align="center"> Ansible playbook to deploy the ultimate media server, using cloud based storage.
    <br> 
</p>

## 📝 Table of Contents

- [Getting Started](#getting_started)
- [Deployment](#deployment)
- [Usage](#usage)
- [Built Using](#built_using)
- [Authors](#authors)
- [Acknowledgments](#acknowledgement)
- [TODO](TODO.md)

## 🧐 About <a name = "about"></a>

This project started after years of manual administration of a Plex server and associated services. It's focus is to automate standing up and updating a wide array of applications. Utilizing cloud storage via Rclone, and Duplicacy to backup application data.

## 🏁 Getting Started <a name = "getting_started"></a>

Clone the repo locally and make a copy of the vars.yml.example file to fill out with your variables. You will notice a significant portion of the vars use the lastpass lookup to pull their contents. I did this to keep next to no personal information in the playbook, and to prevent any secrets from making it into the codebase. Handle your secrets how you see fit. See [deployment](#deployment) for notes on how to deploy the project on a live system.

### Prerequisites

This playbook is currently compatiable with Ansible 2.9.6. The playbook is currently designed to be run on a bare-metal Ubuntu Server 20.04 based system. As the vast majority of the roles only interact with the docker service, you should be able to modify this to work on your OS of choice by modifying the host-setup role.

## 🎈 Usage <a name="usage"></a>

If you are starting with a clean slate, you will have to configure many of the applications yourself through their GUI. If you have appdata from previous installations, you should be able to import this data to the respective applications appdata folder. Verify that the paths match up with the volumes and paths expected for each container.

Following the pre-defined container paths on both the host side and container side for the Docker bind volumes is highly recommended. The current layout is able to take advantage of direct writes and hardlinking. Using a different folder structure should work, but you may see increased overhead.

## 🚀 Deployment <a name = "deployment"></a>

After modifying your own vars file, the host-setup role should be ran solo. This will prepare the host environment. After that, all Core Services roles should be run.

### Applications Overview

# Core Services

- [Duplicacy](https://hub.docker.com/r/erichough/duplicacy) - Backup Application Data to cloud storage# Core Services
- [Fail2Ban](https://hub.docker.com/r/crazymax/fail2ban) - Harden and secure the host
- [GC](https://hub.docker.com/r/spotify/docker-gc) - Docker Garbage Collection
- [Rclone](https://hub.docker.com/r/rclone/rclone) - Mounts Cloud Storage to the host
- [Traefik](https://hub.docker.com/_/traefik) - # Reverse Proxy
- [Watchtower](https://hub.docker.com/r/containrrr/watchtower) - # Update Containers

# Administration

- [Adminer](https://hub.docker.com/_/adminer) - # Database Administration
- [cAdvisor](https://github.com/google/cadvisor) - # Docker Administration
- [CloudBeaver](https://hub.docker.com/r/dalongrong/cloudbeaver) - # Database Administration
- [Portainer](https://hub.docker.com/r/portainer/portainer) - Docker Administration
- [Promgen](https://hub.docker.com/r/line/promgen) - Prometheus Administration

# Alerts and Metrics

- [AlertManager-SNS-Forwarder](https://github.com/DataReply/alertmanager-sns-forwarder) - Prometheus Alertmanager Webhook Receiver for forwarding alerts to AWS SNS
- [Node-Exporter](https://hub.docker.com/r/prom/node-exporter) - Prometheus agent
- [Prometheus](https://hub.docker.com/r/prom/prometheus) - Metrics Collector
- [StatPing](https://hub.docker.com/r/statping/statping) - Status Page

# Database Services

- [InfluxDB](https://hub.docker.com/_/influxdb) - InfluxDB Server
- [MariaDB](https://hub.docker.com/r/linuxserver/mariadb) - MariaDB Server
- [PostgreSQL](https://hub.docker.com/_/postgres) - PostgreSQL Server
- [Redis](https://hub.docker.com/_/redis) - Redis Server

# Downloaders

- [Alltube](https://hub.docker.com/r/rudloff/alltube) - Youtube Downloader
- [Deluge](https://hub.docker.com/r/binhex/arch-delugevpn) - Torrent Downloader
- [GoAutoYT](https://hub.docker.com/r/xiovv/go-auto-yt) - Youtube Downloader
- [NZBGet](https://hub.docker.com/r/linuxserver/nzbget) - Usenet Downloader

# Media Managers

- [Bazarr](https://hub.docker.com/r/linuxserver/bazarr) - Subtitle Manager
- [Lazy Librarian](https://hub.docker.com/r/linuxserver/lazylibrarian) - Book Library Manager
- [Lidarr](https://hub.docker.com/r/linuxserver/lidarr) - Music Manager
- [Mylar](https://hub.docker.com/r/linuxserver/mylar) - Comicbook Manager
- [Radarr](https://hub.docker.com/r/linuxserver/radarr) - Movie Manager
- [Readarr](https://hub.docker.com/r/hotio/readarr) - *arr style Book Library Manager
- [Sonarr](https://hub.docker.com/r/linuxserver/sonarr) - TV Show Manager

# Public Services

- [Bookstack](https://hub.docker.com/r/linuxserver/bookstack) - Selfhosted Wiki
- [Emby](https://hub.docker.com/r/emby/embyserver) - Plex Server alternative
- [Mellow](https://hub.docker.com/r/voidp/mellow) - Discord Bot
- [NextCloud](https://hub.docker.com/r/linuxserver/nextcloud) - Selfhosted Cloud Storage
- [Ombi](https://hub.docker.com/r/linuxserver/ombi) - Issues and Requests application, works through the Lidarr, Sonarr and Radarr API
- [Organizr](https://hub.docker.com/r/organizrtools/organizr-v2) - Central Services Organization
- [Plex](https://hub.docker.com/r/linuxserver/plex) - Media Server
- [Speedtest](https://hub.docker.com/r/adolfintel/speedtest) - Speedtest application
- [SyncLounge](https://hub.docker.com/r/starbix/synclounge) - Watch Plex with friends

# Statistics

- [EmbyStat](https://hub.docker.com/r/linuxserver/embystat) - Emby Server Statistics
- [Grafana](https://hub.docker.com/search?q=grafana&source=community) - Dashboards and Graphs
- [Tautulli](https://hub.docker.com/r/linuxserver/tautulli) - Plex Server Statistics
- [Varken](https://hub.docker.com/r/boerderij/varken) - Aggregates data from Plex into Grafana and InfluxDB

# Support Services

- [NZBHydra](https://hub.docker.com/r/linuxserver/nzbhydra2) - NZB Indexer meta search provider 
- [Syncarr](https://hub.docker.com/r/syncarr/syncarr) - Sync *arr Applications
- [Traktarr](https://hub.docker.com/r/eafxx/traktarr) - Trakt.tv integeration with Sonarr and Radarr
- [Tdarr](https://hub.docker.com/r/haveagitgat/tdarr) - Used to check and convert media specifics on library content

## ⛏️ Built Using <a name = "built_using"></a>

- [Ansible](https://ansible.com/) - Automation Framework

## ✍️ Authors <a name = "authors"></a>

- [@placid-void](https://github.com/placid-void)

## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- This wouldn't be possible without the excellent developers making the applications included in this playbook. 
- [@PlexGuide.com](https://github.com/plexguide/PlexGuide.com) was a great inspiration when I first got started.
- [@ajkis](https://github.com/ajkis) has made excellent scripts that are included in this repo, as they have been customized for this playbook.
