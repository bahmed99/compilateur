all 	:
	make -C src/

test 	:  
	./compil.sh $f

clean	:
	make -C src/ clean