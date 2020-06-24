echo -e "\n\n\e[1;32mTHE SCRIPT HAS BEEN RUN, GO BY COFFEE AND WAIT PATIENT\n\n"
now() {
    date +'%s'
}
echo -e "\n\n\e[1;36m--------------------"
echo -e "\e[1;37m  UNCOMPRESS FILES\e[1;36m"
echo -e "--------------------\n\e[0m"
for folders in dataFiles/*
do
START=$(now)
folder_name=$(echo "$folders" | cut -f 2 -d "/")
echo $folder_name
canvasDataCli unpack -c config.js -f $folder_name
END=$(now)
USED_TIME=$(expr $END - $START) 
echo -e "Used time to uncompress \e[1;33m${folder_name}\e[0m:\e[1;32m ${USED_TIME} Sec.\n\e[0m"
done
echo -e "\n\n\e[1;32mEVERYTHING IS READY, HAVE A NICE DAY =)"
