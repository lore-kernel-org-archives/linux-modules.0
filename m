Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C4446F4AA
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667461; cv=none; b=upcVncCsBzLngUpbaHLSOWbGjZTdxlJsyowCTLfmV8wT3w0Z390krJP0GRP3ZkgBbRQYNEyB2qmzfOfKP7ZMIMn8CSfQfzsvafa7ucc6dS1wAtVsXvnL5mF8c4BD8tWrRgBFOfOz8urQ7EbKTjE1ueREDSni1nO87rrVCQbG/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667461; c=relaxed/simple;
	bh=vCopXpS5A+0vqa65Xr7hPuZt6GKzyDjwpQ2PFX7VP+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t6i4VDVS2qpc2r6PwOUgGbCTiSWEPPLVnodFdTHw+r11AQBfVvxqqoHAwObQhYXNnR5bjFCnbR5OLxqvZbm5zkN47DsCX67CZZAppZ6zXqkIS+quPmrk5Tvp/A25VM6+LKJVoNRqgfZ+OhnHHrxLlnYRcXMdUMDr6iIh6RLhDRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+fIjx4f; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+fIjx4f"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7ec49608332so2723617a34.3
        for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 13:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667457; x=1785272257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GcxmLO0X4fD/rjCQxJy9THFKb1UhZCTTFFY7ow+im5M=;
        b=f+fIjx4fNCbxqAo/njsvDS0HcR+N2fx4Z9zBxbM6jvtvMv2REKjRRZWzVUlS90aCv6
         lOybUlUZ05uuUWT9bh2n2FNVmHwmB3Ji0lDopVQgGsMbngbb0Ohg9RszL9o+xv/lqOge
         CfIKQ3gkncMADaCZdSBD7Ge8Icp5C4zhmZjGfS1Wr24s03sCy/jjFFeEaX4EgFldTkQp
         7UCazSFxOncOaao/p8UTi9XBkQVnGqisG2qFnsRg5vtW/R4nxfRnpSgqqNQ/Bu0ZnYri
         2JTCXKjmS0KnKlJhwNzC02bv7j0jHmG7xaw8+yhXGTmUi6YgxpybWwWFBVcWDUcM+AsX
         7kRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667457; x=1785272257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GcxmLO0X4fD/rjCQxJy9THFKb1UhZCTTFFY7ow+im5M=;
        b=UeGeW4NVM8bpJpTxviXkNZUrmBeiN0sJCP0dPAd7yf4EKvWZ252nMtFOo3LPsiZzTS
         gmGSdwEV24BQg0bHjyYE4za88eNS2Iwl5ar0Zzda+kXLBfE3re/njkgZaK6xl1eosPJ0
         hwZ9yfb79s/Kj3i0SmtF+GWAm4dKE2upavjN8zvf803VqVsYqRk6RcU4vKOjSVW99tvR
         jhQia4Jw/SbKhqft/UvKqshiHRQ3cp9l23ayZCncgI0zlH3n6a3vONeoyEtzQSaV8tyX
         8QRHOaI2RcFQDxikE1lxuRnh5uweIEv/j+PaXllxTieOBiORNQGP3NM7vDnR3KF4djIn
         76Kw==
X-Forwarded-Encrypted: i=1; AHgh+RpATAlQvJgCTEH32IPyloFv6UPph0sr3Jc+aP1ndWhKMVKPhc06x6mLZDTSsIoG8c9Me46bl5JywxPVc//v@vger.kernel.org
X-Gm-Message-State: AOJu0YwrrPgvo8jcEq6yD86HaKbMoqlUDSnzz60Slg098T/XqsTLvvIo
	AppVI2OoglrgGyX+GFPshgmXSToS8O7E/1Vp2pe1wNTjEA573+dd1d48HMbgtw==
X-Gm-Gg: AfdE7cnVilQ0gjURLMgCcyiKfAnYS+ioHrTf2IbV1VTBhRA0pMWKPHExw4umEKcTSET
	fw+LpiAzIDZ+9xM7LfD00ow0M1iMAjdtw0s5tjMHGSEqSgDAxUKaQQyd52JuIpgHLfdCWHKRCpS
	v2bAkc/1F+6hLUf6urJu2PO0zANezvc+H7HT5JmhMnP5aFDsJ5AOMSVHhDZlHnsxBcsXqhKIy6n
	dwLvXF7yhKtIKAEMY/Ivlsu6fI05aBEBUTV8w1kM9GN5OG9l5WTCRtbX0iUMbkic+n4ywaZ1Hmw
	LfMZrVYIaG+ENhyW80pZAjsuRPgVrJ9Xt3Dxsc3x+qfBtWCagyJP8CsTYPCBaohxQBH2/okwMys
	qiuaOEVIeXqvS+qCIRB5vQ7AHkrsTIexe6RVE+BbFZYYtF7pcYUSgv5NmkFXMrOoF3YefFabHjH
	xbsViwh38+A4iTWbHnEjXy1VpmkZLlKdhLxago6JbHa5hk5Sg0ASi06KeEV9BxCNIEG/+dztgiV
	Sxg/oYbl49GQY9/X91zUYB3Sg==
X-Received: by 2002:a05:6830:64c8:b0:7e9:9e6d:2e2 with SMTP id 46e09a7af769-7eda09465c7mr9134654a34.20.1784667456701;
        Tue, 21 Jul 2026 13:57:36 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:36 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:10 -0600
Subject: [PATCH v7 21/29] dyndbg: tighten fn-sig of
 ddebug_apply_class_bitmap
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-21-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=2913;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=vCopXpS5A+0vqa65Xr7hPuZt6GKzyDjwpQ2PFX7VP+Q=;
 b=czh1EfKT5RalhVAtXzYlnQgEplQjMG6WdxIUWtEMin6k1ovGoPBlCCL0JHcEYTnSi3EjGomuo
 h7SvBRMagkHDcxuNUD21k8cPmwjlqwFtrohmn/pin09/8049fPMLTi3
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
index a619cefd801f..364a55fc9447 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -617,7 +617,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     unsigned long *new_bits, unsigned long *old_bits,
+				     const unsigned long *new_bits,
+				     const unsigned long old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -626,12 +627,12 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
@@ -643,9 +644,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
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
@@ -694,7 +695,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &inrep, dcp->bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
@@ -707,7 +708,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
-		totct += ddebug_apply_class_bitmap(dcp, &new_bits, &old_bits, mod_name);
+		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
 	default:

-- 
2.55.0

