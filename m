Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798222;
	b=yhzy+FTmj2745pxgyXKlt+D5/l0N5NydU7Cmzs9THNqYBJjoVXJqhjn8/kqMCYbUrE09
	 4KMnCszp8qsov6Z8863ZMhH1Ru/U5w1hJWPdAwiG6ilWoW2KChe5/OK1j3dUB3ntsRxlR
	 wcO1Op/fqZQMRIF9h4H6s8FGlLGJmNNPMwD9w0VAHnFsOY2tfsL5AcVVBZZT9SJalaEOC
	 4zeXl1f5soOBmIh4N7eTiDAxi/YGlkP2OJUGd9eocnEUCNzpKJaUm8X6+M4dPqkL9H8am
	 7go6paJ+36bkUPzf7zPpRgf/vbO7iNVQY3fa4iXrubqTxyceLLTcIbjczYWRnWhymlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798222;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Spam-Flag:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=CtZ3Cz1JVzHYFe/52gRFW/Y/fmMQcF+9xc7z8JxnkWw=;
	b=sW8nV+6XslWBD7P7xAjdHQg2Bic+irwsn2RtEoE/zQ1pkF68x/0YuxEkr04Cqif3p/Zn
	 htYfe5jjEFjR0rmajZhc5yCW6DmZjKSVGy+4jOf5nWmYeaE6MCL/BNfyJ4tq8FQsgNtnF
	 b+4le1eGi4ILd7GQTfaQ3vZ8oBLc10iqgiG5IXERPCLkv9duCDwmov6lo42lIjr5Kt0oQ
	 7U5rOa9Cr/2D5bf64mecOD+4KKh5rCoeV02grm443G6YMmVLpDrmkYTisJZqrAUutRqLI
	 MrKb03S5r3pZ5UStTjLqlg05rJyQo/RbociEMJsDtNpaI/v5ExYGUytoG6cf3ZltHFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XDYgHEBs;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oSmgFGfU;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XDYgHEBs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oSmgFGfU;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9129D606A329
	for <linux-modules@vger.kernel.org>; Fri, 27 Nov 2026 16:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9129D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XDYgHEBs;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oSmgFGfU;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XDYgHEBs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oSmgFGfU
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B4BF229AF;
	Fri, 27 Nov 2026 16:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795798219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CtZ3Cz1JVzHYFe/52gRFW/Y/fmMQcF+9xc7z8JxnkWw=;
	b=XDYgHEBsRJTckAueqI84rE0fhPYn/zo79SoZqsdnzkcXYqdKG+NSZEYdqRQFzyjnr3tzoJ
	v8yfBD+iAc8x7j/tjdjDKl+c1W+4+3Gc59xfLaMlUyMNUnHFBbUooUU4PAmxxaYxq8N18P
	vXWZT/d6qHPljs+QOOU09j78zLbSNik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795798219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CtZ3Cz1JVzHYFe/52gRFW/Y/fmMQcF+9xc7z8JxnkWw=;
	b=oSmgFGfU2xvChgq96IaFaFedPBVS1GMexxEfHddBc4UfLweAYQyhmYcdYJWPzRDQ6bdMuh
	J7C3RVduNjHaXEAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795798219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CtZ3Cz1JVzHYFe/52gRFW/Y/fmMQcF+9xc7z8JxnkWw=;
	b=XDYgHEBsRJTckAueqI84rE0fhPYn/zo79SoZqsdnzkcXYqdKG+NSZEYdqRQFzyjnr3tzoJ
	v8yfBD+iAc8x7j/tjdjDKl+c1W+4+3Gc59xfLaMlUyMNUnHFBbUooUU4PAmxxaYxq8N18P
	vXWZT/d6qHPljs+QOOU09j78zLbSNik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795798219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CtZ3Cz1JVzHYFe/52gRFW/Y/fmMQcF+9xc7z8JxnkWw=;
	b=oSmgFGfU2xvChgq96IaFaFedPBVS1GMexxEfHddBc4UfLweAYQyhmYcdYJWPzRDQ6bdMuh
	J7C3RVduNjHaXEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33BDF13432;
	Fri, 27 Nov 2026 16:50:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id onUAA8u0CWsQZQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 27 Nov 2026 16:50:19 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-modules@vger.kernel.org
Subject: [PATCH] libkmod: elf: Support extended modversions
Date: Fri, 27 Nov 2026 17:50:03 +0100
Message-ID: <20261127165012.87004-1-tiwai@suse.de>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80

Kernels with CONFIG_EXTENDED_MODVERSIONS (which Rust support selects)
put the CRCs of all undefined symbols into the __version_ext_crcs and
__version_ext_names sections.  Symbols whose names don't fit into the
fixed size __versions entries (MODULE_NAME_LEN) appear only there,
hence most Rust of symbols are gone there.

Currently libkmod looked only at __versions, so it reported CRC 0 for
such symbols, and "depmod -e -E Module.symvers" printed false warnings
like:
  depmod: WARNING: .../rnull_mod.ko.zst disagrees about version of symbol _RNvXs0_NtCs8SrOILYbo5E_6kernel5errorNtB5_5ErrorNtNtCs7o82oapQthI_4core3fmt5Debug3fmt

