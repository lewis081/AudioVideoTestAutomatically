@echo off & setlocal EnableDelayedExpansion

set src_dir=.\src
set src_back_dir=.\..\
set src_bats=generateTestFile.bat

REM echo goto !src_dir!
cd !src_dir!

call !src_bats!

cd !src_back_dir!
echo BACKTO %cd%


pause
