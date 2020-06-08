#!/bin/bash
#set -x
##############################################################################################################################################
#  Description : Scripts to troubleshoot performance of the database.
#
#  SCRIPT NAME : PT_assist_v5.sh
#  Version : 5.0
#  Scripted By : Naved Afroz  email : naved56afroz@gmail.com
#  Phase : Beta Version
#  Other files used in the script : DB SQL scripts in DIR DB_PT_SCRIPTS
#
#  flags used : Explicit_Call
#
#
#
#
#  USAGE : sh PT_assist_v1.sh DEV12C
#  Date  : 21/05/2019
#
#  features  :
#                       v1.1 : original till 15 sql scripts
#                       v1.2 : sql_execution function
#                       v1.3 : Beautify and simplify and BUG fixes
#                       v1.4 : AWR
#                       v1.5 : Baseline
#                       v1.6 :
#                       v1.7 :
#                       v1.8 :
#                       v1.9 :
#                       v1.10 :
#                       v1.11 :
#                       v1.12 :
#                       v1.13 :
#
############################################################################################################################################


###################################  Program Start #########################################

############################### Logfile #################################
logfile_check ()
{
#Logfile used by Health-Check
logname=$PC_LOG_DIR/$dt/healthchecks_$1.log

if [ -f "$logname" ]
          then
            mv "$logname" "$PC_LOG_DIR"/"$dt"/healthchecks_"${1}"_"${ts}".log
fi
}
#############################################################################

send_mail ()
{
sub1=$(echo " ""$1"" Health-Check Log ($user) | ")
sub2=$(echo "$varhost" " | ")
sub=$(echo "$sub1" "$sub2" "$dt")
#MAIL_RECIPIENTS=naved56afroz@gmail
#CC_List=naved56afroz@gmail
mutt -s "$sub" -a $MAIL_RECIPIENTS -c $CC_List < $2
#mutt -s "$sub"  naved56afroz@gmail < "$2"
#mutt -s "$sub" -a $PC_LOG_DIR/$dt/*.htm  naved56afroz@gmail < "$2"
}

###################################  Health-CHECK ORACLE #########################################

