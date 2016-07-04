Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/trusty64"
	config.vm.provision "shell",
    inline: "curl -fsSL https://test.docker.com/ | sh \
    	&& sudo groupadd docker \
    	&& sudo usermod -aG docker vagrant \
    	&& sudo su \
    	&& curl -L https://github.com/docker/compose/releases/download/1.8.0-rc1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose \
    	&& su vagrant \
    	&& chmod +x /usr/local/bin/docker-compose \
    	&& cd /opt \
    	&& git clone http://github.com/vietanh85/hadoop-docker \
    	&& cd hadoop-docker \
    	&& docker-compose -f docker-compose.build.yml pull"
  config.push.define "atlas" do |push|
	  push.app = "vietanh85/hadoop-docker"
	end
end
