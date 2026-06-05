# Specific Cromite Webview release to fetch.
APKVER		:= 	v148.0.7778.168-cb3baf14f52eb4365d017f640f85310735c19b79

# Magisk module.prop configuration.
# See https://github.com/topjohnwu/Magisk/blob/master/docs/guides.md.
ID		:=	cromitewebview
NAME		:=	Cromite Webview
VER		:=	$(firstword $(subst -, , $(APKVER)))
VERCODE		:=	1
AUTHOR		:=	Nemris
DESC		:=	Install the Cromite Webview systemlessly.

# Build paths and module files.
BUILDDIR	:=	build
APKDIR		:=	$(BUILDDIR)/system/app/WebViewCromite
SCRIPTDIR	:=	$(BUILDDIR)/META-INF/com/google/android
MANIFEST	:=	$(BUILDDIR)/module.prop
APK		:=	$(APKDIR)/WebViewCromite.apk
UPD_BIN		:=	$(SCRIPTDIR)/update-binary
UPD_SCRIPT	:=	$(SCRIPTDIR)/updater-script

# Output paths.
OUTDIR		:=	out
ZIPFILE		:=	$(OUTDIR)/$(firstword $(NAME))_$(lastword $(NAME))-$(VER).zip

.PHONY: release clean 

release: $(ZIPFILE)

clean:
	rm -rfv -- $(BUILDDIR) $(OUTDIR)

$(ZIPFILE): $(MANIFEST) $(APK) $(UPD_BIN) $(UPD_SCRIPT)
	@echo "Building '$@'..."
	@mkdir -p $(OUTDIR)
	@cd $(BUILDDIR) && zip -0qr ../$@ "./"

$(MANIFEST): | $(BUILDDIR)
	@echo "Writing '$@'..."
	@echo "id=$(ID)" >> $@
	@echo "name=$(NAME)" >> $@
	@echo "version=$(VER)" >> $@
	@echo "versionCode=$(VERCODE)" >> $@
	@echo "author=$(AUTHOR)" >> $@
	@echo "description=$(DESC)" >> $@

$(APK):	| $(APKDIR)
	@echo "Fetching Cromite Webview $(APKVER)..."
	@curl -sSL "https://github.com/uazo/cromite/releases/download/$(APKVER)/arm64_SystemWebView.apk" -o $@

$(UPD_BIN): | $(SCRIPTDIR)
	@echo "Fetching latest '$(notdir $@)'..."
	@curl -sSL "https://raw.githubusercontent.com/topjohnwu/Magisk/refs/heads/master/scripts/module_installer.sh" -o $@

$(UPD_SCRIPT): | $(SCRIPTDIR)
	@echo "Writing '$(notdir $@)'..."
	@echo "#MAGISK" > $@

$(BUILDDIR):
	@mkdir $@

$(APKDIR) $(SCRIPTDIR): | $(BUILDDIR)
	@mkdir -p $@
