OUTPUT = life.alfredworkflow
FILES = Info.plist life.swift icon.png

all: $(OUTPUT)

clean:
	-rm $(OUTPUT)

$(OUTPUT): $(FILES)
	zip $@ $(FILES)
