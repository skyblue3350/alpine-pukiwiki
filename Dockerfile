FROM alpine:3.6
MAINTAINER skyblue3350 <skyblue3350@gmail.com>

EXPOSE 80

# pukiwiki default config
ENV WIKI="pukiwiki-1.5.1_utf8" \
    WIKI_VER=64807 \
    WIKI_INSTALL_DIR="/var/www" \
    WIKI_PUKIWIKI_URL="http://example.com/wiki" \
    WIKI_MODIFIER="admin" \
    WIKI_MODIFIER_LINK="http://example.com" \
    WIKI_ADMINPASS="adminpass" \
    WIKI_DEFAULT_PAGE="FrontPage" \
    WIKI_PAGE_TITLE="docker pukiwiki" \
    WIKI_WHATSNEW="RecentChanges" \
    WIKI_WHATSDELETED="RecentDeleted" \
    WIKI_INTERWIKI="InterWikiName" \
    WIKI_MENUBAR="MenuBar"

# pukiwki
RUN rm -rf $WIKI_INSTALL_DIR* \
  && wget -q http://jaist.dl.osdn.jp/pukiwiki/$WIKI_VER/$WIKI.zip
#  && unzip -q $WIKI.zip -d $WIKI_INSTALL_DIR \
#  && mv $WIKI/* $WIKI_INSTALL_DIR \
#  && rm -rf $WIKI.zip $WIKI

# nginx & php-fpm config
COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY conf/php.ini /etc/php7/php.ini
COPY entry.sh /sbin/entry.sh
RUN chmod 755 /sbin/entry.sh \
  && mkdir -p /run/nginx \
  && apk add --no-cache nginx php7-fpm php7-json php7-curl

VOLUME ["${WIKI_INSTALL_DIR}"]
ENTRYPOINT ["/sbin/entry.sh"]

