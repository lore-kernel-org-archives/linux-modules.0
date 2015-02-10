Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:54209 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbbBJSqo (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Tue, 10 Feb 2015 13:46:44 -0500
Received: from localhost ([79.227.2.18]) by mrelayeu.kundenserver.de
 (mreue101) with ESMTPSA (Nemesis) id 0MbhXp-1Y4y2B2CPN-00IzC7 for
 <linux-modules@vger.kernel.org>; Tue, 10 Feb 2015 19:46:42 +0100
Date: Tue, 10 Feb 2015 19:46:40 +0100
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: linux-modules@vger.kernel.org
Subject: [PATCH] libkmod: properly validate file size
Message-ID: <20150210184640.GA25175@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi,

in function kmod_elf_new, the file size has to be properly validated against
section offset. Currently, the file size is considered valid based on
ELF header size + section header size * section count. That is not sufficient.

In fact, ELF specifies a section header offset, which doesn't have to be the
size of the ELF header. The supplied test cases even cover this.

The correct test is: section offset + section header size * section count

This patch also verifies that this value won't overflow.  I don't know a way
to crash a tool due to this bug, because later on the offset check would
prevent out-of-bounds access. An overflow would just mean to access a wrong
part in elf->memory. Yet it's a validation error.

Please note: The file size does not have to be validated against the size
of the ELF header again, elf_identify did this already.


Tobias
---
 libkmod/libkmod-elf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/libkmod/libkmod-elf.c b/libkmod/libkmod-elf.c
index 4af829e..2f50ad2 100644
--- a/libkmod/libkmod-elf.c
+++ b/libkmod/libkmod-elf.c
@@ -272,7 +272,8 @@ static const char *elf_get_strings_section(const struct kmod_elf *elf, uint64_t
 struct kmod_elf *kmod_elf_new(const void *memory, off_t size)
 {
 	struct kmod_elf *elf;
-	size_t hdr_size, shdr_size, min_size;
+	uint64_t min_size;
+	size_t shdrs_size, shdr_size;
 	int class;
 
 	assert_cc(sizeof(uint16_t) == sizeof(Elf32_Half));
@@ -308,12 +309,10 @@ struct kmod_elf *kmod_elf_new(const void *memory, off_t size)
 	if (elf->class & KMOD_ELF_32) {
 		const Elf32_Ehdr *hdr _unused_ = elf_get_mem(elf, 0);
 		LOAD_HEADER;
-		hdr_size = sizeof(Elf32_Ehdr);
 		shdr_size = sizeof(Elf32_Shdr);
 	} else {
 		const Elf64_Ehdr *hdr _unused_ = elf_get_mem(elf, 0);
 		LOAD_HEADER;
-		hdr_size = sizeof(Elf64_Ehdr);
 		shdr_size = sizeof(Elf64_Shdr);
 	}
 #undef LOAD_HEADER
@@ -330,8 +329,9 @@ struct kmod_elf *kmod_elf_new(const void *memory, off_t size)
 		       elf->header.section.entry_size, shdr_size);
 		goto invalid;
 	}
-	min_size = hdr_size + shdr_size * elf->header.section.count;
-	if (min_size >= elf->size) {
+	shdrs_size = shdr_size * elf->header.section.count;
+	if (addu64_overflow(shdrs_size, elf->header.section.offset, &min_size)
+	    || min_size > elf->size) {
 		ELFDBG(elf, "file is too short to hold sections\n");
 		goto invalid;
 	}
-- 
2.3.0

