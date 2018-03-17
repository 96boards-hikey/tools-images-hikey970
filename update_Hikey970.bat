cls

:start

@echo -----------------------------
@echo %date%-%time%
@echo "hikey970 Updating:"

fastboot flash xloader sec_xloader.img
	@if errorlevel 1 goto error

fastboot flash ptable prm_ptable.img
	@if errorlevel 1 goto error

fastboot flash fastboot l-loader.bin
	@if errorlevel 1 goto error

fastboot flash fip fip.bin
	@if errorlevel 1 goto error

::fastboot flash nvme nvme.img
::	@if errorlevel 1 goto error

::fastboot flash trustfirmware bl31.bin
::	@if errorlevel 1 goto error

fastboot flash boot boot.img
	@if errorlevel 1 goto error

fastboot flash cache cache.img
	@if errorlevel 1 goto error

fastboot flash system system.img
	@if errorlevel 1 goto error

fastboot flash userdata  userdata.img
	@if errorlevel 1 goto error

@goto sucess

:error
@echo "Update Failed!"
@pause
@goto end

:sucess
@echo "Update Sucess"
@pause

:end