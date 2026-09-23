Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4070258B6CA
	for <linux-modules@vger.kernel.org>; Wed, 23 Sep 2026 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202925; cv=none; b=HesefioU5T4gBWVJqdTyJPzKGPPWgcYk0j2UTKXchyx7gguMam2H7PQZg1Ph+07gtp4KOmenVF2y8Zz3GmZ37PMpEQuzr57Xdr5ru1WVD5r/KQq5S+JbH/f31CxpjB7Mt83/fWnud0HIHa3jBAY13m8X1INjqDfzBGRflwqRqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202925; c=relaxed/simple;
	bh=zCwr+VGqKnNAOkzayghTBT7W0F9XwKbxJ4/xtvRrwII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pbs+q5AGsqbyzUPBOvyGviOk/DESNAX0qJ5cheWnIs/FQ6BPDM7U3WfqKjjccUVIegZSHSPu6oAXowkTFajIKYoMQcuDSwidZMUZyGUVISbBO+JAv+869dnAJ/1nV8f5Frckm9M66YY31BUoKkLmkPPKbP3qVXa3R+6WafAOk0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzja11FM; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzja11FM"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c6d6660191so1001210b6e.2
        for <linux-modules@vger.kernel.org>; Wed, 23 Sep 2026 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202920; x=1790807720; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zfwGwbUwBRuvPTUiKX1AIC4L/SKKbUUkwfFbVYVud+k=;
        b=nzja11FMb/s4BNpfi7CK/AvhmbHstDDYJKUhXQfnGZS8AblwgppnFMuZolhLkW4/DU
         A6bHAmkIXYx8Ovj8ZO5dU5sCL5+MAzfLwRTYdXKferqxJBzV+5m9WHU2fO/Vh+jbDlmZ
         LROZ+1eGKV5LA5KfbtSrSEZ4W3Qe+KqxpyRjss0m18AMAXDdd0niqpIle8L9bCU5wIXt
         fqkWECLtaJ5AZ27aG5OF3W6/mW4FIRG1qFr9H9ldmJBQslzztYHuaj28vtO9rc54A5NY
         3ZvbUuJcaXNg6tXtzwFxjlECYiuECs5JWG9mr6cmuZ6OAjvRW+rkMc6gjicBDF2vs91i
         ojOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202920; x=1790807720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zfwGwbUwBRuvPTUiKX1AIC4L/SKKbUUkwfFbVYVud+k=;
        b=zkiX7eWb5ogjCiLTIrKa/3W68f9NUbryhei8TcQMEZiHBjtK/pw8nHKMsgq8qQSVwA
         4BpMPawcVwoWhxGkYgkXMcmrwseMaOl91cWjU51w0zYucr7WLsJD8URBEIveB9ccA79F
         YKtU2GRLe3Y6QdMKFVL5OIm4B1xB434H7C+er/PaJ6pouFJ482QdrU2tnMsMNzky88d9
         fruRBKKlkvsw2UxIb9Cr4jVapuILyROyWqKe40zaNu10zIUfZlY3ITJHVpOcxhCl05hQ
         qEz0KaV4PDV6aHemYr6c6sLqNxOeQk/jthDZ7R+SkZ9kzpKUJPiP5tgpi9Ad09atC3nN
         6CxA==
X-Forwarded-Encrypted: i=1; AKwUvBzokMjfI5r9QJjkBRBUfBwuHwk8eoPEJLO8i4rVl9Kgg++HbaFQEUkXhcQS/N7/pcSE02OdcKO6vmfj6rNC@vger.kernel.org
X-Gm-Message-State: AFuF++lFFMhpBDzuO7M6tG9wKZVIJAUm1OtkAUXwFdpCbAJl0DKcjaSB
	gY/0Fvgi1sG8V82dydtrYFoGeQF+v5e71U4de/CzJulHTJd9TvAuZaQR
