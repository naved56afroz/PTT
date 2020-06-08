# PTT
Performance tuning tool for Lazy DBA

Download the main bash script and sql script placed in DB_PT_SCRIPTS directory

1. Copy the PT script.bash -> /home/$user/scripts/ 
   example : /home/oracle/scripts/ ($user is owner of oracle)
   
2. Copy all sql scripts in -> /home/"$user"/scripts/DB_PT_SCRIPTS  
   example : /home/oracle/scripts/DB_PT_SCRIPTS ($user is owner of oracle)
      
3. Run the script 

example:

sh PT_assist_v1.sh ORCL21     (Here pass the database name as parameter and play with interactive options)
