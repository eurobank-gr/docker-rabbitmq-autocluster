FROM rabbitmq:3-management

ARG AUTOCLUSTER_VERSION=0.10.0

ENV RABBITMQ_USE_LONGNAME=true \
    AUTOCLUSTER_LOG_LEVEL=debug \
    AUTOCLUSTER_CLEANUP=true \
    CLEANUP_INTERVAL=60 \
    CLEANUP_WARN_ONLY=false \
    AUTOCLUSTER_TYPE=k8s \
    LANG=en_US.UTF-8

# Add the two autocluster plugins
ADD https://github.com/rabbitmq/rabbitmq-autocluster/releases/download/$AUTOCLUSTER_VERSION/autocluster-$AUTOCLUSTER_VERSION.ez /plugins
ADD https://github.com/rabbitmq/rabbitmq-autocluster/releases/download/$AUTOCLUSTER_VERSION/rabbitmq_aws-$AUTOCLUSTER_VERSION.ez /plugins

# Reset 644 access rights for all plugins
RUN chmod 644 /plugins/*

# Enable autocluster and shovel plugins
RUN rabbitmq-plugins enable --offline rabbitmq_shovel
RUN rabbitmq-plugins enable --offline rabbitmq_shovel_management
RUN rabbitmq-plugins enable --offline autocluster
