#!/usr/bin/env bash
#
# This script will configure an environment to complete the Advanced Auto Scaling workbook
# #https://portal2010.amazon.com/sites/aws-support-training/_layouts/WordViewer.aspx?id=/sites/aws-support-training/New%20Hire%20Training/Advanced%20Training/AutoScaling%2BSelf-Paced%2BAssignment.docx&Source=https%3A%2F%2Fportal2010%2Eamazon%2Ecom%2Fsites%2Faws%2Dsupport%2Dtraining%2FNew%2520Hire%2520Training%2FForms%2FAllItems%2Easpx%3FRootFolder%3D%252Fsites%252Faws%252Dsupport%252Dtraining%252FNew%2520Hire%2520Training%252FAdvanced%2520Training%26FolderCTID%3D0x0120001D4D9A6E25B01949BCC224C242CA1F79%26View%3D%257bC03&DefaultItemOpen=1&DefaultItemOpen=1
#

## Variables
_project="EC2 Linux and WordPress"
_srcDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
v_key=$(echo -e "$(printf '%04x' $RANDOM $RANDOM)")

. ${_srcDir}/variables/global

if [ ! -d ${_srcDir}/deployments ]; then mkdir ${_srcDir}/deployments; fi


## workers
for i in $(find workers -maxdepth 2 -type f); do . $i; done

### Script Begin ###
while true; do
  case $1 in
    --[Dd][Ee][Pp][Ll][Oo][Yy] )
      mkdir ${_srcDir}/deployments/${v_key}
      echo -e "\n\tDeploying ${_project} environment...\n"
      echo -e "\t\tThis might take a few minutes, go grab a cofee.\n"
      f_deploy
      break
      ;;
    --[Cc][Ll][Ee][Aa][Nn][Uu][Pp] )
      echo -e "\n\tTearing down ${_project} environment...\n"
      f_cleanup
      break
      ;;
    --[Ii][Nn][Cc][Rr][Ee][Aa][Ss][Ee]-[Ll][Oo][Aa][Dd] )
      echo -e "\n\tIncreasing traffic to $(f_get_elb_dnsname)"
      f_increase_traffic
      break
      ;;
    --[Hh][Ee][Ll][Pp] )
      f_print_help
      break
      ;;
    * )
      f_print_help
      break
      ;;
  esac
done
### Script End ###
