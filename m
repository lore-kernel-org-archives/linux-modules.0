Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:61065 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbbBIWWw (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 9 Feb 2015 17:22:52 -0500
Received: from localhost ([79.227.10.233]) by mrelayeu.kundenserver.de
 (mreue101) with ESMTPSA (Nemesis) id 0MYNd3-1Y7UKp1FkP-00V7KY for
 <linux-modules@vger.kernel.org>; Mon, 09 Feb 2015 23:22:50 +0100
Date: Mon, 9 Feb 2015 23:22:51 +0100
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: linux-modules@vger.kernel.org
Subject: [PATCH] Prevent offset + size overflow.
Message-ID: <20150209222251.GA22303@localhost>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

it is possible to overflow uint64_t by summing variables offset and
size up in elf_get_section_info. Thee values are extracted from module
file and are possibly maliciously tampered with.

If offset is in valid range and size very large, the result will
overflow and the size check passes. Later on, this will most likely
lead to a segmentation fault due to accessing uninitialized memory.

Attached please find a proof of concept module, which will trigger
a segmentation fault on modinfo. Tested on amd64:

tobias:~$ modinfo poc.ko
filename:       /home/tobias/poc.ko
Segmentation fault


Tobias

PS: There are more errors of this type in the ELF handling code, so let
    me know if you are okay with the additional check in the if-block.
    I will send patches like this one for the other occurrences then.
---
 libkmod/libkmod-elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libkmod/libkmod-elf.c b/libkmod/libkmod-elf.c
index d1b0f33..8a8a73d 100644
--- a/libkmod/libkmod-elf.c
+++ b/libkmod/libkmod-elf.c
@@ -251,7 +251,7 @@ static inline int elf_get_section_info(const struct kmod_elf *elf, uint16_t idx,
 #undef READV
 
 	min_size = *offset + *size;
-	if (min_size > elf->size) {
+	if (ULLONG_MAX - *offset < *size || min_size > elf->size) {
 		ELFDBG(elf, "out-of-bounds: %"PRIu64" >= %"PRIu64" (ELF size)\n",
 		       min_size, elf->size);
 		return -EINVAL;
-- 
2.3.0


--uAKRQypu60I7Lcqm
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="poc.ko"
Content-Transfer-Encoding: base64

f0VMRgIBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAEAAAgABAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJAAAAAAAAAA//////////8AAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC5tb2RpbmZvAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==

--uAKRQypu60I7Lcqm--
