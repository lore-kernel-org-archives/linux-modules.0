Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:56407 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbbBNXet (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Sat, 14 Feb 2015 18:34:49 -0500
Received: from localhost ([79.227.30.210]) by mrelayeu.kundenserver.de
 (mreue002) with ESMTPSA (Nemesis) id 0M48SR-1XUwh21Sp1-00rrGa for
 <linux-modules@vger.kernel.org>; Sun, 15 Feb 2015 00:34:47 +0100
Date: Sun, 15 Feb 2015 00:34:53 +0100
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: linux-modules@vger.kernel.org
Subject: [PATCH] Fix segmentation fault on empty signature key
Message-ID: <20150214233452.GA7778@localhost>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

a segmentation fault occurs if a module has an empty key attached to
its signature.

This happens because it's assumed that at least one key byte is
available, subtracting it in libkmod-module line 2249.  This -1 value
is casted to an unsigned data type later on, resulting in illegal
memory access.

Attached please find a proof of concept module, tested on amd64:

tobias:~$ modinfo 0sig.ko
filename:       /home/tobias/0sig.ko
Segmentation fault

Tobias
---
 libkmod/libkmod-module.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 30f15ca..ca703a7 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2246,7 +2246,8 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
 				key_hex[i * 3 + 2] = ':';
 		}
 		n = kmod_module_info_append(list, "sig_key", strlen("sig_key"),
-				key_hex, sig_info.key_id_len * 3 - 1);
+				key_hex, sig_info.key_id_len == 0 ? 0 :
+				sig_info.key_id_len * 3 - 1);
 		free(key_hex);
 		if (n == NULL)
 			goto list_error;
-- 
2.3.0


--Dxnq1zWXvFF0Q93v
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="0sig.ko"
Content-Transfer-Encoding: base64

f0VMRgIBAAAAAAAAAAAAAAAubW9kaW5mbwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAEAAAwABAAAAAAAiIiIiMzMzMzMzMzNERERERERERBAAAAAAAAAADwAAAAAAAAB3d3d3
iIiIiJmZmZmZmZmZqqqqqqqqqqoBAAAAIiIiIjMzMzMzMzMzRERERERERETAAAAAAAAAAA0A
AAAAAAAAd3d3d4iIiIiZmZmZmZmZmaqqqqqqqqqqdmVybWFnaWM9aGVsbG8AAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB+TW9kdWxlIHNpZ25hdHVy
ZSBhcHBlbmRlZH4K

--Dxnq1zWXvFF0Q93v--
