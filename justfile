init:
    scripts/init.sh

setup-service name image="":
    scripts/setup-service.sh {{name}} {{image}}

status:
    watch flux get all -A --status-selector ready=false