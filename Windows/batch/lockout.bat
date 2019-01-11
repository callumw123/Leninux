@echo off
net accounts /lockoutthreshold:5
net accounts /lockoutwindow:30
net accounts /lockoutduration:30
