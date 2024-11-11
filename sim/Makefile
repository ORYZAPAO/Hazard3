SRC =  ../hdl/*.v *.sv


a.out : $(SRC)
	@echo "****"
	@echo "**** icaros verilog "
	@echo "****"
	iverilog -g2012 -f hazard3.f -I../hdl top.sv

##
## Vivado Simulator
##
v vivado :
	@echo "****"
	@echo "**** Vivado Simulator "
	@echo "****"
	xvlog -sv -f hazard3.f -i ../hdl top.sv
	xelab top -timescale 1ns/100ps
	xsim top -R


run :
	./a.out

clean :
	rm -f a.out
	rm -rf xsim*.* xelab*.* xvlog*.*

wave wav:
	gtkwave dump.vcd &

