#! /bin/bash 

sleep 15s


#while ! nc -w 1 $host $port 2>/dev/null
#do
#  echo -n .
#  sleep 1
#done

#rm sites/default/settings.php
if [ ! -d sites/default/files ]; then mkdir sites/default/files ; fi 
chmod a+rx sites/default/files
chmod ug+w sites/default/files
chown -R www-data:www-data sites/default/files

drush site-install ${DRUPAL_PROFILE} --account-name=${ACCOUNT_NAME} --account-pass=${ACCOUNT_PASS} --site-name="invotra-bightly" --db-url=mysql://root:${MYSQL_ROOT_PASSWORD}@db/${INVOTRA_DB} -y
drush en bartik omega seven invotra_base -y 
drush vset theme_default invotra_base -y 
drush fra -y

chown -R www-data:www-data sites/default/files

#drush ucrt webmaster --password="webmaster"
#drush urol "webmaster" --name=webmaster
# Drupal settings.php
(
  cat <<END
\$conf['search_api_solr_overrides'] = array(
  'solr_prototype' => array(
    'name' => t('Invotra-Profile'),
    'options' => array(
      'host' => 'solr',
      'port' => 8983,
      'path' => '/solr/drupal',
    ),
  ),
);

\$conf["cache_backends"][] = "sites/all/modules/contrib/memcache/memcache.inc";
\$conf["cache_default_class"] = "MemCacheDrupal";
\$conf["cache_class_cache_form"] = "DrupalDatabaseCache";
\$conf["memcache_servers"] = array("memcached:11211" => "default");
END
) >> "sites/default/settings.php"