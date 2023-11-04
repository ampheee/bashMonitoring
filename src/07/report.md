sudo snap install grafana
sudo apt install prometheus

sudo systemctl status grafana
sudo systemctl status prometheus

ssh -f -N babbling@localhost -L 8080: babbling@localhost:300