X-Gm-Gg: AYBFou3YoBzCvfgncqBFXJjL70YtZWA4Ka6MDCU+CjJ7XRLFARY1cE5I8izp4P17jev
	Z+Bfzy+MHpQOShLCcs1O2nkNtBUjRRi8OqSqcfbPQpWiZ3JQGMxPedVUbOKGWZseh+u2ouIsbQm
	oCISPyYc2WbcQlbOnvaH+fl44GbdtOXH74fijMcbq3wYoDR1yr4ceGhB79c2G6ns6AfRd0rVeIk
	MYVK8nsqjc8KlXOdzfzlW4S4W25BRncE0cx1jTCsHdc5c5BoZiAXuLNT6CEE2yFGi6PF87qeaSJ
	D7dwM79g3euYWFOHnpFdYDlf+EGNLep/cEnIslEpv4DAnJNHOPJ+1oRXTfkLeuBm+NNkxB2vvB7
	2nf+azs0Xabbgj0+xj4IgKuGdyO3zIGNDdyznYvJockju5lRfVFzAEqQ9zgN3lmGMyEIA4xu0Gx
	gkXPQotvObtFIk5psi4V3AYDzLYp3c8DkApmCasbrs5yUalGOT7UDFQSvD2CNGsyqcgw+ABsaa2
	IJ55+sGnH5i1zzSD9fiLyDyqzSeD7/Yokg+Mpev3cjMmC0xFh9AFHyJnjXpKnAGk6+NbS665MM4
	cCdSjopoMySwM5Q7t0C8
X-Received: by 2002:a05:6808:15a0:b0:4d6:9252:4644 with SMTP id 5614622812f47-4d72ea60fb1mr765397b6e.56.1790202919796;
        Wed, 23 Sep 2026 15:35:19 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:19 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:42 -0600
Subject: [PATCH v11 18/38] dyndbg: macrofy a 2-index for-loop pattern
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-18-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=2812;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=zCwr+VGqKnNAOkzayghTBT7W0F9XwKbxJ4/xtvRrwII=;
 b=MtxKW5tqPWiU+c3h1aFiaFOnaqcptE3iPisUyD4ekvG6WyZ6vBzitYfyBmZ8s+ZdbA9UiPRPj
 IK6yKEbDE07BHfoCfxQJDvGQ52SxUshC0CGJ1Kcd+c1y+apgADflV6h
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

dynamic-debug currently has 2 __sections (__dyndbg, __dyndb_classes),
struct _ddebug_info keeps track of them both, with 2 members each:
_vec and _vec#_len.

We need to loop over these sections, with index and record pointer,
making ref to both _vec and _vec_len.  This is already fiddly and
error-prone, and will get worse as we add a 3rd section.

Lets instead embed/abstract the fiddly-ness in the `for_subvec()`
macro, and avoid repeating it going forward.

This is a for-loop macro expander, so it syntactically expects to
precede either a single statement or a { block } of them, and the
usual typeof or do-while-0 tricks are unavailable to fix the
multiple-expansion warning.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: move RvB after SoB
---
 lib/dynamic_debug.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1c0604d7e3cc..84a311fac657 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -149,6 +149,20 @@ static void v3pr_info_dq(const struct ddebug_query *query, const char *msg)
 		  query->first_lineno, query->last_lineno, query->class_string);
 }
 
+/*
+ * simplify a repeated for-loop pattern walking N steps in a T _vec
+ * member inside a struct _box.  It expects int i and T *_sp to be
+ * declared in the caller.
+ * @_i:  caller provided counter.
+ * @_sp: cursor into _vec, to examine each item.
+ * @_box: ptr to a struct containing @_vec member
+ * @_vec: name of a member in @_box
+ */
+#define for_subvec(_i, _sp, _box, _vec)			\
+	for ((_i) = 0, (_sp) = (_box)->_vec;		\
+	     (_i) < (_box)->num_##_vec;			\
+	     (_i)++, (_sp)++)		/* { block } */
+
 static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
 							const char *class_string,
 							int *class_id)
@@ -156,7 +170,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	struct ddebug_class_map *map;
 	int i, idx;
 
-	for (map = dt->classes, i = 0; i < dt->num_classes; i++, map++) {
+	for_subvec(i, map, dt, classes) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -1166,8 +1180,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	 * the builtin/modular classmap vector/section.  Save the start
 	 * and length of the subrange at its edges.
 	 */
-	for (cm = di->classes, i = 0; i < di->num_classes; i++, cm++) {
-
+	for_subvec(i, cm, di, classes) {
 		if (!strcmp(cm->mod_name, dt->mod_name)) {
 			if (!nc) {
 				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",

-- 
2.55.0

