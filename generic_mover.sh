#!/bin/bash

#   Author: Aman Rajput
#   Created: 8/06/2021
#   
#   This program moves old files to the serial path.


#importing parameters
source generic_mover.param

#===============================================================================

curdate=`date '+%m%d%y_%H%M%S'`
vs=001

#===============================================================================

#checking if log directory exists otherwise create it

[ ! -d "../log" ] && mkdir -p ../log/
logdir=../log/
touch ${logdir}/generic_mover_${curdate}_${vs}.log

logfile=${logdir}/generic_mover_${curdate}_${vs}.log

#===============================================================================

#checking if error directory exists otherwise create it

[ ! -d "../error" ] && mkdir -p ../error/
errordir=../error/
touch ${errordir}/generic_mover_${curdate}_${vs}.err

errorfile=${errordir}/generic_mover_${curdate}_${vs}.err

#===============================================================================

#===============================================================================
age () { 

stat=$(stat --printf="%Y %F\n" "$1")
echo "'$1' was $((($(date +%s) - ${stat%% *})/86400)) days old."

}
#===============================================================================


filenames=( $(find $source -maxdepth 65535 -type f -mtime +${days}) )

#===============================================================================


#===============================================================================

# loop over it

for i in ${filenames[@]}
do   
    age $i >> $logfile 2>> $errorfile
    rm $i 2>> $errorfile
    
done



#=================================   END   =====================================
