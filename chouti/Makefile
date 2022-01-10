OUTPUT = chouti.alfredworkflow
FILES = Info.plist chouti.swift icon.png

all: $(OUTPUT)

clean:
	-rm $(OUTPUT)

$(OUTPUT): $(FILES)
	zip $@ $(FILES)
