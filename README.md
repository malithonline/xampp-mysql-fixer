# **XAMPP MySQL Data Recovery Script**

![XAMPP MySQL Fixer Screenshot](https://github.com/malithonline/xampp-mysql-fixer/blob/main/screenshot.png)

This is a batch script designed to fix common MySQL startup errors in XAMPP (like "Error: MySQL shutdown unexpectedly"). This error usually happens when database files get corrupted or another program blocks the MySQL port.
The script automates the manual process of resetting the data folder while keeping your databases intact.

## **How to use**
1. Stop MySQL in the XAMPP Control Panel.  
2. Download the fix\_mysql.bat file.  
3. Right-click the file and select **Run as Administrator**.  
4. When prompted, type **Y** and press Enter to confirm.  
5. Wait for the "Restoration Completed" message.  
6. Start MySQL in the XAMPP Control Panel.

## **Download**

[![Download fix_mysql.bat](https://github.com/malithonline/xampp-mysql-fixer/blob/main/downloadbutton.jpg)](https://github.com/malithonline/xampp-mysql-fixer/releases/tag/fix_mysql.bat)

## **How it works**
The script performs the following steps automatically:
1. Renames your current mysql\\data folder to a backup name (e.g., data\_old\_20231014).  
2. Creates a fresh data folder using the contents of the mysql\\backup directory.  
3. Copies your custom database folders from the old data folder to the new one.  
4. Copies the ibdata1 file to ensure your old databases are readable.

## **Important Notes**
* This script assumes your XAMPP installation is in the default location: C:\\xampp.  
* Your old data is not deleted; it is renamed to data\_old\_\[timestamp\] inside the mysql directory.  
* It is always a good habit to manually backup your mysql\\data folder before running any recovery scripts.
