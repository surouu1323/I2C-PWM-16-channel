
TB_NAME  	?= tb
TESTNAME 	?= i2c_rw_chk
RADIX       ?= hexadecimal
TOP_FILE 	?= pwm
COV ?= 0

# ========= BUILD & RUN =========
all: build run

all_wave: build run wave

all_cov: build_cov run_cov

build:
	rm run_test.v
	mkdir -p log
	cp -rf ../testcases/$(TESTNAME).v run_test.v
	vlib work
	vmap work work
	vlog  -f compile.f | tee compile.log

build_cov:
	mkdir -p log
	cp -rf ../testcases/$(TESTNAME).v run_test.v
	vlib work
	vmap work work
	vlog +cover=bcesft +coverexclude=tb -f compile.f


run:
	vsim -debugDB -l $(TESTNAME).log -voptargs=+acc -assertdebug -c $(TB_NAME) -do "log -r /*;run -all;"
	cp $(TESTNAME).log ./log
	mv $(TESTNAME).log sim.log

wave:
	vsim -i -view vsim.wlf -do "add wave vsim:/$(TB_NAME)/*; radix -$(RADIX); Waveform Zoom Range 30" &


run_cov:
	vsim -coverage -l $(TESTNAME).log -c $(TB_NAME) -voptargs="+cover=bcesft" -assertdebug -do "coverage save -onexit ./ucdb/$(TESTNAME).ucdb; log -r /*;run -all"
	cp $(TESTNAME).log ./log
	mv $(TESTNAME).log sim.log

gen_cov:
	mkdir -p coverage
	vcover report IP.ucdb -output coverage/summary_report.txt
	vcover report -zeros -details -code bcesft -annotate -All -codeAll IP.ucdb -output coverage/detail_report.txt


check:
	verilator --lint-only -f rtl.f

run_all: clean
	tcsh run_tc.csh

run_all_cov: clean
	tcsh run_tc.csh cov

report:
	tcsh report.csh

sum:
	tcsh coverage_summary.csh

clean:
	rm -rf *.log
	rm -rf *.ini
	rm -rf vsim.dbg
	rm -rf *.wlf
	rm -rf work
	rm -rf transcript
	rm -rf *.ucdb
	rm -rf ./ucdb/*.ucdb
	rm -rf wlft*
	rm -rf run_test.v

# 	if exist .\vcd rmdir /s /q .\vcd
# 	if exist .\log rmdir /s /q .\log
# 	if exist .\vcd\*.vcd del /q .\vcd\*.vcd
# 	if exist *.vcd del /q *.vcd
# 	if exist *.log del /q *.log
# 	if exist *.ini del /q *.inis
# 	if exist *.wlf del /q *.wlf
# 	if exist transcript del /q transcript
# 	if exist test_case.v rm -f test_case.v
# 	if exist $(COV_DIR)\*.ucdb del /q $(COV_DIR)\*.ucdb
# 	if exist $(COV_DIR)\work rmdir /s /q $(COV_DIR)\work




