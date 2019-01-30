echo "============================================================"
echo "**********Blade core System Init****************************"
echo "============================================================"

echo "Stop all Services for Blade core System..."
docker-compose down
echo "Start Service Redis..."
docker-compose up -d blade-redis
echo "Start Service Mysql..."
docker-compose up -d blade-db
until nc -z -v -w30 127.0.0.1 33302
do
  echo "Waiting for database connection..."
  # wait for 5 seconds before check again
  sleep 5
done
echo "Waiting 30 seconds for Mysql Init..."
sleep 30
echo "Create database and user ..."
docker-compose exec blade-db mysql -uroot -P 33302 -proot -e "grant all on *.* to 'root'@'%' identified by 'root' with grant option;"
docker-compose exec blade-db mysql -uroot -P 33302 -proot -e "create database blade CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
echo "Wating some time for db migrate..."
docker-compose exec blade-db mysql -uroot -P 33302 -proot -e "use blade; source /data/blade_db.dmp;"
echo "Start blade_app1 and blade_app2 ... "
docker-compose up -d blade_app1
docker-compose up -d blade_app2
echo "Reset Password to default"
docker-compose exec blade_app1 rails runner /app/script/custom/pass6.rb
echo "Start Nginx ..."
docker-compose up -d nginx_web

echo "Blade core System up now, Congratulation"