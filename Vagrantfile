require "yaml"
parameters = YAML.load_file "parameters.yml"

VAGRANTFILE_API_VERSION = "2"
VM_BOX = parameters["vm"]["box"]
VM_HOSTNAME = parameters["vm"]["host_name"]
VM_DOMAIN = parameters["vm"]["domain"]
VM_CPUS = parameters["vm"]["cpu"]
VM_MEMORY = parameters["vm"]["memory"]
VM_IP = parameters["vm"]["ip"]
VM_PORT = parameters["vm"]["port"]
VM_HOSTPATH = parameters["vm"]["host_path"]
VM_SYNCED_FOLDER = parameters["vm"]["synced_folder"]
VM_PUBLIC_DIR = parameters["vm"]["public_dir"]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = VM_BOX
  config.vm.provider :virtualbox do |vb|
    vb.name = VM_HOSTNAME + "." + VM_DOMAIN
    vb.customize [
      "modifyvm", :id,
      "--name", VM_HOSTNAME + "." + VM_DOMAIN,
      "--memory", VM_MEMORY,
      "--natdnshostresolver1", "on",
      "--cpus", VM_CPUS,
    ]
  end

  config.vm.host_name = VM_HOSTNAME + "." + VM_DOMAIN

  config.vm.network :private_network, ip: VM_IP
  config.vm.network "forwarded_port", guest: 80, host: VM_PORT
  config.ssh.forward_agent = true

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/main.yml"
    ansible.limit = "all"
    ansible.extra_vars = {
      parameters: parameters,
      ip: VM_IP,
      host_path: VM_HOSTPATH,
      host_name: VM_HOSTNAME,
      domain: VM_DOMAIN,
      public_dir: VM_PUBLIC_DIR
    }
  end

  config.vm.synced_folder "../", VM_HOSTPATH + "/" + VM_HOSTNAME + "." + VM_DOMAIN, type: VM_SYNCED_FOLDER
end
