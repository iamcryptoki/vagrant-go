require 'dotenv'
Dotenv.load

Vagrant.configure("2") do |config|
  # Set the default provider to VMware Desktop
  config.vm.provider :vmware_desktop do |vmware|
    vmware.vmx["ethernet0.pcislotnumber"] = "256"
    vmware.vmx["ethernet0.virtualdev"] = "vmxnet3"

    # Specify CPU and memory resources
    vmware.vmx["numvcpus"] = ENV['VAGRANT_CONFIG_CPU'] || "1"
    vmware.vmx["memsize"]  = ENV['VAGRANT_CONFIG_MEMORY'] || "1024"
  end

  # Configure the virtual machine
  config.vm.define "node" do |node|
    # Specify the box to use
    node.vm.box = "bento/ubuntu-22.04"
    # Configure port forwarding
    node.vm.network "forwarded_port", guest: 22, host: 2230
    # Provisioning script configuration
    node.vm.provision "shell", path: "provision.sh", env: { 
      "GO_VERSION" => ENV['GO_VERSION'] || "1.23.2"
    }

    # Dynamic synced folder configuration from environment variable
    if ENV['VAGRANT_CONFIG_SYNCED_FOLDERS_FILE']
      synced_folders = JSON.parse(File.read(ENV['VAGRANT_CONFIG_SYNCED_FOLDERS_FILE']))

      synced_folders.each do |folder|
        node.vm.synced_folder folder['host'], folder['guest'], 
          type: folder['type'], id: folder['id']
      end
    end
  end
end