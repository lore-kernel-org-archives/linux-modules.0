Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751297AbcKIGvc (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 9 Nov 2016 01:51:32 -0500
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
        Jessica Yu <jeyu@redhat.com>
Subject: [PATCH] shared: make scratchbuf_str static
Date: Wed,  9 Nov 2016 08:52:26 +0200
Message-Id: <1478674346-29996-1-git-send-email-yauheni.kaliuta@redhat.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

It fixes linking problem

tools/depmod.o: In function `output_symbols_bin':
depmod.c:(.text.output_symbols_bin+0x135): undefined reference to `scratchbuf_str'

for -O0 build, where gcc doesn't actually inline it.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 shared/scratchbuf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/shared/scratchbuf.h b/shared/scratchbuf.h
index c12e4902528f..27ea9d9f6008 100644
--- a/shared/scratchbuf.h
+++ b/shared/scratchbuf.h
@@ -19,7 +19,7 @@ int scratchbuf_alloc(struct scratchbuf *buf, size_t sz);
 void scratchbuf_release(struct scratchbuf *buf);
 
 /* Return a C string */
-inline char *scratchbuf_str(struct scratchbuf *buf)
+static inline char *scratchbuf_str(struct scratchbuf *buf)
 {
 	return buf->bytes;
 }
-- 
2.7.4

