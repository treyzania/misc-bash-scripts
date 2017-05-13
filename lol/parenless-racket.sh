#!/bin/bash

EXEC=$(realpath $1)
DEST=/tmp/parenlessrkt/$(echo $EXEC | sed 's/\//./g')

mkdir -p $(dirname $DEST)

echo '#lang racket' >> $DEST
echo '(' >> $DEST
cat $EXEC | sed 1,1d >> $DEST
echo ')' >> $DEST

racket $DEST
rm $DEST

