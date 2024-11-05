# Vagrant for Go

This repository contains ready-to-use Vagrant environment for Go development.

## Prerequisites

Before starting, make sure you have the following installed on your machine:

1. [Vagrant](https://www.vagrantup.com/downloads) (version 2.2.10 or higher)
2. [VMware Desktop](https://www.vmware.com/products/workstation-pro.html)
   1. macOS: VMware Fusion Pro 13
   2. Windows: VMware Workstation Pro 17 
3. [Vagrant VMware Utility](https://www.vagrantup.com/docs/vmware/vagrant-vmware-utility)
4. [vagrant-vmware-desktop plugin](https://www.vagrantup.com/docs/providers/vmware/installation)
5. [Ruby Gem dotenv plugin](https://rubygems.org/gems/dotenv)

## Installation

### Install Vagrant

Download and install Vagrant from the [official website](https://www.vagrantup.com/downloads).

### Install VMware Desktop

Download and install VMware Workstation Pro 17 (for Linux/Windows) or VMware Fusion Pro 13 (for macOS) from the [official VMware website](https://www.vmware.com/products/workstation-pro.html).

### Install Vagrant VMware Utility

Follow the installation instructions for the [Vagrant VMware Utility](https://www.vagrantup.com/docs/vmware/vagrant-vmware-utility) appropriate for your operating system.

### Install the Vagrant VMware Desktop Plugin

Install the plugin by running the following command:

```sh
vagrant plugin install vagrant-vmware-desktop
```

### Install the Ruby Gem dotenv

Install the Ruby Gem `dotenv` to load environment variables from a `.env` file:

```sh
vagrant plugin install dotenv
```

## Usage

### Start the Virtual Machine

To start the virtual machine, run the following command in the directory containing the Vagrantfile:

```sh
vagrant up
```

### Connect to the Virtual Machine

Once the virtual machine is up and running, you can connect to it via SSH with the following command:

```sh
vagrant ssh
```

### Stop the Virtual Machine

To stop the virtual machine, run:

```sh
vagrant halt
```

### Destroy the Virtual Machine

To destroy the virtual machine and free up resources, run:

```sh
vagrant destroy
```

## Environment Variables

This environment uses a `.env` file to manage environment variables. The following variables can be configured in the `.env` file:

- `GO_VERSION`: The version of Go to install (defaults to 1.20).
- `VAGRANT_CONFIG_CPU`: The number of CPUs to allocate to the virtual machine (defaults to 1).
- `VAGRANT_CONFIG_MEMORY`: The amount of memory (in MB) to allocate to the virtual machine (defaults to 1024).
- `VAGRANT_CONFIG_SYNCED_FOLDERS_FILE`: The path to the JSON file containing the synced folder configuration (defaults to `./volumes.json`).

Exemple `.env` file:

```sh
GO_VERSION="1.20"
VAGRANT_CONFIG_CPU="2"
VAGRANT_CONFIG_MEMORY="2048"
VAGRANT_CONFIG_SYNCED_FOLDERS_FILE="./volumes.json"
```

## Synced Folders

This Vagrant environment uses a dynamic synced folder configuration. The synced folders are defined in a JSON file specified by the `VAGRANT_CONFIG_SYNCED_FOLDERS_FILE` environment variable in the `.env` file.

The JSON file should contain an array of objects, where each object represents a synced folder with the following properties:

- `host`: The path to the folder on the host machine.
- `guest`: The path to the folder on the guest machine.
- `type`: The type of synced folder (e.g., rsync, virtualbox).
- `id`: An optional ID for the synced folder.

Exemple `volumes.json`:

```json
[
  {
    "host": "/path/on/host/1",
    "guest": "/path/on/guest/1",
    "type": "rsync",
    "id": "folder1"
  },
  {
    "host": "/path/on/host/2",
    "guest": "/path/on/guest/2",
    "type": "rsync",
    "id": "folder2"
  }
]
```

Notes:
- Replace `/path/on/host/1`, `/path/on/guest/1`, etc. with your actual paths.
- The `type` property can be set to rsync for faster syncing performance, especially for larger projects.
- The `id` property is optional and can be used to identify the synced folder.

## Contributing

Contributions are welcome and encouraged!  Here's how you can contribute to this project:

- **Report issues:** If you encounter any problems or have suggestions for improvements, please open an issue on the GitHub repository.   
- **Fork the repository:** Feel free to fork the repository and make changes.
- **Submit pull requests:** If you have made improvements or bug fixes, please submit a pull request.