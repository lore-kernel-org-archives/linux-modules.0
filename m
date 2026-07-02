Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B833C35F19A
	for <linux-modules@vger.kernel.org>; Thu,  2 Jul 2026 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010482; cv=none; b=bz5lt8IDCgLVEpo2AuqFWZpL+6Eg51vmVDb7kG2Wklsse2lpG3edSEqvZ/jf7QiuHvD8qnXOd/FgAW7/HED/cYaNIsi7pylbZAyzl1OpBpvySZK8ntExI/XNac4ghRn1Zwu3dcoAhkdw2NWeD2zeeiGbg8mQCVkXVPFh0Yes948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010482; c=relaxed/simple;
	bh=ifMjdOv9s5iBVhpB9m4hzA/NaIvmwyfWNqe78zgQbz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZC6cUZvjIb9A9BbPPKd1Z6ZBGQkvtA319vGSC6kBBHgEL7V5bOFvFIDsijXJSuO0cs8jUEyxOqTvnbP+sNd1TIDlgNY7AQkmV4KHd49m//B+21XrXAXvE7kFa6PPeKvxp8g3gRNkfXxa/pekmZJ99B/mtTOfOPHTb+o8tXqC9VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzugMmsf; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzugMmsf"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-44cec432a37so40233fac.3
        for <linux-modules@vger.kernel.org>; Thu, 02 Jul 2026 09:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010477; x=1783615277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x+DQN3gI8cDIPCl5342KuGjmmS7ZUCk1xMik8PQu+to=;
        b=DzugMmsfuxQ41t/aRqQPzsRc0ecfKgSGOQuxPDm9krCZfLP2akZthQF5oARGSJOvxb
         ev5z8yy35SwP6GVmJnOopOPxEePi7JZBK1FMh4CA42siMq8j4TlaVhWnyS6MjglDLbD8
         z6WnVQ1dCC1fBemLlGFxqUWJKFkism5knxTU7nbZQOTFqDshlK49QvLl8mNVQXCXWOza
         j9qiOT6eIzRDmlOKo+RbERFWVNTKVgx1LnmdLXLteTjpFx7smL4JN2nBQlLBfhl0IEEj
         g2vRx1dvBNwn2mqSU/0JbYRWBzOh3/OM+h8wphTzSvIlKYPeiBONGj/imB/lr+gwVLzW
         c9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010477; x=1783615277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x+DQN3gI8cDIPCl5342KuGjmmS7ZUCk1xMik8PQu+to=;
        b=lbXQDQ7oDAO5rmw8xzadjXe4NSPJLVrK051uBO89vtknUugmVjOgW84Sw4CnxGKCua
         5k3qPRqJRvLldRL0Vgw0f6bFsXW9zVG/GadyGs+k3iqD5oCA5AH2YhP7bgwKGXRUhVeE
         kzX9eEqqAEeyeT1NWMTjOQcBWcuq//uj7nxDLcmBO926kzOHK3e6y+2FsB4DEwZSqpMG
         Eb/9elnm3pvwhGBj6MNJ4R5Cr80jDqK9kw1RXlby4uiFB54VSR1fN8kcBjaCi0+CCoID
         oauRDJHmSkoUhp4SHCXMJ/ZooIVKn7ubQXOPJoaOlLYzUEGDnr2e/rHTDIVXupcji12l
         It4w==
X-Forwarded-Encrypted: i=1; AHgh+Rp7DIrw0FNF72G8U1hJszO8lpjaWP1fzTMChj0AKuZ1Hllp/dZ94+GhVYOKMVUvBEwxRgi329s0u/AGfXL+@vger.kernel.org
X-Gm-Message-State: AOJu0YzUgbqxv+yctkcr2u67J7sp6NhSwkYo2FDVScZRUYgCjFgoBEeM
	CE4snveqOrpiYOo0M7atsF9KlmhJ7vF341fFG2J3VDJ4S0fmZv9o2bEC
X-Gm-Gg: AfdE7cl3IJ9soMLMa4b4o5I610kQgprh7hTiW7vBINKp/MEep0AVQ9QTLLKLKzl6cn3
	PxfEfuCiulGINrCp6BBvOQzEmcr6oV+a2Ws7DTEhrec8Q1nqSbh4CM2QhjMqi93Io6FZVnlpyxz
	m4OkYvmldnhT9AA8etLNxBtro30C9+uidctLhI8Bo+Ri7gYYtnVNyos5A0FJxUTQ6KMwn5dUlx4
	n5DSR38kH5PE9jE0FBAYCRBSqxR9tW997t+UUUZhlNkbTeWAxwNODlBuOG+B2NTr6GZAMuEnC6p
	REzn8mdqvpWFV1Ynk/pcX6P/BeEtEpJsBpEVsmS3ciaakiJucGJCqtYN2Hq4o7v8WaFp5BOaMe/
	n5vzfLK8hOP13mEfcpwm6eiww2xNcbh8Ua1pQVtrfqAPjGGZKTF9PjMQaIJastMHQQqK4Q74Dg+
	QR0bHBBHL1abEwTxe0J86Z90Rw/cwOIUhAK+oTZpJHHF9hA7NNKCMdJe5vTEiTBA==
X-Received: by 2002:a05:6871:c8ce:b0:448:501d:9c80 with SMTP id 586e51a60fabf-44cb466ec74mr3708004fac.30.1783010477603;
        Thu, 02 Jul 2026 09:41:17 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:41:17 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:40:54 -0600
Subject: [PATCH v5 02/18] dyndbg: add stub macro for
 DECLARE_DYNDBG_CLASSMAP
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-2-24f22b052bf2@gmail.com>
References: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
In-Reply-To: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=3163;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ifMjdOv9s5iBVhpB9m4hzA/NaIvmwyfWNqe78zgQbz8=;
 b=s3V8oxULKuOEwzd0zRiR4WVTXWzlzQAHWMQGPjEk1YtVvFgMWa7Ii++Nul57WSvKUwkHFcYcH
 obiCY5GqJZPAwDtHEDzD89Poxk1fRQkZ1aqcT763rr3ApG33oWvKUnk
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

