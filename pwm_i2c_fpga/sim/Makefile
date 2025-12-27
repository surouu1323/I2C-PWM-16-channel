
TB_NAME  	?= tb
TESTNAME 	?= test
RADIX       ?= hexadecimal
TOP_FILE 	?= pwm
RTL_FILES 	:= $(filter-out %_copy.v %_old.v %_dis.v, $(wildcard ../src/$(TOP_FILE)/*.v))

CASE          ?= default
TESTCASE_SRC   = ../tb/testcase/$(CASE).v
TESTCASE_DST   = ./test_case.v

# ========= BUILD & RUN =========
all: build run

all_tc:
	@if [ "$(CASE)" = "none" ]; then \
		echo "ERROR: Chưa chỉ định testcase. Dùng cú pháp: make all_wave CASE=prescale_1"; \
		exit 1; \
	fi

	@if [ ! -f "$(TESTCASE_SRC)" ]; then \
		echo "ERROR: Không tìm thấy file testcase: $(TESTCASE_SRC)"; \
		exit 1; \
	fi

	@echo ">>> [Step 1/4] Copying testcase file..."
	cp $(TESTCASE_SRC) $(TESTCASE_DST)

	@echo ">>> [Step 2/4] Building design..."
	$(MAKE) build DEFINE=WAVE

	@echo ">>> [Step 3/4] Running simulation..."
	$(MAKE) run

all_tc_wave: all_tc_wave
	@echo ">>> [Step 4/4] Opening waveform..."
	if [ -e ./test_case.v ]; then rm ./test_case.v; fi
	$(MAKE) wave

all_wave:
	$(MAKE) build DEFINE=WAVE
	$(MAKE) run
	$(MAKE) wave

all_dec:
	$(MAKE) build DEFINE=DEC
	$(MAKE) run
	$(MAKE) dec

build:
	iverilog -g2012 $(if $(DEFINE),-D$(DEFINE)) -o ./$(TB_NAME).vcd ../tb/$(TB_NAME).v $(RTL_FILES)

run:
# 	vvp -l ./$(TESTNAME).log ./$(TB_NAME).vcd
	vvp ./$(TB_NAME).vcd

wave:
	gtkwave ./dump.vcd --script=add_all.tcl

dec:
	"C:\Program Files\sigrok\PulseView\pulseview.exe" --clean --settings ./session.pvs --input-file ./dump_dec.vcd 

check:
	verilator --lint-only $(RTL_FILES) --top-module pwm_top

clean:
	if exist .\vcd rmdir /s /q .\vcd
	if exist .\log rmdir /s /q .\log
	if exist .\vcd\*.vcd del /q .\vcd\*.vcd
	if exist *.vcd del /q *.vcd
	if exist *.log del /q *.log
	if exist *.ini del /q *.inis
	if exist *.wlf del /q *.wlf
	if exist transcript del /q transcript
	if exist test_case.v rm -f test_case.v
# 	if exist $(COV_DIR)\*.ucdb del /q $(COV_DIR)\*.ucdb
# 	if exist $(COV_DIR)\work rmdir /s /q $(COV_DIR)\work




