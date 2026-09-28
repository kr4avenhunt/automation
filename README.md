# Automation - Bash Repository to Automate Boring Tasks

I made this repository mainly for educational purposes to improve my Bash skills by building something practical and useful. 

The repository consists of 5 main scripts:

## **Mass Renamer**
Renames files sequentially (e.g., `42fsadsa.pdf` and `53jfh3.pdf` become `file1.pdf` and `file2.pdf`).

## **Backup Script**
Creates a `backups` directory in the user's home folder and backs up all files from the current working directory, naming the archive `backup_YYYY-MM-DD.zip`.  
*Requires:* `zip`

## **Cleaner Script**
Moves all files from the current directory (except `cleaner.sh`) into an `archive` folder inside `/home/$USER`, sorting them automatically by file extension with a colorful visual output.

## **System Monitor**
A quick dashboard displaying system information and real-time CPU, RAM and Disk usage.  
*Requires:* `pciutils` (`lspci`)

## **Install.sh**
Automatic setup script that installs missing dependencies and configures Cron for automated execution.
