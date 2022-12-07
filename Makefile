all 	:
	make -C src/

test :  all
	./compil.sh $f

clean	:
	make -C src/ clean