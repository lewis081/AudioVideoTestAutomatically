@echo off & setlocal EnableDelayedExpansion
echo "hello Lewis!"

REM CUSTOMIZE for USER
set CUST_combined_file_count=10

echo ----------------------------------------------------
echo ------------------CUSTOMIZE START-------------------
echo CUST_combined_file_count: !CUST_combined_file_count!
echo ------------------CUSTOMIZE END  -------------------
echo ----------------------------------------------------

REM DONT MODIFY for below code!!! just for Maintainer

echo ----------------------------------------------------
echo ------------------SYSTEM START----------------------
set input_dir=resources\audio
set input_file=aac_48000_stereo.aac
set output_dir=outputs\audio
set tool_ffmpeg=..\tools\ffmpeg.exe

set input_file_path=..\!input_dir!\!input_file!

if exist !input_file_path! (
	echo EXIST: INPUT_FILE: !input_file_path!
	
	if not exist ..\!output_dir! (
		@echo NOT EXIST: OUTPUT_DIR: ..\!output_dir!. AUTO GENERATE IT.
		md ..\!output_dir!
	) else (
		@echo EXIST: OUTPUT_DIR: ..\!output_dir!
	)
	
	REM copy ..\!input_dir!\!input_file! ..\!output_dir!\!input_file!
	
) else (
	@echo NOT EXIST: INPUT_FILE: !input_file_path!
)


set count=0


for %%a in (1,2) do ( REM audio channel
	for %%b in (8000,44100,48000) do ( REM audio freqence
		for %%c in (mp3,aac,flac) do ( REM audio codec
			set aChannel=%%a
			set aFreq=%%b
			set aCodec=%%c
						
			set /a count=!count+1
			
			REM FILE limitation
			if !CUST_combined_file_count! lss 0 (
				echo GENERATE ALL COMBINATIONS!!!
			) else (
				if !count! GTR !CUST_combined_file_count! (
					echo GTR[SYS_count, CUST_combined_file_count]: [!count!, !CUST_combined_file_count!]
					goto 0
					REM pause
					REM EXIT
				)
			)
			
			set output_file=[!count!]A_!aChannel!_!aFreq!_!aCodec!.!aCodec!
			echo !output_file!...ING
			
			set output_file_path=..\!output_dir!\!output_file!
			if exist !output_file_path! (
				@echo !output_file! exists, will delete it and re-generate it.
				del !output_file_path!
			)
			!tool_ffmpeg! -i !input_file_path! -ac !aChannel! -ar !aFreq! -c:a !aCodec! -strict -2 !output_file_path! >nul 2>nul
			echo !output_file!...DONE
							
							

		)
	)
)

REM ffmpeg.exe -i %input_file% -ac %a_channel% -ar %a_freq% -c:a %a_codec% -r %v_fps% -s %v_resolution_width%x%v_resolution_height% -c:v %v_code% -strict -2 %output_file%

:0
echo ------------------SYSTEM END  -------------------
echo ----------------------------------------------------
echo "GoodBye Lewis!"
pause