MIM_check ()
{
echo -e "${bred} Logged in as $user and running the performance tunning assist script ${normal}"
############################### Variables #################################
logfile_check "$db_name"
###############################################################################################

echo -e "${yellow}Initiating Health checks on the database ${blue} $db_name@$varhost ${normal} "
#1.             Server and DB Uptime
{
        echo ""
        echo "---------------------------------------------------------------------------------------------------"
        echo " *** Uptime for Server $varhost ***"
        echo "---------------------------------------------------------------------------------------------------"
        echo ""
        uptime
        echo ""
} >> "$logname"

#               DB Status
echo -e "${yellow}Recording ${blue}status ${normal} for the database  ${blue} $db_name ...${normal} "
{
                echo "---------------------------------------------------------------------------------------------------"
                echo "*** db_status for $db_name Server $varhost ***"
                echo "---------------------------------------------------------------------------------------------------"
                echo ""
                sql_execution db_status
                echo ""
} >> "$logname"

#2.     Blocking and Locking sessions
echo -e "${yellow}Recording ${blue}blocking sessions ${normal} for the database  ${blue} $db_name ...${normal} "
{
                echo "---------------------------------------------------------------------------------------------------"
                echo "*** Blocking and Locking sessions for $db_name Server $varhost ***"
                echo "---------------------------------------------------------------------------------------------------"
                echo ""
                sql_execution blocking_sessions
                echo ""
} >> "$logname"

#3.     RMAN Backup completion status
echo -e "${yellow}Recording ${blue}backup status for past 1 week ${normal} for the database  ${blue} $db_name ...${normal} "
{
        echo "---------------------------------------------------------------------------------------------------"
        echo "*** RMAN Backup completion status for $db_name Server $varhost ***"
        echo "---------------------------------------------------------------------------------------------------"
        echo ""
        sql_execution rman_backup_status
        echo ""
} >> "$logname"

#4.     Archive log generation trend
echo -e "${yellow}Recording ${blue}archive generation trend for past 1 month ${normal} for the database  ${blue} $db_name ...${normal} "
{
        echo "---------------------------------------------------------------------------------------------------"
        echo "*** Archive log generation trend for $db_name Server $varhost ***"
        echo "---------------------------------------------------------------------------------------------------"
        echo ""
        sql_execution archive_gen_history
        echo ""
} >> "$logname"

#5.     Resource utilization (session and processes)
echo -e "${yellow}Recording ${blue} Max Resource settings ${normal} for the database  ${blue} $db_name ...${normal} "
{
        echo "---------------------------------------------------------------------------------------------------"
        echo "*** Resource utilization (session and processes) for $db_name Server $varhost ***"
        echo "---------------------------------------------------------------------------------------------------"
        echo ""
        sql_execution resource_util
        echo ""
} >> "$logname"

echo -e "${yellow}Recording ${blue}resource utilization for 2-3 Hrs ${normal} for the database  ${blue} $db_name ...${normal} "
{
        echo "---------------------------------------------------------------------------------------------------"
        echo "*** Past 2-3 Hrs Resource utilization (session and processes) for $db_name Server $varhost ***"
        echo "---------------------------------------------------------------------------------------------------"
        echo ""
        sql_execution resource_util_hist
        echo ""
} >> "$logname"

#6.     Database Growth trend
echo -e "${yellow}Recording ${blue}DB Growth trend ${normal} for the database  ${blue} $db_name ...${normal} "
{
        echo "---------------------------------------------------------------------------------------------------"
        echo "*** Database Growth trend for $db_name Server $varhost ***"
        echo "---------------------------------------------------------------------------------------------------"
        echo ""
        sql_execution database_growth_trend
        echo ""
} >> "$logname"

#7.     DDL Changes happened in the last 3 days
echo -e "${yellow}Recording ${blue}any DDL Changes in past 3 days ${normal} for the database  ${blue} $db_name ...${normal} "
{
        echo "---------------------------------------------------------------------------------------------------"
        echo "*** DDL Changes happened in the last 3 days for $db_name Server $varhost ***"
        echo "---------------------------------------------------------------------------------------------------"
        echo ""
        sql_execution ddl_change_hist
        echo ""
} >> "$logname"

#8.     Stale statistics
echo -e "${yellow}Recording ${blue}objects with stale stats ${normal} for the database  ${blue} $db_name ...${normal} "
{
        echo "---------------------------------------------------------------------------------------------------"
        echo "*** Stale statistics for $db_name Server $varhost ***"
        echo "---------------------------------------------------------------------------------------------------"
        echo ""
        sql_execution stale_stats
        echo ""
} >> "$logname"

#9.     INVALID Objects
echo -e "${yellow}Recording ${blue}invalid objects ${normal} for the database  ${blue} $db_name ...${normal} "
{
        echo "---------------------------------------------------------------------------------------------------"
        echo "*** INVALID Objects for $db_name Server $varhost ***"
        echo "---------------------------------------------------------------------------------------------------"
        echo ""
        sql_execution invalid_objects
        echo ""
} >> "$logname"

#10.    UNUSABLE INDEXES
echo -e "${yellow}Recording ${blue}unusable indexes ${normal} for the database  ${blue} $db_name ...${normal} "
{
        echo "---------------------------------------------------------------------------------------------------"
        echo "*** UNUSABLE INDEXES for $db_name Server $varhost ***"
        echo "---------------------------------------------------------------------------------------------------"
        echo ""
        sql_execution unusable_indexes
        echo ""
} >> "$logname"

#11.    CPU Utilization
echo -e "${yellow}Recording ${blue}CPU Utilization ${normal} for the database  ${blue} $db_name ...${normal} "
{
        echo "---------------------------------------------------------------------------------------------------"
        echo "*** CPU Utilization for $db_name Server $varhost ***"
        echo "---------------------------------------------------------------------------------------------------"
        echo ""
        sql_execution cpu_utilization
        echo ""
} >> "$logname"

echo -e "${yellow}Recording ${blue}Instances ${normal}running on the server ${blue} $varhost ...${normal} "
{
        echo "---------------------------------------------------------------------------------------------------"
        echo "*** Instances on Server $varhost ***"
        echo "---------------------------------------------------------------------------------------------------"
        ps -ef|grep  pmon |grep -v grep
} >> "$logname"


echo -e "${yellow}Recording ${blue}listener ${normal}running on the server ${blue} $varhost ...${normal} "
v_listener=$(ps -ef|grep  tns|grep -v grep|grep GRID|awk '{print $9}')

{
        echo "---------------------------------------------------------------------------------------------------"
        echo "*** Listeners Running on Server ***"
        echo "---------------------------------------------------------------------------------------------------"
        ps -ef|grep  tns |grep -v grep
        echo "---------------------------------------------------------------------------------------------------"
        echo "*** Local Listener Services Registration ***"
        echo "---------------------------------------------------------------------------------------------------"
        lsnrctl services listener
        echo "---------------------------------------------------------------------------------------------------"
        echo "*** $v_listener Services Registration ***"
        echo "---------------------------------------------------------------------------------------------------"
    lsnrctl services "$v_listener"
} >> "$logname"

echo -e "${yellow}Recording ${blue}Mountpoints ${normal} on the server ${blue} $varhost ...${normal} "
{
        echo "---------------------------------------------------------------------------------------------------"
        echo "*** Mountpoints on Server ***"
        echo "---------------------------------------------------------------------------------------------------"
        df -h
} >> "$logname"


echo -e "${yellow}Sending Mail ${normal} "

send_mail DB "$logname"

echo ""
echo ""
echo -e "${bnb}MIM Health-Check Done. Please check logfile ${yellow}$logname ${normal} "
echo ""
echo ""

        sleep 3
        clear
        show_menu
}

