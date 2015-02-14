Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:52074 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312AbbBNXfo (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Sat, 14 Feb 2015 18:35:44 -0500
Received: from localhost ([79.227.30.210]) by mrelayeu.kundenserver.de
 (mreue001) with ESMTPSA (Nemesis) id 0MJb0l-1YJjyX0lQ3-0032eg for
 <linux-modules@vger.kernel.org>; Sun, 15 Feb 2015 00:35:42 +0100
Date: Sun, 15 Feb 2015 00:35:47 +0100
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: linux-modules@vger.kernel.org
Subject: [PATCH] Out of bounds signature access with 32 bit off_t
Message-ID: <20150214233547.GB7778@localhost>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Yylu36WmvOXNoKYn"
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

if kmod has been configured with --disable-largefile on a 32 bit
system, off_t will be 32 bit. In that case, the parsed sig_len can
bypass a validation check (it's _unsigned_ 32 bit), allowing a
an attacker to perform out of boundary access through a malicious module.

Due to the unlikeliness of people using --disable-largefile, this is
a mere validation fix. With an explicit signed 64 bit cast, there is
no binary change for 99.9% of Linux systems out there. ;)

Attached please find a proof of concept, which will most likely result in
a segmentation fault (works fine with 64 bit off_t builds):

tobias:~$ modinfo 32sig.ko
filename:       /home/tobias/32sig.ko
Segmentation fault


Tobias
---
 libkmod/libkmod-signature.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
index 5ed5973..bced8ab 100644
--- a/libkmod/libkmod-signature.c
+++ b/libkmod/libkmod-signature.c
@@ -124,7 +124,7 @@ bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signat
 			modsig->id_type >= PKEY_ID_TYPE__LAST)
 		return false;
 	sig_len = be32toh(get_unaligned(&modsig->sig_len));
-	if (size < (off_t)(modsig->signer_len + modsig->key_id_len + sig_len))
+	if (size < (int64_t)(modsig->signer_len + modsig->key_id_len + sig_len))
 		return false;
 
 	size -= modsig->key_id_len + sig_len;
-- 
2.3.0


--Yylu36WmvOXNoKYn
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="32sig.ko"
Content-Transfer-Encoding: base64

f0VMRgIBAAAAAAAAAAAAAAAubW9kaW5mbwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAEAAAwABAAAAAAAiIiIiMzMzMzMzMzNERERERERERBAAAAAAAAAADwAAAAAAAAB3d3d3
iIiIiJmZmZmZmZmZqqqqqqqqqqoBAAAAIiIiIjMzMzMzMzMzRERERERERETAAAAAAAAAAA0A
AAAAAAAAd3d3d4iIiIiZmZmZmZmZmaqqqqqqqqqqdmVybWFnaWM9aGVsbG8AAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAGEAYQAAAAACAgAAAP8AAAB+TW9kdWxlIHNpZ25hdHVy
ZSBhcHBlbmRlZH4K

--Yylu36WmvOXNoKYn--
