SHELL=/bin/sh
RFC=xml2rfc template.xml
TITLE=$(shell grep docName template.xml | sed -e 's/.*docName=\"//' -e 's/\">//')
.PHONY: txt html xml

txt:	$(TITLE).txt

html:	$(TITLE).html

xml:	$(TITLE).xml

all:	txt html

target:	
	@ if [ ! -d target ]; then mkdir target; fi	

%.xml:	%.mkd transform.xsl target
	pandoc $< -t docbook -s | xsltproc --nonet transform.xsl - > target/$@

$(TITLE).txt:	draft.txt
	@ cd target && ln -sf $< $@

$(TITLE).html:	draft.html
	@ cd target && ln -sf $< $@

$(TITLE).xml:	draft.xml
	@ cd target && ln -sf $< $@

draft.txt:	middle.xml back.xml template.xml
	cp template.xml target/ && cd target && $(RFC) --text --no-dtd -b draft

draft.html: 	middle.xml back.xml template.xml
	cp template.xml target/ && cd target && $(RFC) --html --no-dtd -b draft

draft.xml:    middle.xml back.xml template.xml
	cp template.xml target/ && cd target && $(RFC) --exp --no-dtd -b draft && ../remove-entities.sh

clean:
	rm -rf target 
