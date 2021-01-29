@echo off & setlocal EnableDelayedExpansion
echo "hello Lewis!"

set input_dir=resources
set input_file=bbb_short.ffmpeg.1920x1080.mp4.libx264_5000kbps_30fps.libfaac_stereo_192kbps_48000Hz.ts
set output_dir=outputs
set tool_ffmpeg=..\tools\ffmpeg.exe

if exist ..\!input_dir!\!input_file! (
	echo EXIST: INPUT_FILE: ..\!input_dir!\!input_file!
	
	if not exist ..\!output_dir! (
		@echo NOT EXIST: OUTPUT_DIR: ..\!output_dir!. AUTO GENERATE IT.
		md ..\!output_dir!
	) else (
		@echo EXIST: OUTPUT_DIR: ..\!output_dir!
	)
	
	REM copy ..\!input_dir!\!input_file! ..\!output_dir!\!input_file!
	
) else (
	@echo NOT EXIST: INPUT_FILE: ..\!input_dir!\!input_file!
)


set count=0

for %%a in (1,2) do ( REM audio channel
	for %%b in (8000,44100,48000) do ( REM audio freqence
		for %%c in (aac,flac) do ( REM audio codec
			set aChannel=%%a
			set aFreq=%%b
			set aCodec=%%c
			
			for %%d in (24,30) do ( 
				for %%e in (1280x720,1920x1080) do ( 
					for %%f in (mpeg4,h264) do ( 
						for %%g in (mp4,mkv) do ( 
							set vFps=%%d
							set vResolutionWH=%%e
							set vCodec=%%f
							set vFormat=%%g
							set /a count=!count+1
							
							set output_file=[!count!]A_!aChannel!_!aFreq!_!aCodec!_V_!vFps!_!vResolutionWH!_!vCodec!.!vFormat!
							echo !output_file!...ING
							
							if exist ..\!output_dir!\!output_file! (
								@echo !output_file! exists, will delete it and re-generate it.
								del ..\!output_dir!\!output_file!
							)
							!tool_ffmpeg! -i ..\!input_dir!\%input_file% -ac !aChannel! -ar !aFreq! -c:a !aCodec! -r !vFps! -s !vResolutionWH! -c:v !vCodec! -strict -2 ..\!output_dir!\!output_file! >nul 2>nul
							echo !output_file!...DONE
							
							if !count! equ 10 (
								pause
								EXIT
							)
						)
					)
				)
			
			)	
		)
	)
)

REM ffmpeg.exe -i %input_file% -ac %a_channel% -ar %a_freq% -c:a %a_codec% -r %v_fps% -s %v_resolution_width%x%v_resolution_height% -c:v %v_code% -strict -2 %output_file%

echo "GoodBye Lewis!"
pause