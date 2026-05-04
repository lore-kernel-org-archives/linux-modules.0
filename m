Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594C2C21F1
	for <linux-modules@vger.kernel.org>; Mon,  4 May 2026 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927528; cv=none; b=jZuLh6ja0pwFTph6DRu5XTX7eAce2BA39K1FedXaY4zWaUwq7EL7yZ+CcDkllFe66l1t35x8SIhgyJmRi7wS3Een+22rQOvc/3aqmeSViEZHknMUEMKJ99Jkx2p1Gp7Fh6DK6NEkIj70hzmlhjwDoLpmFyWUvy8ZcJ3IQy8Xe04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927528; c=relaxed/simple;
	bh=zkMuUMxAz7gf7JYyOU3lHLF/bqxaOU2hcI/vPD8JKw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i84l1qKIovLKZZHkjsJmSQxj4Hve71ZDPHMA9X0L5qocGSYKtoHIq9aW0HCQFSFn1ysK7jecHCzndwLOOguS8cFO0KDvhDi+yOBTFreRrUGdpjkk6BdxTCv3H0YmpYmD1tyApMO3O0Y2GUThY3/b477yGt3nbT0agls3C/GeaYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqlYaeX8; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqlYaeX8"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6948da50eb5so2516457eaf.1
        for <linux-modules@vger.kernel.org>; Mon, 04 May 2026 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777927525; x=1778532325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iE84KguDxtU3r4Z7rVGRxTEhlyxeuDZeFizICZUAIgg=;
        b=nqlYaeX8YhoAPXzbprpB4PD3JeoqTVOzmng1ZPznOXP0fYPSERs5lr/Er4M0guD9d/
         K0gukdnAQ1i6zSx4CF9DiWMJiFRm9EZgYztMxxGemj6yB+e3IjdbSKsVxP/V1bI2Iibi
         f0HC87LqMynHS0elKxvypxXqp3boHQyDGbuH1Ju2ah0oY+AKhMoAuHv08GkftFkU13LK
         yeII3KdqPt0GU7hyTh6NNOo8pCX/AbwdNvuDa+M6sjVCDiLCBWbDFVgqZR3Pg+usP+nE
         fIfKd/6C6VKTARCieu73uu1315QUnvQzBO1Nwog9pTx9QdrgF7n8jSxnCI8ya+mVOD2g
         loDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777927525; x=1778532325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iE84KguDxtU3r4Z7rVGRxTEhlyxeuDZeFizICZUAIgg=;
        b=BhboNZ3kA2y+6cjTs3Di2Opsg1IGEsly2fGbnX3s48LdElp1vGJdDCl1DdhwFzMoyz
         ojI3vHcvNPaPL8QNYSchCMuffLVOL54Yl5Z0SeY9+JmBaUr0QT25zklVB0p0mdK2PWGt
         P/oGuGQ61Ec229okKfhxHokCxMSMyZs9RryCbSiQeehAWjqz5ArlUX4Grj3SZRId5X4D
         f0SqVgjsIstsVGKMgAxMzvp6tPUixia8LgW/pPhSVe2BwDnlRmMONzKFyDpOU0EUQlM/
         OdLrEuirkKSv1tPJXCZ6ebAsCYsf6+RDX0II4XxY2VFUOGgoJcXTlKMqljwM3iqA3xkn
         WBBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Ad1iN8oRx1Gbt0Me3IWaDYnsTGE+yL5Hxo7nOBSkonDDcp2MXTRJ4706kyocYGqhDl3rcd0+uyVeFuZPE@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8XHmDC+SIWr+LJyBlrZIAKBVMNK4JGh10Uc5XheGZZqEhaMK
	SmFoOEI+ih1vHNSztVde9qwKIOyM0krPWw0AHHifF5hNYEgB/Xeby7+h