OS_check ()
{
echo -e "${bred} Logged in as $user and running the OS Health-Check assist script ${normal}"
############################### Variables #################################
logfile_check "$varhost"
###############################################################################################
echo -e "${yellow}Initiating Health checks on the server ${blue} $varhost ${normal} "

#1. CPU Architecture information includes, for example, the number of CPUs, threads, cores, sockets, and Non-Uniform Memory Access (NUMA) nodes.
{
echo "---------------------------------------------------------------------------------------------------"
echo "*** CPU Architecture information Server $varhost ***"
echo "---------------------------------------------------------------------------------------------------"
echo ""
lscpu
echo ""

#2.TOP CPU consumers

echo "---------------------------------------------------------------------------------------------------"
echo "*** TOP CPU Consumers for  Server $varhost ***"
echo "---------------------------------------------------------------------------------------------------"
echo ""
top -n 1 -b |head -40
echo ""

#3. Utilization of each CPU

echo "---------------------------------------------------------------------------------------------------"
echo "*** Utilization of each CPU for  Server $varhost ***"
echo "---------------------------------------------------------------------------------------------------"
echo ""
mpstat -P ALL
echo ""
} >> "$logname"

#4. Comparison of CPU utilization; 2 seconds apart; 5 times
echo -e "${yellow}Recording ${blue}CPU utilization ${normal};2 seconds apart; 5 times on the server ${blue} $varhost ...${normal} "
{
echo "---------------------------------------------------------------------------------------------------"
echo "*** Comparison of CPU utilization; 2 seconds apart; 5 times for  Server $varhost ***"
echo "---------------------------------------------------------------------------------------------------"
echo ""
sar -u 2 5
echo ""

#5. Top 10 CPU Consumers

echo "---------------------------------------------------------------------------------------------------"
echo "*** Top 10 CPU Consumers for  Server $varhost ***"
echo "---------------------------------------------------------------------------------------------------"
echo ""
ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10
echo ""
} >> "$logname"

#6. I/O Statistics Three outputs every 5 seconds since the last reboot
echo -e "${yellow}Recording ${blue}I/O Statistics ${normal} ;3 outputs; every 5 seconds since the last reboot on the server ${blue} $varhost ...${normal} "
{
echo "---------------------------------------------------------------------------------------------------"
echo "*** I/O Stats ;3 outputs; every 5 seconds since the last reboot for  Server $varhost ***"
echo "---------------------------------------------------------------------------------------------------"
echo ""
iostat -xtc 5 3
echo ""
} >> "$logname"

#7.  Information about processes, memory, paging, block IO, disk and CPU scheduling
echo -e "${yellow}Recording ${blue}Virtual memory statistics ${normal};interval of 1 sec; 10 times on the server ${blue} $varhost ...${normal} "
{
echo "--------------------------------------------------------------------------------------------------"
echo "*** Virtual memory statistic report for  Server $varhost with an interval of 1 sec 10 times:***"
echo "--------------------------------------------------------------------------------------------------"
echo ""
vmstat 1 13
echo ""

#8.  Information about RAM

echo "--------------------------------------------------------------------------------------------------"
echo "*** RAM details for  Server $varhost ***"
echo "--------------------------------------------------------------------------------------------------"
echo ""
free -g
echo ""

#9.  Information about first 10 processes using most memory

echo "--------------------------------------------------------------------------------------------------"
echo "*** Top memory consumers for  Server $varhost ***"
echo "--------------------------------------------------------------------------------------------------"
echo ""
ps aux | sort -nrk 4 | head
echo ""

#10.  File System utilization

echo "--------------------------------------------------------------------------------------------------"
echo "*** File system utilization report for Server $varhost ***"
echo "--------------------------------------------------------------------------------------------------"
echo ""
df -h
echo ""
} >> "$logname"

echo -e "${yellow}Sending Mail ${normal} "

send_mail OS "$logname"

echo ""
echo ""
echo -e "${bnb}OS Health-Check Done. Please check logfile ${yellow}$logname ${normal} "
echo ""
echo ""

        sleep 3
        clear
        show_menu
}

count_check ()
{
export ORACLE_SID=$db_name
export ORAENV_ASK="NO"
#/home/$user/bin/racenv $DBNAME
. oraenv
count=`sqlplus -S "/ as sysdba" <<EOF
SET VERIFY OFF HEAD OFF PAGES 0
@$SCRIPTS_DIR/$1 $2;
EXIT;
EOF`
count=`echo $count | sed 's/ *$//g'`
}


