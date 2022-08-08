FROM alpine:3.13 as base

LABEL maintainer="xiong.han"

ENV TENGINE_VERSION=2.3.3

RUN  addgroup -S nginx \
     && adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx nginx \
     && addgroup -g 82 -S www-data && adduser -u 82 -D -S -G www-data www-data \
     && apk add --no-cache tzdata


FROM base as build

ENV CONFIG "--prefix=/etc/nginx \
        --sbin-path=/usr/sbin/nginx \
        --modules-path=/usr/lib/nginx/modules \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --pid-path=/var/run/nginx.pid \
        --lock-path=/var/run/nginx.lock \
        --http-client-body-temp-path=/var/cache/nginx/client_temp \
        --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
        --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
        --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
        --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
        --user=nginx \
        --group=nginx \
        --with-poll_module \
        --without-procs \
        --with-threads \
        --with-file-aio \
        --with-http_ssl_module \
        --with-http_v2_module \
        --with-http_realip_module \
        --with-http_addition_module \
        --with-http_xslt_module \
        --with-http_xslt_module=dynamic \
        --with-http_image_filter_module  \
        --with-http_image_filter_module=dynamic \
        --with-http_geoip_module \
        --with-http_geoip_module=dynamic \
        --with-http_sub_module \
        --with-http_dav_module \
        --with-http_flv_module \
        --with-http_mp4_module \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-http_auth_request_module \
        --with-http_random_index_module \
        --with-http_secure_link_module \
        --with-http_degradation_module \
        --with-http_slice_module \
        --with-http_stub_status_module \
        
        --with-mail \
        --with-mail_ssl_module \
        
        --with-stream \
        --with-stream_ssl_module \
        --with-stream_ssl_preread_module \
        --with-stream_realip_module \
        --with-stream_geoip_module=dynamic \
        --with-stream_ssl_preread_module \
        --with-stream_sni \
        --with-compat \
        --with-pcre  \
        
        --without-http_upstream_keepalive_module \
        --add-module=modules/ngx_http_concat_module \
        --add-module=modules/ngx_http_footer_filter_module \
        --add-module=modules/ngx_http_proxy_connect_module \
        --add-module=modules/ngx_http_reqstat_module \
        --add-module=modules/ngx_http_slice_module \
        --add-module=modules/ngx_http_upstream_check_module \
        --add-module=modules/ngx_http_upstream_dynamic_module \
        --add-module=modules/ngx_http_upstream_dyups_module \
        --add-module=modules/ngx_http_upstream_keepalive_module \
        --add-module=modules/ngx_http_upstream_session_sticky_module \
        --add-module=modules/ngx_http_upstream_vnswrr_module \
        --add-module=modules/ngx_http_user_agent_module \
        --add-module=modules/ngx_multi_upstream_module \
        --add-module=modules/ngx_slab_stat \
        "

RUN apk add --no-cache --virtual .build-deps \
        gcc \
        libc-dev \
        make \
        openssl-dev \
        pcre-dev \
        zlib-dev \
        linux-headers \
        curl \
        libxslt-dev \
        gd-dev \
        geoip-dev \
     && curl -L "https://github.com/alibaba/tengine/archive/$TENGINE_VERSION.tar.gz" -o tengine.tar.gz \
     && mkdir -p /usr/src \
     && tar -zxC /usr/src -f tengine.tar.gz \
     && rm tengine.tar.gz \
     && cd /usr/src/tengine-$TENGINE_VERSION \
     && ls -l /usr/src/tengine-$TENGINE_VERSION/modules \
     && ./configure $CONFIG \
     && make -j$(getconf _NPROCESSORS_ONLN) \
     && make install \
     && mkdir /etc/nginx/conf.d/ \
     && mkdir -p /usr/share/nginx/html/ \
     && ln -s ../../usr/lib/nginx/modules /etc/nginx/modules \
     && strip /usr/sbin/nginx* \
     && strip /usr/lib/nginx/modules/*.so



FROM base as running

COPY --from=build /etc/nginx /etc/nginx
COPY --from=build /usr/lib/nginx /usr/lib/nginx
COPY --from=build /usr/sbin/nginx /usr/sbin/nginx
COPY --from=build /var/log/nginx /var/log/nginx

RUN apk add --no-cache --virtual .gettext gettext \
     && mv /usr/bin/envsubst /tmp/ \
     && runDeps="$( \
             scanelf --needed --nobanner --format '%n#p' /usr/sbin/nginx /usr/lib/nginx/modules/*.so /tmp/envsubst \
                     | tr ',' '\n' \
                     | sort -u \
                     | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
     )" \
     && echo $runDeps \
     && apk add --no-cache --virtual .nginx-rundeps $runDeps \
     && apk del .gettext \
     && mv /tmp/envsubst /usr/local/bin/ \
     && ln -sf /dev/stdout /var/log/nginx/access.log \
     && ln -sf /dev/stderr /var/log/nginx/error.log

WORKDIR /etc/nginx
    
EXPOSE 80 443

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]