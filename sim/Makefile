.PHONY: all clean

all: sim_tb

clean:
	rm -f sim_tb

sim_tb: sim_tb.v ../src/user_module_341164910646919762.v
	iverilog sim_tb.v -o sim_tb ../src/user_module_341164910646919762.v
