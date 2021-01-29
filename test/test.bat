@echo off & setlocal EnableDelayedExpansion

set obj[0]=test1
set obj[1]=test2
set obj[2]=9876
set obj[3]=wwww

set objCurrent=0

for %%a in (0,1,2,3) do (
    for /f "usebackq delims== tokens=1-2" %%i in (`set obj[%%a]`) do (
        echo F=%%i
        echo S=%%j
        set objCurrent=%%j
    )
    echo objCurrent=!objCurrent!

)

pause
EXIT


@REM customized code

set A2[0]=a20
set A2[1]=a21
set A2[2]=a22
set A2[3]=a23

for %%a in (0,1,2,3) do (
    for /f "usebackq delims== tokens=1-2" %%i in (`set obj[%%a]`) do (
		for %%a in (0,1,2,3) do (
			for /f "usebackq delims== tokens=1-2" %%i in (`set A2[%%a]`) do (
				set objCurrent=%%j
				echo %%j
			)
			REM echo value=!objCurrent!
		)
	)
)


for %%a in (1,2) do ( REM audio channel
	for %%b in (600x400,44100,48000) do ( REM audio freqence
		for %%c in (aac,flac) do ( REM audio codec
			set aChannel=%%a
			set aFreq=%%b
			set aCodec=%%c
			
			echo Lewis: !aChannel!_!aFreq!_!aCodec!.!aCodec!
		)
	)
)


pause