baseline ()
{
  #Generate STS from AWR or SQL AREA (get user input)
  unset opt
  echo -e "${blue}Enter a choice to Create SQL Baseline FROM : ${normal}"
  echo -e "${blue}option -> 1 for AWR   : ${normal}"
  echo -e "${blue}option -> 2 for SQL AREA   : ${normal}"
  read -r opt
  if [ $opt = "" ]; then
           exit;
                     elif [ "$opt" == 1 ]; then
                           option_picked "Option 1 Picked  --> Create SQL Baseline FROM AWR ";
                           echo ""
                           option_picked " LOCATE AWR SNAPSHOT REQUIRED TO POPULATE THE ‘SQL TUNING SET’ ";
                           sql_execution search_hist_sql "$2"
                           #get user input for bid and eid
                           echo -e "${blue}Enter BEGIN_SNAP  : ${normal}"
                           read -r bid
                           echo -e "${blue}Enter END_SNAP  : ${normal}"
                           read  -r eid
                           #get user input for good PHV
                           echo -e "${blue}Enter Good PHV  : ${normal}"
                           read  -r phv
					elif [ "$opt" == 2 ]; then
                           option_picked "Option 1 Picked  --> Create SQL Baseline FROM SQL AREA ";
                           echo ""
						   echo ""
                           option_picked " LOCATE SQL in cursor TO fetch PHV ";
						   sql_execution plan_hash_value "$2"
						   #get user input for good PHV
                           echo -e "${blue}Enter Good PHV  : ${normal}"
                           read  -r phv
					else
                       exit ;unset opt
     #unset opt
    fi

   sleep 3
  option_picked "Check if baseline already exists for given sql " ;
  count_check verify_sql_plan_baseline "$2"
          if [ "$count" -eq 1 ]
                              then
							    echo ""
                                echo -e "${blue}sql plan baseline already exists Do you want to to drop  : [y/Y] ${normal}"
                                read -r pause
                                if [ "$pause" == "y" ] ||  [ "$pause" == "Y" ]
                                              then
                                                count_check sql_plan_name "$2"
												plan_name=$count
												option_picked " Dropping SQL Plan Baseline for SQLID $2 "
												sql_execution drop_plan_baseline "$plan_name"
												 sleep 3
												count_check verify_sql_plan_baseline "$2"
												if [ "$count" -eq 1 ]
                                                       then
													     echo ""
                                                         echo -e "${blue} sql plan baseline dropped for SQLID $2 ${normal}"
                                                      fi
							    else  
								echo ""
								echo -e "${blue}sql plan baseline will be replaced ${normal}"
                                fi
            elif [ "$count" -eq 0 ]
                              then
							  echo "" 
                                echo -e "${blue}SQL Plan Baseline does not exist ; proceed to create one ${normal}"

            elif [ -z "$count" ]
                               then
							   echo ""
                                echo -e "${blue}Something went wrong ; Kindly login and check manually ${normal}"


            fi

 #Create SQL Baseline for SQL_ID for plan stabilization
 #2) CREATE ‘SQL TUNING SET’ (STS) from AWR or SQL AREA
    echo ""
    option_picked " Creating SQL Tuning SET for SQLID $2 "
	echo ""
  sql_execution create_sts STS_"$ts"_"$2"
   sleep 3

 #3) VERIFY SQL MONITORING IS ENABLED FOR SQL STATEMENTS
 echo ""
 option_picked " VERIFY SQL MONITORING IS ENABLED FOR SQL STATEMENTS "
 sql_execution verify_sql_monitor "$2"
  sleep 3

 #5) POPULATE ‘SQL TUNING SET’
   #A) FROM AWR
   if [[ "$opt" == 1 ]]; then
   echo ""
    option_picked " Populate SQL Tuning SET for SQLID $2 from AWR "
	echo ""
   sql_execution  populate_sts_awr "$bid" "$eid" "$2" STS_"$ts"_"$2"
    sleep 3
 elif [[ "$opt" == 2 ]]; then
   #B) FROM SHARED SQL AREA
   echo ""
   option_picked " Populate SQL Tuning SET for SQLID $2 from SQL Area "
   echo ""
   sql_execution populate_sts_sqlarea "$2" STS_"$ts"_"$2"
    sleep 3
   else
     exit 0;
   fi
echo ""
#option_picked " LIST OUT SQL TUNING SET TO VERIFY CONTENT "
#echo ""
 #sql_execution verify_sts_content STS_"$ts"_"$2"
#echo ""
 #7) LOAD DESIRED PLAN FROM ‘SQL TUNING SET’ AS SQL PLAN BASELINE
 echo ""
 option_picked " Loading SQL Tuning SET for SQLID $2 "
 echo ""
 sql_execution load_plan_sts STS_"$ts"_"$2" "$phv"
  sleep 3

 #8) VERIFY IF SQL PLAN BASELINE GOT CREATED SUCCESSFULLY
 count_check sql_handle_name "$2"
 sql_handle=$count
 echo ""
  option_picked " VERIFY IF SQL PLAN BASELINE GOT CREATED SUCCESSFULLY for SQLID $2 "
  echo ""
 sql_execution sql_plan_baselines $sql_handle
  sleep 3

 #9) Check if SQL exist in SQLAREA
 echo ""
 option_picked " Do you want to to flush the SQLID $2 from memory : [y/Y] "
 echo ""
 read -r pause
 if [ "$pause" == "y" ] ||  [ "$pause" == "Y" ]
               then
                 count_check verify_sql_memory "$2"
				        if [ "$count" -eq 1 ]
                             then
							 echo ""
							  option_picked  " Purging SQL Plan for SQLID $2 from cache "
							  echo ""
                               sql_execution purge_sql_plan "$2"
							    sleep 3
                        elif [ "$count" -eq 0 ]
                             then
							   echo ""
                               echo -e "${blue}SQLID does not exist in cache ${normal}"

                        elif [ -z "$count" ]
                              then
                               echo -e "${blue}Something went wrong ; Kindly login and check manually ${normal}"
                        fi
 fi

 #10) Check plan Evolution  DBMS_SPM.EVOLVE_SQL_PLAN_BASELINE
# echo ""
# option_picked " Check SQL Plan Baseline Evolve for SQLID $2 from cache "
# echo ""
# count_check sql_handle_name "$2"
# sql_handle=$count
# sql_execution evolve_sts "$sql_handle"

 #11) Fix a plan baseline

 echo -e "${blue}Do you want to to fix the SQLID $2 plan baseline : [y/Y] ${normal}"
 read -r pause
 if [ "$pause" == "y" ] ||  [ "$pause" == "Y" ]
               then
                 count_check sql_plan_name "$2"
				 plan_name=$count
                 count_check sql_handle_name "$2"
				 sql_handle=$count
				  echo ""
				  option_picked " Hardening SQL Plan Baseline ; FIX => YES for SQLID $2 from cache "
				  echo ""
                 sql_execution fix_sts "$sql_handle" "$plan_name"
				  sleep 3
                 count_check check_plan_is_fixed "$plan_name"
                    if [ "$count" -ge 1 ]
                      then
					   echo ""
                       echo -e "${blue}SQLID $2 plan baseline has been fixed ${normal}"
                       sleep 5;show_menu
                     else
					   echo ""
                       echo -e "${blue}SQLID $2 plan could not be fixed check manually ${normal}"
                       sleep 5
                       clear;show_menu
                    fi
               else
                 clear;show_menu
  fi
}

coe_profile_create ()
{

export ORACLE_SID=$db_name
export ORAENV_ASK="NO"
#/home/$user/bin/racenv $DBNAME
. oraenv
sqlplus -S "/ as sysdba" <<EOF
set timing on
@$PC_LOG_DIR/$dt/$1 $2
EOF

}