X-Gm-Gg: AeBDiesupS8IOP1h/q4SDyw563nuGGx8Xpisbfjz2493M+71WM6zcfPs5j5MEo95sND
	ZsFYciGEwrxvon8gXpD/md9MI0wjolyCDyP9XiW/zQnW/yXjyEYNgXguMyPEjYAqvlOhnFm50uJ
	Jpil9AlmAUbxmrGarvg8dGd4MCX5K9dtHJfGtrUStFGp60DbBTVUtAx/ws+mIq74UVFckOSb6Nn
	DReZ1CkXxvkUV6x1Ez7Y/o0dn6a6UINjJe7Sphfdqo0Jx3wHMwku0CsRln4Ivnq0L0kumzz/GUZ
	oCafR4YON4BqOzy/GEqUS19ssMrr8r76tGbcefXuLzSlwGW5iAj4Lb128+zsl9hqjDb051LmZlR
	QhoqB+T5s231mlDAgLed/ceHh+oKLtxsNhlHe8LvTlubQhCsfD0jjxm73JatXllnJILzlY/7gLf
	MmWMhbtezAimsIwxVzz7jSQCoMrjfKoqFRF8fnsndRa+YJny5J8gzZsRBCzrkxUP6aKZLAz53Mw
	OHSWbXx1n4=
X-Received: by 2002:a05:6820:986:b0:696:834d:cd2e with SMTP id 006d021491bc7-69887856304mr542025eaf.13.1777927525265;
        Mon, 04 May 2026 13:45:25 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69689266bacsm7144713eaf.0.2026.05.04.13.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:45:24 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 04 May 2026 14:45:13 -0600
Subject: [PATCH 07/17] dyndbg: reduce verbose/debug clutter
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-dd-cleanups-2-v1-7-6fdd24040642@gmail.com>
References: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com>
In-Reply-To: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Shuah Khan <shuah@kernel.org>, Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777927513; l=3911;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=zkMuUMxAz7gf7JYyOU3lHLF/bqxaOU2hcI/vPD8JKw4=;
 b=N08w0NZjKOPBxYI7XWMCIprrfEn4owD0mqol02b9KoQtV4xF8Q+V0YddX+kNNfiXcLe+31OnA
 bXo02Mx3e+fBrqiMDjegNNn89nK4f3keRMD9458yjafujflMK3Q60zf
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

currently, for verbose=3, these are logged (blank lines for clarity):

 dyndbg: query 0: "class DRM_UT_CORE +p" mod:*
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"

 dyndbg: op='+'
 dyndbg: flags=0x1
 dyndbg: *flagsp=0x1 *maskp=0xffffffff

 dyndbg: parsed: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: no matches for query
 dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: processed 1 queries, with 0 matches, 0 errs

That is excessive, so this patch:
 - shrinks 3 lines of 2nd stanza to single line
 - drops 1st 2 lines of 3rd stanza
   3rd line is like 1st, with result, not procedure.
   2nd line is just status, retold in 4th, with more info.

New output:

 dyndbg: query 0: "class DRM_UT_CORE +p" mod:*
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"
 dyndbg: op='+' flags=0x1 *flagsp=0x1 *maskp=0xffffffff
 dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: processed 1 queries, with 0 matches, 0 errs

Also reduce verbose=3 messages in ddebug_add_module

When modprobing a module, dyndbg currently logs/says "add-module", and
then "skipping" if the module has no prdbgs.  Instead just check 1st
and return quietly.

no functional change

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9575b92a8deb..3ae9ecabdad1 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -276,9 +276,6 @@ static int ddebug_change(const struct ddebug_query *query,
 	}
 	mutex_unlock(&ddebug_lock);
 
-	if (!nfound && verbose)
-		pr_info("no matches for query\n");
-
 	return nfound;
 }
 
@@ -511,7 +508,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -525,7 +521,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -541,7 +536,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("op='%c' flags=0x%x maskp=0x%x\n", op, modifiers->flags, modifiers->mask);
 
 	return 0;
 }
@@ -551,7 +546,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	struct flag_settings modifiers = {};
 	struct ddebug_query query = {};
 #define MAXWORDS 9
-	int nwords, nfound;
+	int nwords;
 	char *words[MAXWORDS];
 
 	nwords = ddebug_tokenize(query_string, words, MAXWORDS);
@@ -569,10 +564,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, &modifiers);
-	vpr_info_dq(&query, nfound ? "applied" : "no-match");
-
-	return nfound;
+	return ddebug_change(&query, &modifiers);
 }
 
 /* handle multiple queries in query string, continue on error, return
@@ -1246,11 +1238,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
-	v3pr_info("add-module: %s.%d sites\n", modname, di->num_descs);
-	if (!di->num_descs) {
-		v3pr_info(" skip %s\n", modname);
+	if (!di->num_descs)
 		return 0;
-	}
+
+	v3pr_info("add-module: %s %d sites\n", modname, di->num_descs);
 
 	dt = kzalloc_obj(*dt);
 	if (dt == NULL) {

-- 
2.54.0

