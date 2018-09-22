#!/bin/sh

# Get arguments
PROJECT_DIR=$1

# Run docker compose in background
docker-compose up -d

# Go into docker and exec project create in temp/ directory
PHP_PROCESS=_php_1
docker exec -t $PROJECT_DIR$PHP_PROCESS /bin/sh -c "mkdir temp && composer create-project symfony/skeleton temp/"

# Move temp/ dir files into main directory
sudo rm -rf var
sudo chown -R ${USER:=$(/usr/bin/id -run)}:$USER temp/
mv temp/* temp/.* . 2>/dev/null

# Remove not needed files and .git directory
rm .travis.yml docker-compose.travis.yml
rm -rf .git

# End script
echo 'Success! You can now remove install.sh file.'
exit 0
