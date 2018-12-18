ssg() {
        ssh $@ "cat > /tmp/.bashrc_temp" < ~/envconfig/.bashrc_remote
        ssh -t $@ "bash --rcfile /tmp/.bashrc_temp ; rm /tmp/.bashrc_temp"
    }
