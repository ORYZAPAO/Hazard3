SRC =  ../hdl/*.v *.sv


a.out : $(SRC)
	iverilog -g2012 -f hazard3.f -I../hdl top.sv

run :
	./a.out

clean :
	rm a.out

wave wav:
	gtkwave dump.vcd &

