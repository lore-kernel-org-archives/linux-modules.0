Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826C9317164
	for <linux-modules@vger.kernel.org>; Mon,  4 May 2026 20:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927521; cv=none; b=lfFWz5bZkISkKnJzHedcTjeJWnZ4yTwc7xk8n3Q/n39iMEV+OTaANDgJGDRh6JiZfEiKTivFaCv/W1QNVnulzgkhTxIB06Asw3+naX0/3jcFEDb/0jiYifcwlp1y5q5cG8n34bcm3sf8t2xoX1nv6PynWix6c15VI8mPPsDXJaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927521; c=relaxed/simple;
	bh=ifMjdOv9s5iBVhpB9m4hzA/NaIvmwyfWNqe78zgQbz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mwN6bGC+4Q8a3BtvLa8ag6ROAX+bCf9yMvkUXPf5J+R3H3xWWpDfWc2X9F4BjxPMyCC0Eo1zz4jw4rumzvjM0zaz6AG9VlY7VuA0xdp8OPwvPYfP+6BosxLXh/I2dAb0f3UsWM2apOqiBk0lxqGkxYVxnWPg+4l/K0Xt30sH+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiFAHWxe; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiFAHWxe"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-679b072ed3aso2192480eaf.1
        for <linux-modules@vger.kernel.org>; Mon, 04 May 2026 13:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777927518; x=1778532318; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+DQN3gI8cDIPCl5342KuGjmmS7ZUCk1xMik8PQu+to=;
        b=NiFAHWxeS3aN4YXnfPFFoPQJx7YSj9JZweBvlW8EMMshIRrOGQwOLwkQhhqAlgnyVf
         VX2ozIKk+bbFLwjpHX4MvX9SvQHjJp2poawhUvwfdM/ftkdF0F+/6es2xcVL2P4lh+Gs
         HQkEKZceOuPikzRXBZ/1XwJz616ccsEB8KI+dJExKt1zkC+VmLuab+8dPi4dCO9RsSt8
         LNsrDE82HdIR0QBIaAQEswr1DjullBY40ZVRafAXPhAEFz5gLHCaXwLmYxdiGp5QlDTm
         yNtJlUPBaBss2LbJQeMMR2qQtA7gwRKKWBaEUsQrPBcjGhEPwSL066eQPl9Tsf74nXUL
         TH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777927518; x=1778532318;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x+DQN3gI8cDIPCl5342KuGjmmS7ZUCk1xMik8PQu+to=;
        b=eWCPGIAmN/6vWWZvLXk2ZNDbLtDntXXvS0J1SH5zDmH01+hNiuxZGQWyDhPGXFxXeN
         eRitZSLfzLXl147cl6KXtYALCkPYgmwWsPmw5lKExC83zw5EAYvQLV8zgxiOtT7A8lPr
         PWQeHoaWTeMMkfY0N6jVgqMj0MfOhqMeKErD+YuJx+yS4VloYYiGaqVu+NLrBq4fdl1i
         VzbMvU5tM2KlNUSksJ4QcvkCs7wXrtcJYOEMk4NGegPJUby0OvFeHs0g88Q4b27Nm6Qm
         A+9rjHs3J7vKxTupz/5ubY0YQEXzND+cZJMWdEy3BwmRiJoqZ3Kyk+jGZE5UottQr/yG
         coHA==
X-Forwarded-Encrypted: i=1; AFNElJ9h9cpZq6pHOGadcIx51A0zuWeHfVxTEBifPK8Q6Z9p1iQLUISTOiqY9O//hTWtRiqKJMO2IhrIjKJron7y@vger.kernel.org
X-Gm-Message-State: AOJu0YwOW/LtafD61v3fvJSY3HoZYT10naXGH+WNa44YckSGjKVM1pkD
	z8HcRokpeu4mEavsPGtrx7o2Nniy3hqUcTFuRL2dar5kK9iZdkCDq8Sn
