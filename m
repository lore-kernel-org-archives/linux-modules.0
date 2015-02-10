Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:63004 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbbBJTiI (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Tue, 10 Feb 2015 14:38:08 -0500
Received: from localhost ([79.227.2.18]) by mrelayeu.kundenserver.de
 (mreue103) with ESMTPSA (Nemesis) id 0MKt72-1YLGdI3zCy-0004Ug for
 <linux-modules@vger.kernel.org>; Tue, 10 Feb 2015 20:38:05 +0100
Date: Tue, 10 Feb 2015 20:38:03 +0100
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: linux-modules@vger.kernel.org
Subject: [PATCH] libkmod: check size in elf_get_mem
Message-ID: <20150210193803.GA11559@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi,

the function elf_get_mem properly checks if offset is smaller than elf->size,
but does not perform further memory size validations.

Supply desired size as third argument to elf_get_mem, which is in sync
with elf_get_uint/elf_set_uint then.

As you can see, further unbounded string operations like strlen are still
prone to lead to out-of-bounds access, which will be covered in another patch.


Tobias
---
 libkmod/libkmod-elf.c | 52 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/libkmod/libkmod-elf.c b/libkmod/libkmod-elf.c
index 2f50ad2..85ba681 100644
--- a/libkmod/libkmod-elf.c
+++ b/libkmod/libkmod-elf.c
@@ -197,12 +197,15 @@ static inline int elf_set_uint(struct kmod_elf *elf, uint64_t offset, uint64_t s
 	return 0;
 }
 
-static inline const void *elf_get_mem(const struct kmod_elf *elf, uint64_t offset)
+static inline const void *elf_get_mem(const struct kmod_elf *elf, uint64_t offset, uint64_t size)
 {
-	assert(offset < elf->size);
-	if (offset >= elf->size) {
-		ELFDBG(elf, "out-of-bounds: %"PRIu64" >= %"PRIu64" (ELF size)\n",
-		       offset, elf->size);
+	uint64_t end;
+
+	assert(!addu64_overflow(offset, size, &end));
+	assert(end <= elf->size);
+	if (addu64_overflow(offset, size, &end) || end > elf->size) {
+		ELFDBG(elf, "out-of-bounds: %"PRIu64" + %"PRIu64" > %"PRIu64" (ELF size)\n",
+		       offset, size, elf->size);
 		return NULL;
 	}
 	return elf->memory + offset;
@@ -218,7 +221,8 @@ static inline const void *elf_get_section_header(const struct kmod_elf *elf, uin
 		return NULL;
 	}
 	return elf_get_mem(elf, elf->header.section.offset +
-			   idx * elf->header.section.entry_size);
+			   idx * elf->header.section.entry_size,
+			   elf->header.section.entry_size);
 }
 
 static inline int elf_get_section_info(const struct kmod_elf *elf, uint16_t idx, uint64_t *offset, uint64_t *size, uint32_t *nameoff)
@@ -266,7 +270,8 @@ static inline int elf_get_section_info(const struct kmod_elf *elf, uint16_t idx,
 static const char *elf_get_strings_section(const struct kmod_elf *elf, uint64_t *size)
 {
 	*size = elf->header.strings.size;
-	return elf_get_mem(elf, elf->header.strings.offset);
+	return elf_get_mem(elf, elf->header.strings.offset,
+			   elf->header.strings.size);
 }
 
 struct kmod_elf *kmod_elf_new(const void *memory, off_t size)
@@ -307,11 +312,13 @@ struct kmod_elf *kmod_elf_new(const void *memory, off_t size)
 	elf->header.strings.section = READV(e_shstrndx);	\
 	elf->header.machine = READV(e_machine)
 	if (elf->class & KMOD_ELF_32) {
-		const Elf32_Ehdr *hdr _unused_ = elf_get_mem(elf, 0);
+		size_t hdr_size = sizeof(Elf32_Ehdr);
+		const Elf32_Ehdr *hdr _unused_ = elf_get_mem(elf, 0, hdr_size);
 		LOAD_HEADER;
 		shdr_size = sizeof(Elf32_Shdr);
 	} else {
-		const Elf64_Ehdr *hdr _unused_ = elf_get_mem(elf, 0);
+		size_t hdr_size = sizeof(Elf64_Ehdr);
+		const Elf64_Ehdr *hdr _unused_ = elf_get_mem(elf, 0, hdr_size);
 		LOAD_HEADER;
 		shdr_size = sizeof(Elf64_Shdr);
 	}
@@ -417,7 +424,7 @@ int kmod_elf_get_section(const struct kmod_elf *elf, const char *section, const
 		if (!streq(section, n))
 			continue;
 
-		*buf = elf_get_mem(elf, off);
+		*buf = elf_get_mem(elf, off, size);
 		*buf_size = size;
 		return 0;
 	}
@@ -534,7 +541,8 @@ int kmod_elf_get_modversions(const struct kmod_elf *elf, struct kmod_modversion
 	slen = 0;
 
 	for (i = 0; i < count; i++, off += MODVERSION_SEC_SIZE) {
-		const char *symbol = elf_get_mem(elf, off + offcrc);
+		const char *symbol = elf_get_mem(elf, off + offcrc,
+						 size - offcrc);
 
 		if (symbol[0] == '.')
 			symbol++;
@@ -551,7 +559,8 @@ int kmod_elf_get_modversions(const struct kmod_elf *elf, struct kmod_modversion
 
 	for (i = 0; i < count; i++, off += MODVERSION_SEC_SIZE) {
 		uint64_t crc = elf_get_uint(elf, off, offcrc);
-		const char *symbol = elf_get_mem(elf, off + offcrc);
+		const char *symbol = elf_get_mem(elf, off + offcrc,
+						 size - offcrc);
 		size_t symbollen;
 
 		if (symbol[0] == '.')
@@ -806,7 +815,8 @@ int kmod_elf_get_symbols(const struct kmod_elf *elf, struct kmod_modversion **ar
 			goto fallback;
 		}
 
-		name = elf_get_mem(elf, str_off + name_off);
+		name = elf_get_mem(elf, str_off + name_off,
+				   strtablen - name_off);
 
 		if (strncmp(name, crc_str, crc_strlen) != 0)
 			continue;
@@ -846,7 +856,8 @@ int kmod_elf_get_symbols(const struct kmod_elf *elf, struct kmod_modversion **ar
 			info = READV(st_info);
 		}
 #undef READV
-		name = elf_get_mem(elf, str_off + name_off);
+		name = elf_get_mem(elf, str_off + name_off,
+				   strtablen - name_off);
 		if (strncmp(name, crc_str, crc_strlen) != 0)
 			continue;
 		name += crc_strlen;
@@ -889,7 +900,8 @@ static int kmod_elf_crc_find(const struct kmod_elf *elf, const void *versions, u
 
 	off = (const uint8_t *)versions - elf->memory;
 	for (i = 0; i < versionslen; i += verlen) {
-		const char *symbol = elf_get_mem(elf, off + i + crclen);
+		const char *symbol = elf_get_mem(elf, off + i + crclen,
+						 versionslen - i - crclen);
 		if (!streq(name, symbol))
 			continue;
 		*crc = elf_get_uint(elf, off + i, crclen);
@@ -1038,7 +1050,8 @@ int kmod_elf_get_dependency_symbols(const struct kmod_elf *elf, struct kmod_modv
 			return -EINVAL;
 		}
 
-		name = elf_get_mem(elf, str_off + name_off);
+		name = elf_get_mem(elf, str_off + name_off,
+				   strtablen - name_off);
 		if (name[0] == '\0') {
 			ELFDBG(elf, "empty symbol name at index %"PRIu64"\n", i);
 			continue;
@@ -1059,7 +1072,7 @@ int kmod_elf_get_dependency_symbols(const struct kmod_elf *elf, struct kmod_modv
 		for (i = 0; i < vercount; i++) {
 			if (visited_versions[i] == 0) {
 				const char *name;
-				name = elf_get_mem(elf, ver_off + i * verlen + crclen);
+				name = elf_get_mem(elf, ver_off + i * verlen + crclen, verlen);
 				slen += strlen(name) + 1;
 
 				count++;
@@ -1126,7 +1139,8 @@ int kmod_elf_get_dependency_symbols(const struct kmod_elf *elf, struct kmod_modv
 				continue;
 		}
 
-		name = elf_get_mem(elf, str_off + name_off);
+		name = elf_get_mem(elf, str_off + name_off,
+				   strtablen - name_off);
 		if (name[0] == '\0') {
 			ELFDBG(elf, "empty symbol name at index %"PRIu64"\n", i);
 			continue;
@@ -1168,7 +1182,7 @@ int kmod_elf_get_dependency_symbols(const struct kmod_elf *elf, struct kmod_modv
 		if (visited_versions[i] != 0)
 			continue;
 
-		name = elf_get_mem(elf, ver_off + i * verlen + crclen);
+		name = elf_get_mem(elf, ver_off + i * verlen + crclen, verlen);
 		slen = strlen(name);
 		crc = elf_get_uint(elf, ver_off + i * verlen, crclen);
 
-- 
2.3.0

