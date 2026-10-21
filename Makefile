# Схема раскладки и обои рабочего стола.
# Нужно один раз: brew install uv librsvg imagemagick (keymap-drawer запускается через uvx)
KEYMAP := config/cradio.keymap
CONFIG := keymap_drawer.config.yaml
OUT    := keymap-drawer
LAYERS := Base Ru Nav Sym SymRu Sys
DRAWN  := Base Nav Sym SymRu Sys
KD     ?= uvx --from keymap-drawer keymap
BG     ?= \#1f2023
SCREEN ?= $(shell system_profiler SPDisplaysDataType 2>/dev/null | awk '/Resolution/ {print $$2 "x" $$4; exit}')
WIDTH   = $(shell echo $(SCREEN) | awk -Fx '{printf "%d", $$1 * 0.8}')

.PHONY: svg wall show clean

svg: $(OUT)/cradio.svg

$(OUT)/cradio.yaml: $(KEYMAP) $(CONFIG)
	@mkdir -p $(OUT)
	$(KD) -c $(CONFIG) parse -z $(KEYMAP) -l $(LAYERS) > $@

$(OUT)/cradio.svg: $(OUT)/cradio.yaml
	$(KD) -c $(CONFIG) draw $< -s $(DRAWN) > $@

$(OUT)/cradio-dark.svg: $(OUT)/cradio.yaml
	sed 's/dark_mode: auto/dark_mode: true/' $(CONFIG) > $(OUT)/.dark.yaml
	$(KD) -c $(OUT)/.dark.yaml draw $< -s $(DRAWN) > $@

# Обои: тёмная схема по центру экрана. Имя файла с меткой времени, иначе macOS берёт старую картинку из кэша.
wall: $(OUT)/cradio-dark.svg
	rm -f $(OUT)/wallpaper-*.png
	rsvg-convert -w $(WIDTH) $< -o $(OUT)/.keys.png
	magick -size $(SCREEN) xc:'$(BG)' $(OUT)/.keys.png -gravity center -composite $(OUT)/wallpaper-$$(date +%s).png
	osascript -e "tell application \"System Events\" to tell every desktop to set picture to POSIX file \"$$(ls $(CURDIR)/$(OUT)/wallpaper-*.png)\""

# Открыть схему в программе по умолчанию для SVG (обычно браузер).
show: svg
	open $(OUT)/cradio.svg

clean:
	rm -f $(OUT)/.dark.yaml $(OUT)/.keys.png $(OUT)/wallpaper-*.png $(OUT)/cradio-dark.svg
