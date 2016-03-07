#!/bin/bash
 
################################################################### NOTES ########################################################################
#                                                                                                                                                #
#   1. MAKE SURE 'eval "$BASH_POST_RC"' (without single quotes) IS AT THE END OF YOUR .bashrc FILE!!!                                            #
#   2. xdotool should be installed (sudo apt-get install xdotool).                                                                               #
#                                                                                                                                                #
##################################################################################################################################################                                                                                                                        
 
############################################# APPLICATIONS ######################################################
# Google Chrome                                                                                                 #
# google-chrome  &                                                                                              #
#                                                                                                               #
# Firefox                                                                                                       #
  firefox "localhost:3000" &                                                                                    # 
#                                                                                                               #
# Sublime Text                                                                                                  #
  subl --data ~/projects/rails-starter-app &                                                                    #
#################################################################################################################
 
############################################## TERMINALS ########################################################
gnome-terminal --working-directory="~/projects/rails-starter-app" --title "Rails Starter App" --geometry=138x36+155+0 \
--tab -e 'bash -c "export WORKING_BRANCH=\"$(git name-rev --name-only HEAD)\"; export BASH_POST_RC=\"git checkout master; git fetch -p; git pull; git checkout ${WORKING_BRANCH}; git pull origin ${WORKING_BRANCH}; git status\"; exec bash"' \
--tab \
--tab -e 'bash -c "export BASH_POST_RC=\"rails c;\"; exec bash"' \
--tab -e 'bash -c "export BASH_POST_RC=\"rails s; xdotool search --name \\\"Rails Starter App\\\" windowfocus; xdotool key alt+1;\"; exec bash"' &
