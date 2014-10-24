Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:63273 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214AbaJXMoz (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 24 Oct 2014 08:44:55 -0400
Date: Fri, 24 Oct 2014 14:44:43 +0200
From: Holger Eitzenberger <holger@eitzenberger.org>
To: jcm@jonmasters.org, linux-modules@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sebastian.poehn@sohpos.com
Subject: Regression using module-init-tools on Kernel v3.12.y
Message-ID: <20141024124443.GB9396@imap.eitzenberger.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(now with patch)

Hi all,

we are still using module-init-tools for module handling.  And so does
SuSE SLES11.

However, after upgrading from kernel v3.8.y to v3.12.y we noticed
that modules.pcimap was empty, which is due to the fact that the
DEFINE_PCI_DEVICE_TABLE() has been modified to encode the name of
the device table.  Which in turn has been done to avoid issues with
multiple tables in a driver (see [1]).

I understand why this patch went it, and fixing this issue in the PNP
driver is worth fixing, I agree.

However, there is quite some userbase of module-init-tools out there,
eventually upgrading as well.  And as a consequence I think it makes
sense to patch module-init-tools as well to support both format.

I know that module-init-tools are deprecated by libkmod, and therefore
they seem to be unmaintained since 2011 (at least when looking at
git.kernel.org).

Still, does the attached patch makes sense to apply to git GIT repo?
It modifies elfops to support old and new format of the table name.

I think most people will check kernel.org GIT for a patch, so I think
it makes sense to apply this patch.

Thanks.

 /Holger


[1] http://marc.info/?l=linux-input&m=139091653012772&w=2

--FCuugMFkClbJLl1L
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="support-newer-elf-section.diff"

depmod: check both old and new __mod_pci_device_tab_section

New format has name of table included, e. g. for e100 driver:

  __mod_pci__e100_id_table_device_table

Signed-off-by: Holger Eitzenberger <holger@eitzenberger.org>

Index: module-init-tools/elfops_core.c
===================================================================
--- module-init-tools.orig/elfops_core.c
+++ module-init-tools/elfops_core.c
@@ -348,49 +348,51 @@ static void PERBIT(fetch_tables)(struct
 	for (i = 0; i < size / sizeof(syms[0]); i++) {
 		char *name = strings + END(syms[i].st_name, conv);
 
-		if (!tables->pci_table && streq(name, "__mod_pci_device_table")) {
+		if (!tables->pci_table && mod_device_table("pci", name)) {
 			tables->pci_size = PERBIT(PCI_DEVICE_SIZE);
 			tables->pci_table = PERBIT(deref_sym)(hdr, sechdrs, &syms[i],
 							      NULL, conv);
 		}
-		else if (!tables->usb_table && streq(name, "__mod_usb_device_table")) {
+		else if (!tables->usb_table && mod_device_table("usb", name)) {
 			tables->usb_size = PERBIT(USB_DEVICE_SIZE);
 			tables->usb_table = PERBIT(deref_sym)(hdr, sechdrs, &syms[i],
 							      NULL, conv);
 		}
-		else if (!tables->ccw_table && streq(name, "__mod_ccw_device_table")) {
+		else if (!tables->ccw_table && mod_device_table("ccw", name)) {
 			tables->ccw_size = PERBIT(CCW_DEVICE_SIZE);
 			tables->ccw_table = PERBIT(deref_sym)(hdr, sechdrs, &syms[i],
 							      NULL, conv);
 		}
-		else if (!tables->ieee1394_table && streq(name, "__mod_ieee1394_device_table")) {
+		else if (!tables->ieee1394_table &&
+				 mod_device_table("ieee1394", name)) {
 			tables->ieee1394_size = PERBIT(IEEE1394_DEVICE_SIZE);
 			tables->ieee1394_table = PERBIT(deref_sym)(hdr, sechdrs, &syms[i],
 								   NULL, conv);
 		}
-		else if (!tables->pnp_table && streq(name, "__mod_pnp_device_table")) {
+		else if (!tables->pnp_table && mod_device_table("pnp", name)) {
 			tables->pnp_size = PERBIT(PNP_DEVICE_SIZE);
 			tables->pnp_table = PERBIT(deref_sym)(hdr, sechdrs, &syms[i],
 							      NULL, conv);
 		}
-		else if (!tables->pnp_card_table && streq(name, "__mod_pnp_card_device_table")) {
+		else if (!tables->pnp_card_table &&
+				 mod_device_table("pnp_card", name)) {
 			tables->pnp_card_size = PERBIT(PNP_CARD_DEVICE_SIZE);
 			tables->pnp_card_table = PERBIT(deref_sym)(hdr, sechdrs, &syms[i],
 								   NULL, conv);
 			tables->pnp_card_offset = PERBIT(PNP_CARD_DEVICE_OFFSET);
 		}
-		else if (!tables->input_table && streq(name, "__mod_input_device_table")) {
+		else if (!tables->input_table && mod_device_table("input", name)) {
 			tables->input_size = PERBIT(INPUT_DEVICE_SIZE);
 			tables->input_table = PERBIT(deref_sym)(hdr, sechdrs, &syms[i],
 							        &tables->input_table_size,
 							        conv);
 		}
-		else if (!tables->serio_table && streq(name, "__mod_serio_device_table")) {
+		else if (!tables->serio_table && mod_device_table("serio", name)) {
 			tables->serio_size = PERBIT(SERIO_DEVICE_SIZE);
 			tables->serio_table = PERBIT(deref_sym)(hdr, sechdrs, &syms[i],
 								NULL, conv);
 		}
-		else if (!tables->of_table && streq(name, "__mod_of_device_table")) {
+		else if (!tables->of_table && mod_device_table("of", name)) {
 			tables->of_size = PERBIT(OF_DEVICE_SIZE);
 			tables->of_table = PERBIT(deref_sym)(hdr, sechdrs, &syms[i],
 							     NULL, conv);
Index: module-init-tools/elfops.c
===================================================================
--- module-init-tools.orig/elfops.c
+++ module-init-tools/elfops.c
@@ -15,6 +15,8 @@
 
 #include "testing.h"
 
+#define SLEN(str)		(sizeof(str) - 1)
+
 /* Symbol types, returned by load_dep_syms */
 static const char *weak_sym = "W";
 static const char *undef_sym = "U";
@@ -28,6 +30,44 @@ static const char *skip_dot(const char *
        return str;
 }
 
+/*
+ * mod_device_table - check for name of module device table
+ * @type: section type (e. g. "pci")
+ * @name: section name
+ *
+ * Both old and new format supported.
+ *
+ * Returns non-zero value if so.
+ */
+static int
+mod_device_table(const char *type, const char *name)
+{
+	size_t len;
+
+	if (strncmp(name, "__mod_", SLEN("__mod_")) != 0)
+		return 0;
+	name += SLEN("__mod_");
+
+
+	len = strlen(type);
+	if (strncmp(name, type, len) != 0)
+		return 0;
+	name += len;
+
+	if (name[0] != '_')
+		return 0;
+
+	name++;
+	if (name[0] != '_')
+		return strcmp(name, "device_table") == 0;
+
+	/* new format */
+	len = strlen(name);
+
+	return len > SLEN("device_table") &&
+		strcmp(name + len - SLEN("device_table"), "device_table") == 0;
+}
+
 #define ELF32BIT
 #include "elfops_core.c"
 #undef ELF32BIT

--FCuugMFkClbJLl1L--
