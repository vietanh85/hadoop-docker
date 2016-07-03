Vagrant.configure("2") do |config|
  (1..3).each do |i|
    config.vm.define "worker#{i}" do |worker|
      worker.vm.hostname = "worker#{i}"
      worker.vm.box = "ubuntu/trusty64"
      worker.vm.network "private_network", type: "dhcp"
      worker.vm.provision "shell",
        inline: "curl -fsSL https://test.docker.com/ | sh"
    end
  end
end
