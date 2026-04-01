.PHONY: run doc html clean check

GAP ?= gap
GAP_ARGS = -q --quitonbreak --packagedirs $(abspath .)

# run GAP and load the package
run:
	$(GAP) --packagedirs $(abspath .) -c 'LoadPackage("alnuth");'

doc:
	$(GAP) $(GAP_ARGS) makedoc.g -c 'QUIT;'

html:
	NOPDF=1 $(GAP) $(GAP_ARGS) makedoc.g -c 'QUIT;'

clean:
	cd doc && rm -f *.{aux,lab,log,dvi,ps,pdf,bbl,ilg,ind,idx,out,html,tex,pnr,txt,blg,toc,six,brf,css,js} _*.xml title.xml

check:
	$(GAP) $(GAP_ARGS) tst/testall.g
