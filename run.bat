@echo off & setlocal EnableDelayedExpansion

set src_dir=.\src
set src_back_dir=.\..\
set src_bat_audio=generateAudioTestFile.bat
set src_bat_video=generateVideoTestFile.bat

REM echo goto !src_dir!
cd !src_dir!

call !src_bat_audio!
REM call !src_bat_video!

cd !src_back_dir!
echo BACKTO %cd%


pause
