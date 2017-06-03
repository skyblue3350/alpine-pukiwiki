#!/bin/sh

# pukiwiki path
CONFIGPATH="${WIKI_INSTALL_DIR}/pukiwiki.ini.php"

unzip $WIKI.zip

if [ -z  "$(ls -A $WIKI_INSTALL_DIR)" ]
then
    cp -R $WIKI/* $WIKI_INSTALL_DIR
else
    cp $WIKI/pukiwiki.ini.php $WIKI_INSTALL_DIR
fi

rm -rf $WIKI.zip
rm -rf $WIKI

chmod 777 $WIKI_INSTALL_DIR/attach
chmod 777 $WIKI_INSTALL_DIR/backup
chmod 777 $WIKI_INSTALL_DIR/cache
chmod 666 $WIKI_INSTALL_DIR/cache/*.dat
chmod 666 $WIKI_INSTALL_DIR/cache/*.ref
chmod 666 $WIKI_INSTALL_DIR/cache/*.rel
chmod 777 $WIKI_INSTALL_DIR/counter
chmod 777 $WIKI_INSTALL_DIR/diff
chmod 755 $WIKI_INSTALL_DIR/image
chmod 755 $WIKI_INSTALL_DIR/image/face
chmod 755 $WIKI_INSTALL_DIR/lib
chmod 755 $WIKI_INSTALL_DIR/plugin
chmod 755 $WIKI_INSTALL_DIR/skin
chmod 777 $WIKI_INSTALL_DIR/wiki
chmod 666 $WIKI_INSTALL_DIR/wiki/*.txt

echo "config generate"
sed -ie "s|//\$script = 'http://example.com/pukiwiki/';|\$script = '${WIKI_PUKIWIKI_URL}';|g" $CONFIGPATH
sed -ie "s/$modifier = 'anonymous';/$modifier = '${WIKI_MODIFIER}';/" $CONFIGPATH
sed -ie "s|$modifierlink = 'http://pukiwiki.example.com/';|$modifierlink = '${WIKI_MODIFIER_LINK}';|" $CONFIGPATH
sed -ie "s/$adminpass = '{x-php-md5}!';/$adminpass = '${WIKI_ADMINPASS}';/" $CONFIGPATH
sed -ie "s/$defaultpage  = 'FrontPage';/$defaultpage  = '${WIKI_DEFAULT_PAGE}';/" $CONFIGPATH
sed -ie "s/$whatsnew     = 'RecentChanges';/$whatsnew     = '${WIKI_WHATSNEW}';/" $CONFIGPATH
sed -ie "s/$whatsdeleted = 'RecentDeleted';/$whatsdeleted = '${WIKI_WHATSDELETED}';/" $CONFIGPATH
sed -ie "s/$interwiki    = 'InterWikiName';/$interwiki    = '${WIKI_INTERWIKI}';/" $CONFIGPATH
sed -ie "s/$menubar      = 'MenuBar';/$menubar      = '${WIKI_MENUBAR}';/" $CONFIGPATH
sed -ie "s/$page_title = 'PukiWiki';/$page_title = '${WIKI_PAGE_TITLE}';/" $CONFIGPATH

# start php-fpm7
php-fpm7

# start nginx service
nginx -g "daemon off;"