Look up the extended tables when a symbol is not found in __versions.
Also clear SHF_ALLOC on the extended sections when the user forces
modversions, since the kernel prefers them over __versions when they
are present.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1290766
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 libkmod/libkmod-elf.c | 81 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/libkmod/libkmod-elf.c b/libkmod/libkmod-elf.c
index c13e11430d17..a56469c3dd74 100644
--- a/libkmod/libkmod-elf.c
+++ b/libkmod/libkmod-elf.c
@@ -33,6 +33,8 @@ enum kmod_elf_section {
 	KMOD_ELF_SECTION_SYMTAB,
 	KMOD_ELF_SECTION_VERSIONS,
 	KMOD_ELF_SECTION_BUILD_ID,
+	KMOD_ELF_SECTION_VERSION_EXT_CRCS,
+	KMOD_ELF_SECTION_VERSION_EXT_NAMES,
 	KMOD_ELF_SECTION_MAX,
 };
 
@@ -43,6 +45,8 @@ static const char *const section_name_map[] = {
 	[KMOD_ELF_SECTION_SYMTAB] = ".symtab",
 	[KMOD_ELF_SECTION_VERSIONS] = "__versions",
 	[KMOD_ELF_SECTION_BUILD_ID] = ".note.gnu.build-id",
+	[KMOD_ELF_SECTION_VERSION_EXT_CRCS] = "__version_ext_crcs",
+	[KMOD_ELF_SECTION_VERSION_EXT_NAMES] = "__version_ext_names",
 };
 
 struct kmod_elf {
@@ -581,12 +585,13 @@ int kmod_elf_get_modversions(const struct kmod_elf *elf, struct kmod_modversion
 	return count;
 }
 
-static int elf_strip_versions_section(const struct kmod_elf *elf, uint8_t *changed)
+static int elf_strip_section(const struct kmod_elf *elf, const char *section,
+			     uint8_t *changed)
 {
 	uint64_t off, size;
 	const void *buf;
 	/* the off and size values are not used, supply them as dummies */
-	int idx = kmod_elf_get_section(elf, "__versions", &off, &size);
+	int idx = kmod_elf_get_section(elf, section, &off, &size);
 	uint64_t val;
 
 	if (idx < 0)
@@ -608,6 +613,25 @@ static int elf_strip_versions_section(const struct kmod_elf *elf, uint8_t *chang
 	return elf_set_uint(elf, off, size, val, changed);
 }
 
+static int elf_strip_versions_section(const struct kmod_elf *elf, uint8_t *changed)
+{
+	static const char *const sections[] = {
+		"__versions",
+		"__version_ext_crcs",
+		"__version_ext_names",
+	};
+	size_t i;
+	int err;
+
+	for (i = 0; i < ARRAY_SIZE(sections); i++) {
+		err = elf_strip_section(elf, sections[i], changed);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static int elf_strip_vermagic(const struct kmod_elf *elf, uint8_t *changed)
 {
 	uint64_t i, sec_off, size;
@@ -955,6 +979,57 @@ static int kmod_elf_crc_find(const struct kmod_elf *elf, uint64_t off,
 	return -1;
 }
 
+/*
+ * Look up the CRC of a symbol in the extended modversions tables
+ * (__version_ext_crcs / __version_ext_names). Kernels built with
+ * CONFIG_EXTENDED_MODVERSIONS record all symbol CRCs there, including
+ * those whose names are too long for __versions, e.g. Rust symbols.
+ */
+static int kmod_elf_ext_crc_find(const struct kmod_elf *elf, const char *name,
+				 uint64_t *crc)
+{
+	uint64_t crc_off, crc_size, name_off, name_size, i, count;
+	const char *names;
+
+	crc_off = elf->sections[KMOD_ELF_SECTION_VERSION_EXT_CRCS].offset;
+	crc_size = elf->sections[KMOD_ELF_SECTION_VERSION_EXT_CRCS].size;
+	name_off = elf->sections[KMOD_ELF_SECTION_VERSION_EXT_NAMES].offset;
+	name_size = elf->sections[KMOD_ELF_SECTION_VERSION_EXT_NAMES].size;
+	if (crc_off == 0 || name_off == 0)
+		return -1;
+
+	if (crc_size % sizeof(uint32_t) != 0) {
+		ELFDBG(elf,
+		       "unexpected __version_ext_crcs of length %" PRIu64
+		       ", not multiple of %zu as expected.\n",
+		       crc_size, sizeof(uint32_t));
+		return -1;
+	}
+
+	count = crc_size / sizeof(uint32_t);
+	names = elf_get_mem(elf, name_off);
+
+	for (i = 0; i < count; i++) {
+		size_t len = strnlen(names, name_size);
+
+		if (len == name_size) {
+			ELFDBG(elf, "more extended version crcs than names\n");
+			return -1;
+		}
+
+		if (streq(name, names)) {
+			*crc = elf_get_uint(elf, crc_off + i * sizeof(uint32_t),
+					    sizeof(uint32_t));
+			return i;
+		}
+
+		names += len + 1;
+		name_size -= len + 1;
+	}
+
+	return -1;
+}
+
 /* from module-init-tools:elfops_core.c */
 #ifndef STT_REGISTER
 #define STT_REGISTER 13 /* Global register reserved to app. */
@@ -1107,6 +1182,8 @@ int kmod_elf_get_dependency_symbols(const struct kmod_elf *elf,
 		idx = kmod_elf_crc_find(elf, ver_off, versionslen, name, &crc);
 		if (idx >= 0 && visited_versions != NULL)
 			visited_versions[idx] = 1;
+		else if (idx < 0 && kmod_elf_ext_crc_find(elf, name, &crc) < 0)
+			crc = 0;
 		symcrcs[i] = crc;
 	}
 
-- 
2.53.0

