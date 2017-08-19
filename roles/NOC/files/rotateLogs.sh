#!/bin/bash


FORCE=0
if [ $# -eq 1 ]
then
  if [ $1 = "-f" ]
  then
    FORCE=1
  fi
fi

cd /var/log/ndn

if [ $FORCE -eq 0 ]
then
  # MAX_SIZE of about 10MB
  MAX_SIZE=10000000
  if [ -f nfd.log ]
  then
    SIZE=`wc -c nfd.log| awk ' { print $1 } '`
    if [ $SIZE -lt $MAX_SIZE ]
    then
      exit 0
    fi
  else
    exit 0
  fi
fi


# Keep the last 10 nfd logs
for i in $(seq 9 -1 1)
do
  j=$(($i+1))
  echo "sudo mv -f nfd.log.$i nfd.log.$j"
  sudo mv -f nfd.log.$i nfd.log.$j >& /dev/null
  echo "sudo mv -f nfd.log.$i.gz nfd.log.$j.gz"
  sudo mv -f nfd.log.$i.gz nfd.log.$j.gz >& /dev/null
done

# Now the tricky part. We want to make a copy of the current nfd.log
# and then very quickly truncate nfd.log. By doing this it will remain
# the same file and same inode but become empty.
# We might lose a small amount of log when we do this rotatation.

echo "sudo cp -p nfd.log nfd.log.1; sudo bash -c \"> nfd.log\""
sudo cp -p nfd.log nfd.log.1; sudo bash -c "> /var/log/ndn/nfd.log"
sudo gzip nfd.log.1

