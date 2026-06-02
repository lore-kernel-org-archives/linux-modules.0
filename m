Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF33D16F5
	for <linux-modules@vger.kernel.org>; Tue,  2 Jun 2026 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440537; cv=none; b=IXsuUddxGDFSrje7uFpL5rmTQve1Mv2h0vF4/YeQ8Lc5LruMhqz7KIaUobCz7wlLobxPGGaZhrwa3Rcn4huqQqVBBmCSj1strNJwe1RBt0VHj51ihmp6rBZlQGNJW6OhwPvhuYcqe1tD7/9z6QSLQ641PGbtAjCljfeWsbLHrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440537; c=relaxed/simple;
	bh=yYzaloSWpMCcf2mBssnDdUdry2Mk3lsvbkKFQrUnGj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q/LF8bb9XF8bEI3RW4vgygXUxOHpCYFvT43hHD/6pxGmNQXVZ3H1KojaV0blFE1rMezFmghaKCMoOR+tLBJjISqBEmYjVZplgBwpCl4iW1KALUei289VYdd7UlSF/3ifp9tSddC+lMdDsrou0hY6fyBjMErBK7nOghkqRVoAwcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeNw9xGU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeNw9xGU"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490a7629380so30544585e9.0
        for <linux-modules@vger.kernel.org>; Tue, 02 Jun 2026 15:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440533; x=1781045333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kG9RuYZKN9VVlKwBSxHqXl1ePoc3WUv6h82ZqRPI728=;
        b=PeNw9xGUL2XyNCjvqegIbAhZqrlthhSS6z4FVxzhvOYvaj5VpZJDySA65FEcDnEZSS
         dWLQ2bg2mF9FaBi74z5st0uYEUQMp5c/kR7rxCZrrPbb0Ugz/0vRhJpQ/7fu8pDWZM5k
         GZndyK6k4eDcQlA2uhEXxnnzvLDvVBBQdhHNgQtiwLGWaSPxysxyhLDD70CFPHlGBBr3
         tBqJFlBBGzVFUWaGn22fIu3Hpt1tNlxrBmAVDfpRLdvH8csfa37in1R45K6aUwHfBX1N
         jB7AcKDCXX6RsW1VIgUR/vXAnVzEyZHDhqrxos0aXY8sI7muWX/3i04otTgdac1HvHjh
         tU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440533; x=1781045333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kG9RuYZKN9VVlKwBSxHqXl1ePoc3WUv6h82ZqRPI728=;
        b=V/pWNVl9A5ot7NzY10Mijh0yu2a75Ik5YPf95+r6zFdBtlrDZsVHsIbIAJk783ciLx
         zQ56Gdd3qAVAJM6DI6YubII50BfnVXRmM3HRh49fQcooqXXo3gzRxwqtqz7xrJ2zyZ/m
         lKvekTbaqWhXpJblYKorkRKJxWEZ/VjmfLrxo3pKqpU39jt36ASEOaamliVIFa/yejBA
         peNp9WG9fGigW0n8Riav44xY+7Ce4p8uZYGTMY5g86za6geai3RvLaoYHOSEP7IpEGi3
         PR1QnH8rQU0Cmp4X424tbN2Z8CtDa1XnMmrC/8i5E5vfsxNNgSBBjfw4JTE2LB5R74W3
         MH9A==
X-Forwarded-Encrypted: i=1; AFNElJ/VZorgjyHHHFLJE709L/bG8udkJ2QMtA+oFgtNwVqsxyZLs5bRxlZ0uRTgIGdpL4A6Pw4XlvvGmvPebxAe@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+2lvXPeLmS5fSa32TExtE6tDX8KIBf1ffJjpDZXkG0kQL/3A
	Fer4ioHPiCl0ZnClaeDWVCECVWecrUpyJLdovLijduOfsu5Zr2hlrHsG
X-Gm-Gg: Acq92OHS1GtsaD/RDJPw7dM3dHsDyqWOseD14Zaf7MA+ySLHVvX8TE+d78p91nObvUl
	nVdHtY7S3RcV4TW9JTcVdVJ+/cqYOkUkFfg/j3MMQV1RHMFX26N+QVtOFYW/Itm4nxhZmIoqjJe
	gcmvnsR2QsGrQJ+lFl7gH+zHNjX9tYB5VRmra22QXQTEv8bh3pB+85fRsMpKTH4xuIkWigK3qTg
	7UMzNsOHpPJaxo9FU5rEXkcVIGkbM2qvSQJ5gsjzNGZIcYB/ClnyIu9nC1iuZuZ57Wmha0+U7oi
	KFh5UWX4Zn16OTZf9wEx7dPaZL8liQT0mtA4syHhmEu4KnFwh28gtttdaaAMMKO5Ft/Jqmi+Uh8
	IkVlz+5US6iYDnQlVIHgbH62L8AsRlZ7ShaTY+db6E1434vutsPq8cXM9pdHBDpLmcbTJv99sW/
	0sFLgCEUdJ8dE1VEGfZj2+XUOlA9sE3YAm80kFe3oG0A==
X-Received: by 2002:a05:600c:1c1e:b0:490:b00c:8e6a with SMTP id 5b1f17b1804b1-490b5fe65a6mr12193215e9.28.1780440533361;
        Tue, 02 Jun 2026 15:48:53 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:48:51 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:12 +0000
Subject: [PATCH v4 15/25] dyndbg: tighten fn-sig of
 ddebug_apply_class_bitmap
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-15-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=2913;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=yYzaloSWpMCcf2mBssnDdUdry2Mk3lsvbkKFQrUnGj8=;
 b=jjLEoXkJF9i9OhldBjaZjELUHRX0zlhmfVnIaKMKki+R8Pk2d8dPgzTVoDEdjIo3+QfsdvfLR
 ByeKIgUGjr4CkUVmBBRNr6e+BZVeYA+GMu2Kfz6YrJtQGL+T8veBJhe
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

old_bits arg is currently a pointer to the input bits, but this could
allow inadvertent changes to the input by the fn.  Disallow this.
And constify new_bits while here.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: move RvB after SoB
---
 lib/dynamic_debug.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f59fe7b25ea9..9bd521651c48 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -612,7 +612,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits,
+				     const unsigned long *new_bits,
+				     const unsigned long old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -621,12 +622,12 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
-		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
+		if (test_bit(bi, new_bits) == test_bit(bi, &old_bits))
 			continue;
 
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
@@ -638,9 +639,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
-	if (*new_bits != *old_bits)
+	if (*new_bits != old_bits)
 		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
-			  *old_bits, query_modname ?: "'*'");
+			  old_bits, query_modname ?: "'*'");
 
 	return matches;
 }
@@ -688,7 +689,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -701,7 +702,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
 	default:

-- 
2.54.0