sql_execution ()
{
export ORACLE_SID=$db_name
export ORAENV_ASK="NO"
#/home/$user/bin/racenv $DBNAME
. oraenv
sqlplus -S "/ as sysdba" <<EOF
set timing on
spool $PC_LOG_DIR/$dt/$1_$db_name.txt
@$SCRIPTS_DIR/$1 $2 $3 $4 $5
Spool off
EOF

 if [ "$Explicit_Call" -eq 1 ]
                         then
                               read -r pause
                               if [ "$1" == "coe_xfr_sql_profile" ]
                                   then unset input;clear;show_menu
                               elif [ "$pause" == "/" ] && [ -n "$input" ]
                                   then
                                     echo -e "${blue}Enter value again : ${normal}"
                                     read -r input
                                    sql_execution "$1" "$input"
                               elif [ "$pause" == "/" ] && [ -z "$input" ]
                                     then
                                    sql_execution "$1"
                               else
                                     unset input;clear;show_menu
                               fi

elif [ "$Explicit_Call" -eq 2 ]
                          then
                              echo -e "${blue}Do you want to create a custom SQL Profile for "$2" with above plan "$3" : [y/n] ${normal}"
                              read -r pause
                              if [ "$pause" == "y" ] ||  [ "$pause" == "Y" ]
                                   then
                                     count_check sql_profile_check "$SQLID"_"$PHV"
                                             if [ "$count" -eq 0 ]
                                                 then
                                                   coe_profile_create coe_xfr_sql_profile_"$SQLID"_"$PHV".sql
                                                   sleep 5
                                                   unset input;show_menu
                                               elif [ "$count" -eq 1 ]
                                                 then
                                                   echo -e "${blue}Manual custom SQL Profile already exist for "$2" with above plan "$3" ${normal}"
                                                   exit 0
                                               elif [ -z "$count" ]
                                                  then
                                                   echo -e "${blue}Something went wrong ; Kindly login and check manually ${normal}"
                                                   exit 0
                                               fi
                                   else
                                unset input;clear;show_menu
                              fi
 elif [ "$Explicit_Call" -eq 3 ]
                               then
                               mailx -s "AWR for $db_name "`printf " -a %s" "$PC_LOG_DIR"/"$dt""$ts"/awr*htm` naved56afroz@gmail < /dev/null
                               echo -e "${blue}Kindly check your mail for AWR reports for past couple of hours  ${normal}"
                               sleep 5
                               unset input;clear;show_menu
fi
}



################################## MENU Function ######################################################
show_menu()
{
    NORMAL=$(echo "\033[m")
    MENU=$(echo "\033[36m") #Blue
    NUMBER=$(echo "\033[33m") #yellow
    FGRED=$(echo "\033[41m")
    RED_TEXT=$(echo "\033[31m")
    ENTER_LINE=$(echo "\033[33m")

        #user=`ps -ef|grep  pmon|grep -v +ASM|awk '{print $1}'|head -1`
        user=$(ps -ef|grep  pmon_|grep -v grep|grep -v +ASM |awk '{print $1}'|head -1)

 echo -e "${MENU}                                                                                          ${bgred}[PTT]${NORMAL}                        ${NORMAL}"
 echo -e "${MENU}                                                                           ${bgred}PERFORMANCE TROUBLESHOOTING TOOL${NORMAL}                   ${NORMAL}"
 echo ""
 echo -e "${MENU}****************************************************************************************** MENU ************************************************************************************************${NORMAL}"
 echo -e "${MENU}**${NUMBER} 1)${MENU} MIM HealthCheck         ${NORMAL}${NUMBER}11)${MENU} Datafile Utilization      ${NORMAL}${NUMBER}21)${bred} Check user sessions      ${NORMAL}${NUMBER}31)${bred} Top 5 SQL                ${NORMAL}${NUMBER}41)${MENU} Transaction Recovery   ${NORMAL}${NUMBER}51)${MENU} AWR for past 3-4 snaps   ${NORMAL}"
 echo -e "${MENU}**${NUMBER} 2)${MENU} OS HealthCheck          ${NORMAL}${NUMBER}12)${MENU} CPU Utilization           ${NORMAL}${NUMBER}22)${bred} Blocking locks           ${NORMAL}${NUMBER}32)${bred} Search query in SQLAREA  ${NORMAL}${NUMBER}42)${MENU} DDL Changes            ${NORMAL}${NUMBER}52)${MENU} Memory Advisory          ${NORMAL}"
 echo -e "${MENU}**${NUMBER} 3)${MENU} Database Size           ${NORMAL}${NUMBER}13)${MENU} Resource utilization      ${NORMAL}${NUMBER}23)${bred} Analyze Lock             ${NORMAL}${NUMBER}33)${bred} Execution Plan           ${NORMAL}${NUMBER}43)${MENU} INVALID Objects        ${NORMAL}${NUMBER}53)${MENU} Table Reorganize Advisory${NORMAL}"
 echo -e "${MENU}**${NUMBER} 4)${MENU} Database Status         ${NORMAL}${NUMBER}14)${MENU} Resource utilization Hist ${NORMAL}${NUMBER}24)${bred} Long running session     ${NORMAL}${NUMBER}34)${bred} Search Cache SQL         ${NORMAL}${NUMBER}44)${MENU} UNUSABLE INDEXES       ${NORMAL}${NUMBER}54)${MENU} TBD                      ${NORMAL}"
 echo -e "${MENU}**${NUMBER} 5)${MENU} RMAN Backup Status      ${NORMAL}${NUMBER}15)${MENU} FRA Usage                 ${NORMAL}${NUMBER}25)${bred} Stale statistics         ${NORMAL}${NUMBER}35)${bred} Search Hist SQL          ${NORMAL}${NUMBER}45)${MENU} Foreign Reference Keys ${NORMAL}${NUMBER}55)${MENU} TBD                      ${NORMAL}"
 echo -e "${MENU}**${NUMBER} 6)${MENU} Archive Generation Hist ${NORMAL}${NUMBER}16)${MENU} SGA Usage                 ${NORMAL}${NUMBER}26)${bred} Table Last analyzed      ${NORMAL}${NUMBER}36)${bred} SQL Plan Change          ${NORMAL}${NUMBER}46)${MENU} Dependent Objects View ${NORMAL}${NUMBER}56)${MENU} TBD                      ${NORMAL}"
 echo -e "${MENU}**${NUMBER} 7)${MENU} Database Growth Trend   ${NORMAL}${NUMBER}17)${MENU} Table space Usage         ${NORMAL}${NUMBER}27)${bred} Table Last Modified      ${NORMAL}${NUMBER}37)${bred} List SQL Profiles        ${NORMAL}${NUMBER}47)${MENU} Dependent Objects      ${NORMAL}${NUMBER}57)${MENU} TBD                      ${NORMAL}"
 echo -e "${MENU}**${NUMBER} 8)${MENU} Restore Points          ${NORMAL}${NUMBER}18)${MENU} Temp space Usage          ${NORMAL}${NUMBER}28)${bred} Analyze Top Wait Events  ${NORMAL}${NUMBER}38)${bred} COE Profile              ${NORMAL}${NUMBER}48)${MENU} Package Source Code    ${NORMAL}${NUMBER}58)${MENU} TBD                      ${NORMAL}"
 echo -e "${MENU}**${NUMBER} 9)${MENU} Parameter Value         ${NORMAL}${NUMBER}19)${MENU} Undo Usage                ${NORMAL}${NUMBER}29)${bred} System Waits             ${NORMAL}${NUMBER}39)${bred} Create SQL Baseline (SPB)${NORMAL}${NUMBER}49)${MENU} Parallel Slaves        ${NORMAL}${NUMBER}59)${MENU} TBD                      ${NORMAL}"
 echo -e "${MENU}**${NUMBER} 10)${MENU}Estimate Flashback Size ${NORMAL}${NUMBER}20)${MENU} Table Size                ${NORMAL}${NUMBER}30)${bred} Session Waits            ${NORMAL}${NUMBER}40)${bred} List Baselines (SPB)     ${NORMAL}${NUMBER}50)${MENU} Scheduler Jobs         ${NORMAL}${NUMBER}60)${MENU} TBD                      ${NORMAL}"
 echo -e "${MENU}**${NUMBER} 0)${MENU} EXIT ${NORMAL}"                                                                                             
 echo -e "${MENU}************************************************************************************************************************************************************************************************${NORMAL}"
 echo -e "${ENTER_LINE}Please enter a menu option and enter OR  ${RED_TEXT} just Press enter to exit. ${NORMAL}"
read -r opt
        options
}

