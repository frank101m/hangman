#!/bin/bash

databasename="codigoabierto"
package1="postgresql"
package2="sox"

if [ $(dpkg-query -W -f='${Status}' postgresql 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "Installing pkg1..."
  sudo apt --yes --force-yes install $package1;
fi

if [ $(dpkg-query -W -f='${Status}' sox 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo "Installing pkg2..."
  sudo apt --yes --force-yes install $package2;
fi

if sudo -u postgres psql -lqt | cut -d \| -f 1 | grep -qw $databasename;
then
    echo "Database ready"
else
    echo "Installing Database"
	sudo -u postgres createdb codigoabierto
	sudo -u postgres psql codigoabierto < preconfig/codigoabierto.sql
fi
echo "All installed"
