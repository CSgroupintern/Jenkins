echo 'connected to $tgt';\
                            cd /tmp; mkdir -p scans-jenkins-sec; \
                            echo 'Downloading archive' ; \
                            cd /tmp/scans-jenkins-sec; wget -N https://github.com/CSgroupintern/Jenkins/raw/master/Jenkins-pipe.tar.gz; \
                            cd /tmp/scans-jenkins-sec;\
                            echo 'Extracting archive' ;\
                            tar -xvf Jenkins-pipe.tar.gz;\
                            sudo chmod +x kube-bench/kube-bench;\
                            sudo chmod +x docker-bench-security/docker-bench-security.sh;\
                            sudo chmod +x launch_kube.sh;\
                            cd docker-bench-security;\
                            cd /tmp/scans-jenkins-sec/docker-bench-security;\
                            echo 'Running Benchmark';\
                            sudo ./docker-bench-security.sh -b -l ../log1.log;\
                            echo '[FINAL RESULTS]' > /tmp/scans-jenkins-sec/sv
                            cat /tmp/scans-jenkins-sec/log1.log | tail -1 | cut -d ' ' -f3 >> /tmp/scans-jenkins-sec/sv;\
                            cat /tmp/scans-jenkins-sec/log1.log | tail -2 | head -1 | cut -d ' ' -f3 >> /tmp/scans-jenkins-sec/sv;\
                            sudo mv /tmp/scans-jenkins-sec/kube-bench/ /etc; \
cd /tmp/scans-jenkins-sec/centos-cis-benchmark ; \
sudo chmod +x run-cis-benchmark.sh ; \
sudo ./run-cis-benchmark.sh > ../centos-bench-results ; \
cat ../centos-bench-results; \
cat ../centos-bench-results | grep FAIL | wc -l >> /tmp/scans-jenkins-sec/sv ; \
                            cd /tmp/scans-jenkins-sec/; \
                            ./launch_kube.sh | tail -3 | head -1 >> /tmp/scans-jenkins-sec/sv; cat  /tmp/scans-jenkins-sec/sv | sed ':a;N;$!ba;s/\n/ /g'; rm -rf /tmp/scans-jenkins-sec