function option_picked() {
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE=${*:-"${RESET}Error: No message passed"}
    echo -e "${COLOR}${MESSAGE}${RESET}"
}


################################## Menu Options ######################################################
options ()
        {
                #user=`ps -ef|grep  pmon|grep -v +ASM|awk '{print $1}'|head -1`
                user=$(ps -ef|grep  pmon_|grep -v grep|grep -v +ASM |awk '{print $1}'|head -1)

                if [[ $opt = "" ]]; then
                         exit;
                else
                        case $opt in

                                								1) clear;
                                        option_picked "Option 1 Picked  --> MIM Health-CHECK  ";
                                        echo ""
                                        Explicit_Call=0
                                        MIM_check "$db_name"
                                        ;;

                                2) clear;
                                        option_picked "Option 2 Picked  --> OS Health-CHECK ";
                                        echo ""
                                        Explicit_Call=0
                                        OS_check
                                        ;;

                                3) clear;
                                        option_picked "Option 3 Picked  --> Database Size ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution database_size
                                        ;;
										
                                4) clear;
                                        option_picked "Option 4 Picked  --> Database Status ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution db_status
                                        ;;

     							5) clear;
                                        option_picked "Option 5 Picked  --> RMAN Backup Status ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution rman_backup_status
                                        ;;

                                6) clear;
                                        option_picked "Option 6 Picked  --> Archive Generation History ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution archive_gen_history
                                        ;;
								
								7) clear;
                                        option_picked "Option 7 Picked  --> Database Growth trend ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution database_growth_trend
                                        ;;
                                
								8) clear;
                                        option_picked "Option 8 Picked  --> Restore Points ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution restore_points
                                        ;;
                                
								9) clear;
                                        option_picked "Option 9 Picked  --> Parameter Value ";
                                        echo ""
                                        Explicit_Call=1
                                        echo -e "${blue}Enter Parameter Name to find Value  : ${normal}"
                                        read -r input
                                        sql_execution hidden_parameter_value "$input"
                                        ;; 

                                10) clear;
                                        option_picked "Option 10 Picked  --> Estimate Flashback Size ";
                                        echo ""
                                        Explicit_Call=1
										echo -e "${blue}Enter number of days to estimate flashback size  : ${normal}"
                                        read -r input
                                        sql_execution estimate_flashback_size "$input"
                                        ;;
										
								11) clear;
                                        option_picked "Option 11 Picked  --> Datafile Utilization ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution datafile_utilization
                                        ;;
								
								12) clear;
                                        option_picked "Option 12 Picked  --> CPU Utilization ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution cpu_utilization
                                        ;;
										
								13) clear;
                                        option_picked "Option 13 Picked  --> Resource utilization (session and processes) ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution resource_util
                                        ;;

                                14) clear;
                                        option_picked "Option 14 Picked  --> Resource utilization History  (session and processes)";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution resource_util_hist
                                        ;;
										 
								15) clear;
                                        option_picked "Option 15 Picked  --> FRA Usage ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution fra_usage
                                        ;;

                                16) clear;
                                        option_picked "Option 16 Picked  --> SGA Usage ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution sga_usage
                                        ;;

                                17) clear;
                                        option_picked "Option 17 Picked  --> Table space Usage ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution tablespace_usage
                                        ;;

                                18) clear;
                                        option_picked "Option 18 Picked  --> Temp Table space Usage ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution temp_ts_usage
                                        ;;

                                19) clear;
                                        option_picked "Option 19 Picked  --> Undo Usage ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution undo_usage
                                        ;;
								
								20) clear;
                                        option_picked "Option 20 Picked  --> Table Size ";
                                        echo ""
                                        Explicit_Call=1
                                        echo -e "${blue}Enter Table Name : ${normal}"
                                        read -r input
                                        sql_execution table_size "$input"
                                        ;;
								
								21) clear;
                                        option_picked "Option 21 Picked  --> Check user sessions ";
                                        echo ""
                                        Explicit_Call=1
                                        #unset input
                                        sql_execution sess
                                        ;;

                                22) clear;
                                        option_picked "Option 22 Picked  --> Blocking locks ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution blocking_sessions
                                        ;;
										
								23) clear;
                                        option_picked "Option 23 Picked  --> Analyze Lock ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution analyze_lock
                                        ;;
										
								24) clear;
                                        option_picked "Option 24 Picked  --> Long running session ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution longops
                                        ;;
								
								25) clear;
                                        option_picked "Option 25 Picked  --> Stale statistics ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution stale_stats
                                        ;;

                                26) clear;
                                        option_picked "Option 26 Picked  --> Table Last analyzed  ";
                                        echo ""
                                        Explicit_Call=1
                                        echo -e "${blue}Enter Table Name to find last analyzed  : ${normal}"
                                        read -r input
                                        sql_execution table_last_analyzed "$input"
                                        ;;

								27) clear;
                                        option_picked "Option 27 Picked  --> Table modified in last 15 days ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution table_last_modified
                                        ;;
                                

                                28) clear;
                                        option_picked "Option 28 Picked  --> Analyze Top wait events ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution wait_events
                                        ;;
										
								29) clear;
                                        option_picked "Option 29 Picked  --> System Waits ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution system_waits
                                        ;;

                                30) clear;
                                        option_picked "Option 30 Picked  --> Session Waits ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution session_waits
                                        ;;	
								
								31) clear;
                                        option_picked "Option 31 Picked  --> Top 5 SQL  ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution top_5_sql
                                        ;;

                                32) clear;
                                          option_picked "Option 32 Picked  --> Find SQL query in SQL Area ";
                                          echo ""
                                          Explicit_Call=1
                                          sql_execution sql_script_sqlarea
                                          ;;
										
                                33) clear;
                                        option_picked "Option 33 Picked  --> Execution Plan ";
                                        echo ""
                                        Explicit_Call=1
                                        echo -e "${blue}Enter SQLID to display execution plan : ${normal}"
                                        read -r input
                                        sql_execution execution_plan "$input"
                                        ;;  
										
								34) clear;
                                        option_picked "Option 34 Picked  --> Search Cache SQL ";
                                        echo ""
                                        Explicit_Call=1
                                        echo -e "${blue}Enter SQLID to Search in Cache : ${normal}"
                                        read -r input
                                        sql_execution search_cache_sql "$input"
                                        ;;

                                35) clear;
                                        option_picked "Option 35 Picked  --> Search Hist SQL ";
                                        echo ""
                                        Explicit_Call=1
                                        echo -e "${blue}Enter SQLID to Search in AWR : ${normal}"
                                        read -r input
                                        sql_execution search_hist_sql "$input"
                                        ;;

                                36) clear;
                                        option_picked "Option 36 Picked  --> SQL Plan Change ";
                                        echo ""
                                        Explicit_Call=1
                                        echo -e "${blue}Enter SQLID to Search change in execution plan : ${normal}"
                                        read -r input
                                        sql_execution sql_plan_change "$input"
                                        ;;
	  
								37) clear;
                                        option_picked "Option 37 Picked  --> SQL Profiles ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution sql_profiles
                                        ;;
										  
								38) clear;
                                        option_picked "Option 38 Picked  --> COE Profile ";
                                        echo ""
                                        Explicit_Call=2
                                        echo -e "${blue}Enter SQLID to create a custom SQL Profile : ${normal}"
                                        read -r SQLID
                                        echo -e "${blue}Enter PHV to pin the execution plan : ${normal}"
                                        read -r PHV
                                        sql_execution coe_xfr_sql_profile "$SQLID" "$PHV" #Force enable => TRUE
                                        ;;
							    
								39) clear;
                                          option_picked "Option 39 Picked  --> Create SQL Baseline for SQL_ID for plan stabilization ";
                                          echo ""
                                          Explicit_Call=3
                                          echo -e "${blue}Enter SQL_ID for plan stabilization  : ${normal}"
                                          read -r input
                                          baseline "$db_name" "$input"
                                          ;;
										  
							    40) clear;
                                        option_picked "Option 40 Picked  --> List Sql plan baselines ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution sql_plan_baseline
                                        ;;
								
								41) clear;
                                        option_picked "Option 41 Picked  --> Transaction Recovery ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution transaction_recovery
                                        ;;
										
                                42) clear;
                                        option_picked "Option 42 Picked  --> DDL Changes happened in the last 2-3 days ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution ddl_change_hist
                                        ;;
								
								43) clear;
                                        option_picked "Option 43 Picked  --> INVALID Objects  ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution invalid_objects
                                        ;;

                                44) clear;
                                        option_picked "Option 44 Picked  --> UNUSABLE INDEXES ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution unusable_indexes
                                        ;;
										
								45) clear;
                                        option_picked "Option 45 Picked  --> Foreign Reference Keys ";
                                        echo ""
                                        Explicit_Call=1
                                        echo -e "${blue}Enter Table Name to Search Foreign Reference Keys : ${normal}"
                                        read -r input
                                        sql_execution foreign_refrence_keys "$input"
                                        ;;
										
								46) clear;
                                        option_picked "Option 46 Picked  --> Dependent Objects View ";
                                        echo ""
                                        Explicit_Call=1
                                        echo -e "${blue}Enter parent object to Search Dependent Objects View : ${normal}"
                                        read -r input
                                        sql_execution dependent_objects_view "$input"
                                        ;;

                                47) clear;
                                        option_picked "Option 47 Picked  --> Dependent Objects ";
                                        echo ""
                                        Explicit_Call=1
                                        echo -e "${blue}Enter parent object to Search Dependent Objects  : ${normal}"
                                        read -r input
                                        sql_execution dependent_objects "$input"
                                        ;;

								48) clear;
                                        option_picked "Option 48 Picked  --> Package Source Code ";
                                        echo ""
                                        Explicit_Call=1
                                        echo -e "${blue}Enter Package Name to display Source Code  : ${normal}"
                                        read -r input
                                        sql_execution package_name "$input"
                                        ;;

								49) clear;
                                        option_picked "Option 49 Picked  --> Parallel Slaves ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution parallel_slaves
                                        ;;
										
										
                                50) clear;
                                        option_picked "Option 50 Picked  --> Scheduler Jobs ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution scheduler_jobs
                                        ;;
										  
								51) clear;
                                        option_picked "Option 51 Picked  --> AWR for Past couple of Hours  ";
                                        echo ""
                                        Explicit_Call=3
										mkdir -p "$PC_LOG_DIR"/"$dt""$ts"
										echo ""
										echo -e "\033[33;5;7mGenerating AWR report .. . .  . \033[0m"
										echo ""
                                        sql_execution awr $user $dt$ts
                                        ;;
								
								52) clear;
                                        option_picked "Option 52 Picked  --> Memory Advisory ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution memory_advisory
                                        ;;
							    
								53) clear;
                                        option_picked "Option 52 Picked  --> Table Reorganize Advisory ";
                                        echo ""
                                        Explicit_Call=1
                                        sql_execution table_reorg_advisory
                                        ;;

                                0) exit ;;

                                '\n') exit;
                                        ;;

                                *) clear;
                                        option_picked "Pick an option from the menu";
                                        show_menu;
                                        ;;
                        esac
                fi
}

