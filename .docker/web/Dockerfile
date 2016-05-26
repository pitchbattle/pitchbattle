FROM nginx

RUN apt-get update -qq && apt-get -y install apache2-utils

ENV RAILS_ROOT /var/www/pitchbattle

WORKDIR $RAILS_ROOT

RUN mkdir log

COPY public public/

COPY .docker/web/nginx.conf /tmp/pitchbattle.nginx

# substitute variable references in the Nginx config template for real values from the environment
# put the final config in its place
RUN envsubst '$RAILS_ROOT' < /tmp/pitchbattle.nginx > /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
