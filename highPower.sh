#!/bin/bash
sudo sed -e '$d' /etc/default/cpufrequtils # delete last line
sudo sed -i '$a GOVERNOR="performance"' /etc/default/cpufrequtils # add line to 
sudo /etc/init.d/cpufrequtils restart
cpufreq-info