X-Gm-Gg: AeBDieu7NOFLzYWv66Lr00W6SIzBJI7mSf20M7H007/stIsWrxunOPGwpmpvrSQVUBq
	UaLrr77uDN48cng1+JmU+LHa55SXj7voK0XkSmYBfMhLBZ0elfIR2o+N9gIMgjQbXxpfY9DViZJ
	k2fEakh/aky3unRimOqsjakURUQjaFr6CFV5Kj3Pp6mKbvJqa2k9FTfOn0KMRjeFllGVLYTQNBC
	WK2eg9IN4HsoFpm+9xffMNhqcLijeJYPyVwnjchjlyh/ocqokJr/1zW4Ezvb3Jevx1uCMIXV6D5
	7OHucrlMVQagZ5O2hkuOaJo+er03+OBQ0bmkU4Vw383wN5V1fayH4UMf4+XzDnfyu096gcTSQ1L
	lBGN0RJKgslQT2u1fZj+H8X9JUdg0itr8YFu1wYXVRPF3wx2DOyr2Jm10pnzf6WXHMKVdFOnNv5
	JyvX+EGV2v14nd/ErXsxxedWpOJIJJCzIrtNNw/XBbPlH6ZglThddROo6AMRxl6tYAPh1nqc/q
X-Received: by 2002:a05:6820:1c95:b0:696:1ef9:e089 with SMTP id 006d021491bc7-6998a5d8f95mr109958eaf.25.1777927518478;
        Mon, 04 May 2026 13:45:18 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69689266bacsm7144713eaf.0.2026.05.04.13.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:45:17 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 04 May 2026 14:45:08 -0600
Subject: [PATCH 02/17] dyndbg: add stub macro for DECLARE_DYNDBG_CLASSMAP
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-dd-cleanups-2-v1-2-6fdd24040642@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777927513; l=3163;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ifMjdOv9s5iBVhpB9m4hzA/NaIvmwyfWNqe78zgQbz8=;
 b=ELNpbklOMxkyIEvTicWCBD3SRrV3pt2HW2FAvEdcwAYuYr/+pyySHTtXwsP2Y6O8ATUlNZ8KA
 lxAdwMMEP3uChg+xvIybPvAwnRcQ+XofWE8GCHXQ7DPHiy5Pb2zJqHM
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Add the stub macro for !DYNAMIC_DEBUG builds, after moving the
original macro-defn down under the big ifdef.  Do it now so future
changes have a cleaner starting point.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 05743900a116..a10adac8e8f0 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -93,27 +93,6 @@ struct ddebug_class_map {
 	enum class_map_type map_type;
 };
 
-/**
- * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
- * @_var:   a struct ddebug_class_map, passed to module_param_cb
- * @_type:  enum class_map_type, chooses bits/verbose, numeric/symbolic
- * @_base:  offset of 1st class-name. splits .class_id space
- * @classes: class-names used to control class'd prdbgs
- */
-#define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
-	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
-	static struct ddebug_class_map __aligned(8) __used		\
-		__section("__dyndbg_classes") _var = {			\
-		.mod = THIS_MODULE,					\
-		.mod_name = KBUILD_MODNAME,				\
-		.base = _base,						\
-		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
-		.class_names = _var##_classnames,			\
-	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-        (sizeof((eltype[]){__VA_ARGS__}) / sizeof(eltype))
-
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
 	struct _ddebug *descs;
@@ -138,6 +117,27 @@ struct ddebug_class_param {
 #if defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 
+/**
+ * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
+ * @_var:   a struct ddebug_class_map, passed to module_param_cb
+ * @_type:  enum class_map_type, chooses bits/verbose, numeric/symbolic
+ * @_base:  offset of 1st class-name. splits .class_id space
+ * @classes: class-names used to control class'd prdbgs
+ */
+#define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
+	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
+	static struct ddebug_class_map __aligned(8) __used		\
+		__section("__dyndbg_classes") _var = {			\
+		.mod = THIS_MODULE,					\
+		.mod_name = KBUILD_MODNAME,				\
+		.base = _base,						\
+		.map_type = _maptype,					\
+		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.class_names = _var##_classnames,			\
+	}
+#define NUM_TYPE_ARGS(eltype, ...)				\
+	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
+
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
 
@@ -314,6 +314,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
 #define DYNAMIC_DEBUG_BRANCH(descriptor) false
+#define DECLARE_DYNDBG_CLASSMAP(...)
 
 #define dynamic_pr_debug(fmt, ...)					\
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)

-- 
2.54.0

