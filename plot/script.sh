#!/bin/bash
rm values.txt
touch values.txt

IF=eth2
if [ -z "$IF" ]; then
        IF=`ls -1 /sys/class/net/ | head -1`
fi
RXPREV=-1
TXPREV=-1
echo "Listening $IF..."
while [ 1 == 1 ] ; do
        RX=`cat /sys/class/net/${IF}/statistics/rx_bytes`
        TX=`cat /sys/class/net/${IF}/statistics/tx_bytes`
        if [ $RXPREV -ne -1 ] ; then
                let BWRX=$RX-$RXPREV
                let BWTX=$TX-$TXPREV
                printf  "$BWRX " >>values.txt   

        fi
        RXPREV=$RX
        TXPREV=$TX
        sleep 1
done
