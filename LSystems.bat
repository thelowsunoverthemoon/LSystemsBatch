@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
IF "%1" == "" (
    >NUL REG ADD HKCU\Console\LSystem /v FontSize /t reg_dword /d 0x00000040  /f
    START "LSystem" /MAX "%ComSpec%" /C %~s0 1
    EXIT
) else ( >NUL REG DELETE HKCU\Console\LSystem /f )

FOR /F %%A in ('ECHO prompt $E^| cmd') DO SET "ESC=%%A"

::Parameters
SET /A "angle=1","iterate=9"

::Dragon Curve
SET "chars=U Q E"
SET "axiom=UQ"
SET rules="Q=Q+{EU+" "E=-UQ-}E"


::"Angles" (angle 2 doesn't exist)
SET "an[1]=%ESC%[D%ESC%[A"
SET "an[3]=%ESC%[D%ESC%[B"
SET "an[4]=%ESC%[2D"

::Constants
SET "arithmet=- +"
SET "co[-]=-1"
SET "co[+]=+1"
SET "co[{]=%ESC%[38;2;132;194;209m"
SET "co[}]=%ESC%[38;2;125;93;194m"
SET "co[[]=%ESC%[s"
SET "co[]]=%ESC%[u%ESC%[D"

::Setup
FOR %%R in (%rules%) DO (
    SET "dchar=%%~R"
    SET "usechars=!usechars! !dchar:~0,1!"
)
FOR /L %%# in (1, 1, %iterate%) DO (
    FOR %%Q in (%usechars%) DO (SET "axiom=!axiom:%%Q=#%%Q!")
    FOR %%A in (%rules%) DO (SET "axiom=!axiom:#%%~A!")
)
SET "axiom=%axiom:][=]%"
FOR %%Q in (%chars% + - [ ]) DO (SET "axiom=!axiom:%%Q= %%Q !")

:DISPLAY
ECHO %ESC%[40;30H%ESC%[s%ESC%[38;2;132;194;209m
FOR %%A in (%axiom%) DO (
    IF "!chars:%%A=!" == "!chars!" (
        IF "!arithmet:%%A=!" == "!arithmet!" (
            ECHO !co[%%A]!
        ) else (
            SET /A "angle=angle!co[%%A]!"
            IF !angle! GTR 4 (
                SET "angle=1"
            ) else IF !angle! LSS 1 (
                SET "angle=4"
            )
        )
    ) else (
        FOR %%A in (!angle!) DO (
            ECHO %ESC%[u!an[%%A]!Û%ESC%[s
        )
    )
)
PAUSE>NUL
EXIT /B

