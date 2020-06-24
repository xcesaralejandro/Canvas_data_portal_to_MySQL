#VAR
CURRENT_PATH=$(pwd)
DEFAULT_FOLDER_PATH="$(echo "$CURRENT_PATH" | cut -c 3-${#CURRENT_PATH})/unpackedFiles"
DEFAULT_MYSQL_PATH="C:/xampp/mysql/bin/mysql"

read -p "Database Host (localhost):" DB_HOST
read -p "Database Name (canvas_data):" DB_NAME
read -p "Database User (root):" DB_USER
read -p "Database Password:" DB_PASSWORD
echo -e "\e[1;36mYou should use 60%-75% of your RAM, but in specific number, not decimals\e[0m"
echo -e "\e[1;36mif you use windows, yout route start with C:\e[0m"
read -p "MySQL Console Path ($DEFAULT_MYSQL_PATH):" MYSQL_PATH
echo -e "\e[1;36mif you use windows, your route start without C:\e[0m"
read -p "Path to uncompressed files ($DEFAULT_FOLDER_PATH):" FOLDER_PATH

if [ -z "$DB_HOST" ]
then
    DB_HOST='localhost'
fi

if [ -z "$DB_NAME" ]
then
    DB_NAME='canvas_data'
fi

if [ -z "$DB_USER" ]
then
    DB_USER='root'
fi

if [ -z "$DB_PASSWORD" ]
then
    DB_PASSWORD=''
else
    DB_PASSWORD = "-p${DB_PASSWORD}"
fi

if [ -z "$MYSQL_PATH" ]
then
    MYSQL_PATH=$DEFAULT_MYSQL_PATH
fi

if [ -z "$FOLDER_PATH" ]
then
    FOLDER_PATH=$DEFAULT_FOLDER_PATH
fi

echo -e "\n\n\e[1;32mTHE SCRIPT HAS BEEN RUN, GO BY COFFEE AND WAIT PATIENT\n\n"
now() {
    date +'%s'
}

echo -e "\n\n\e[1;36m------------------------------"
echo -e "\e[1;37m  MIGRATING RECORDS TO MySQL\e[1;36m"
echo -e "------------------------------\n\e[0m"
cd ./unpackedFiles
for file in *.txt
do
START=$(now)
table_name=$(echo "$file" | cut -f 1 -d '.')
echo -e "Migrating \e[1;33m${table_name}\e[0m..."
$MYSQL_PATH -h $DB_HOST -u $DB_USER $DB_PASSWORD $DB_NAME -e "
      set unique_checks = 0;
      set foreign_key_checks = 0;
      set sql_log_bin=0;
      load data infile '$DEFAULT_FOLDER_PATH/$table_name.txt' 
      ignore into table $table_name 
      fields terminated by '\t' 
      enclosed by '' 
      lines terminated by '\n' 
      ignore 1 lines;
"
END=$(now)
USED_TIME=$(expr $END - $START) 
echo -e "Migrated in\e[1;32m ${USED_TIME} Sec.\n\e[0m"
done

echo -e "\n\n\e[1;32mEVERYTHING IS READY, HAVE A NICE DAY =)"
