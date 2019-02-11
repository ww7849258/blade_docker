echo "============================================================"
echo "**********Blade core System Init****************************"
echo "============================================================"

echo "Stop all Services for Blade core System..."
docker-compose down
echo "Start Service Redis..."
docker-compose up -d blade-redis
echo "Start Service Mysql..."
docker-compose up -d blade-db
until nc -z -v -w30 127.0.0.1 33306
do
  echo "Waiting for database connection..."
  # wait for 5 seconds before check again
  sleep 5
done
echo "Waiting 30 seconds for Mysql Init..."
# sleep 30
echo "Start blade_app1 and blade_app2 ... "
docker-compose up -d blade_app1
docker-compose up -d blade_app2
echo "Start Nginx ..."
docker-compose up -d nginx_web

echo "Blade core System up now, Congratulation"