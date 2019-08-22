all:
	gnatmake *.adb
run:
	./vm
clean:
	rm *.ali
	rm *.o
	rm vm
