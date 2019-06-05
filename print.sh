#!/bin/sh
HOSTNAME="gserver"
SERVERADDR="192.168.178.51"
DIRNAME="~/print"

#for each file in dir
for file in * 
do
    #Check if the current filename is not this script 
    if [ "$file" != "$0" ]
    then   
        #Move each file to the server then delete from this DIR     
        scp "$file" $HOSTNAME@$SERVERADDR:$DIRNAME
        #rm "$file"
    fi
done 

#Access to the server through SSH then print sent files
ssh -tt $HOSTNAME@$SERVERADDR << ENDREMOTESCRIPT
    cd print 
    for file in *
    do
        if [ "$file" != *".pdf" ]
        then
            unoconv "$file"
        fi
        lp *".pdf"
    done  
    rm *
    logout 
ENDREMOTESCRIPT

echo "DONE!"