directory_exists ()
{
         user=$(ps -ef|grep  pmon|grep -v +ASM|awk '{print $1}'|head -1)
         #user=`ps -ef|grep  pmon_|grep -v grep|grep -v +ASM |awk '{print $1}'|head -1`

         if [ -d "/home/$user" ]
            then
                        SCRIPT_DIR=/home/$user/scripts

                        mkdir -p /home/"$user"/scripts/health_checks_logs
                        #mkdir -p /home/$user/scripts/DB_PT_LOGS
                        mkdir -p /home/"$user"/scripts/DB_PT_SCRIPTS

                        #LOG_DIR=/home/$user/scripts/DB_PT_LOGS
                        PC_LOG_DIR=/home/$user/scripts/health_checks_logs
                        SCRIPTS_DIR=/home/$user/scripts/DB_PT_SCRIPTS

                        cd "$PC_LOG_DIR" || exit
                        mkdir -p "$PC_LOG_DIR"/"$dt"
                        #mkdir -p "$PC_LOG_DIR"/"$dt""$ts"
                       cd "$PC_LOG_DIR"/"$dt" || exit

         elif [ -d "/local/$user" ]
             then
                        SCRIPT_DIR=/local/$user/scripts

                        mkdir -p /home/"$user"/scripts/health_checks_logs
                       # #mkdir -p /home/$user/scripts/DB_PT_LOGS
                        mkdir -p /home/"$user"/scripts/DB_PT_SCRIPTS

                        #LOG_DIR=/home/$user/scripts/DB_PT_LOGS
                        PC_LOG_DIR=/home/$user/scripts/health_checks_logs
                        SCRIPTS_DIR=/home/$user/scripts/DB_PT_SCRIPTS

                        cd "$PC_LOG_DIR" || exit
                        mkdir -p "$PC_LOG_DIR"/"$dt"
                        #mkdir -p "$PC_LOG_DIR"/"$dt""$ts"
                        cd "$PC_LOG_DIR"/"$dt" || exit
else
                         echo "${bred} cannot detect home directory check script_dir location  ${normal}"
         fi
    }

##############################################  MAIN #######################################################################

        normal=$(echo "\033[m")
        blue=$(echo "\033[36m") #Blue
        yellow=$(echo "\033[33m") #yellow
        white=$(echo "\033[00;00m") # normal white
        bred=$(echo "\033[01;31m") # bold red
        lyellow=$(echo "\e[103m") #background light yellow
        black=$(echo "\e[30m") #black
        byellow=$(echo "\e[43m") #background yellow \e[1m
        bnb=$(echo "\e[1m") # bold and bright
        blink=$(echo "\e[5m") # \e[42m
        blink=$(echo "\e[42m") #bgreen
        bdgray=$(echo "\e[100m") # background dark gray
        bgred=$(echo "\e[41m") # background red
       
		


                #Flag breakup function call
                Explicit_Call=0

                #input database name
                db_name=$1
                unset input

                #Today's Date
                dt=$(/bin/date +%d%m%Y)
                ts=$(/bin/date +%H%M%S)

                varhost=$(hostname|cut -d"." -f1)

                #Checking If script Directory Exists
                directory_exists
        clear
                echo -e "${bred} Logged in as $user and running the tunning assist script ${normal}"

        show_menu

#********************************************END****************************************************************#

