Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916B33B6C08
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477120; cv=none; b=Li35pWoQ14bUBShMXtXCeZBRFb6DRAZtI24j0pclOCFD0PRE2J6HhWH/VXA1q2Ubx4Vy4gb5ebYuKuLGJOldPe9FT5vJSCYiYfEp0hCgw1rD6Z7Q/e29f3t7sak4TaTgkCadqWcfuzhXbWIasJGFggo6fekn+lzTibY494p6D/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477120; c=relaxed/simple;
	bh=ZuzqA3zGt/j9kYmFGfFlaL94NbjSKGlzcBcWBUqAWbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UarsE3zpHpkP3HxnMsauHkef+/DmYbI4xZzQCTZotPctCsl4pGe1OKwbgWKvYPu/4D6AW9/HwVdxa1nsQH02dlP8qSoPr6sAZ4jt0D9dWfNFILhATS2imTumqj0BmQGQZ73/fMNBv+8E4At6ixSo6E/xHzlYcNzVAJeDJr5nvpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6KW+t23; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6KW+t23"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-497d3e4460aso1305413b6e.1
        for <linux-modules@vger.kernel.org>; Tue, 07 Jul 2026 19:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477117; x=1784081917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8dUvDJ5uj/iqj7Hr1Y3Cg7XHwt3DLPAXGIUQMEXgMI=;
        b=K6KW+t23RRnF0eUDmExN1coP77KTqWHLZxvsn0s7bguE75vlYDrQS6KxCliW+SYmRd
         TxJMhyTwbBEv25jSMAkmDIZ2dHbHbphaOpVtoK6bT0/+gF4eb74y7uF8iUTAcyZ4LzeW
         gvOF7etrhUuc3VM3moP2Rzuf/rincvjdiY+TjpnandRFhBczCkb/VOsrbL46ZAz3CihT
         DG9+yHWJSXdK3+A+z0C1RpoCE2VVHps1SpQFqrzGPZjq4sL9s7+Iris3evUoU7Kwp6ph
         zGvu7StJ4Ow864bsmcUY8lKxKmYTzdmIL/saGrMjQKZxXyDv7Jn6G4p3in3N+tKwZXMm
         hpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477117; x=1784081917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z8dUvDJ5uj/iqj7Hr1Y3Cg7XHwt3DLPAXGIUQMEXgMI=;
        b=HJXINCwcZkPYma4Te8xw/MjgpjEHjPGtf75U9ODPiC7oBb6LwhZZKfeM7+qQk0OkHz
         8BpdmyeIgiegNNYu829EuCrf/VxRVLwvuHo2lUt7yEC3TzLgJuwJ/PJup2Beb6+P/NHY
         gP6rNkIy0M+Zyrc4l0xYI5DGrWiARXWJ1zkGrDcgeJCaXqUpBCV97BAzUDcUSVH0b2wt
         5RbraaSZu9/PIXWJ1RBYvRP1qQOxI5ThrN+MQzkfA9Rtx6GDJWca7GgJQGhdIN/DonGH
         Rr1q43J22MvuExIEhr4oUuPb/EhFzH/KZTm6Dcxzz0g4nqMxtYR0DD7qFi7HgyOyWICX
         CWnA==
X-Forwarded-Encrypted: i=1; AFNElJ9c9QPflyfqxJRwHvWI04CsasFwYJIPuw6RYtrvaKZmJNpZ0MbtQv+V7LXCS++KlyFFnfe1aNcm0iStxFGV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3tjCe+UXM4q3HynKCb8X4NlR84cNeIn/R3PrP1Jvow8auu58w
	LS/KBiN5qc5Hh/4KfH1vQdT9IRAs1oKe1gV3O7gtAKmcK9AC32we/Se3
X-Gm-Gg: AfdE7cnqRyPrBDfY0XBws33IrPjESXJvMrrCBfwPpSgtoATZiDm23ENYmrzPMCjqAz8
	NC8Ts4R631LmW//ZvM5hpIU6gxgCcs01Dglg1XbiKhYoRc+2iu7ITrby4j+dvkipy+4AQ6Yb3hp
	AgSyoHdisaWDFGPgDC9W0Vv6lJqfowrumSke5JcVG/0AL6P+UpViteBEHQFWulkIOzm/hRzug/K
	4QhFqt7WsSGvXRd0qEQM9YuRdftA/UC+SAAY2U95+GQiUkbKB5yycXqmROPMY64MidOXpVPQYoI
	F6InxU/FC0IWP4V5fOs88ovn6TMb0ZHJmIX/BRH/G2xn8NS/qAVKcJQ2Cir6tSlZ3uXndAGZ1DJ
	+9eCygNHIXrboTXibeEce6KG9/Uu77/Fgi92NqnUmGCxnfN3CfGR0JAM4vaQiDWu3uQpfb34ux4
	DPUHVyHsaYa8aSRNWgOlVe8Y+cdgJJZYTlpvXA9pwwVdFzvroXrS4=
X-Received: by 2002:a05:6808:5383:b0:495:dd23:1634 with SMTP id 5614622812f47-4a078d678fdmr4414093b6e.15.1783477117572;
        Tue, 07 Jul 2026 19:18:37 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:37 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:07 -0600
Subject: [PATCH v6 07/24] dyndbg: add stub macro for
 DECLARE_DYNDBG_CLASSMAP
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-7-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=3163;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ZuzqA3zGt/j9kYmFGfFlaL94NbjSKGlzcBcWBUqAWbM=;
 b=Df/3Jimg35ze3m1P/ozSvM5FvBWV8r61gESD6JGx3nop2TPly5KJeYBPy+kA2q5XrW74Hvatj
 GIqsDorjqu3DRe7lb5t9WSRn+uPKlFWyrPUIZa3ReDIinFblSpF4CJw
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
2.55.0

