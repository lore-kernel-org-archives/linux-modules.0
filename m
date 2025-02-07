Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414121422A8;
	Fri,  7 Feb 2025 05:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738907164; cv=none; b=tTyJ66Y3cKXX5mCN90WoNW6faGXFblkh/I+P6xoYFP7xM0gtVgFPWDtScfpiX/Y6eNEUIUAYCFGhIj0+g+Zzw0lnfMmFL0niTe40Ei+bl68uY0VvE0ZOdjRG1EMVnf0PLIlF63v3VdU+vopHAcd+36wxdYMiMguaOhxThZVlxiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738907164; c=relaxed/simple;
	bh=qjwX+cxHR792JNT+n1QMaDXKPSAStIH6+SGwvQ6IXsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JS3vLShxvTAi7WUEysxJNA4byYWUX9cxd7CP2FGEdpZYlj2finuv3DaI520ozDfNzehGIRUpxz8I9j1fcSebvnB9WHTCgvYIfYeTe6GmfwXXM5o82PLhTNeRefAZeTTmDCJZ/r+cjR8D8FxQGm90dCYOTP73gHcDCURsZgGqR+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sRAaOGYw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sRAaOGYw"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 83A15206AB72;
	Thu,  6 Feb 2025 21:46:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 83A15206AB72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738907162;
	bh=Flu8T2qAQw2iwO6Fbkr4rCfV93wKdS1P8fALJGfIO5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sRAaOGYwUlUcAbt3EyI1YKs6Thr5rLUdFLk04uPGDKK+MB+dguwqyZ0013E+ypIyv
	 9zJco7HE4Bxi6+bhZOQDjDEcW4eXnI9wj5Kvaw1OXUidJ8KRsDhGsa+Esx4fwu4gQz
	 tJzIMx5vHDnOAs3oYeqhxlKu/0WjSzI4piSyJA6U=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Cc: code@tyhicks.com,
	linux@rasmusvillemoes.dk,
	christophe.leroy@csgroup.eu,
	hch@infradead.org,
	mcgrof@kernel.org,
	frkaya@linux.microsoft.com,
	vijayb@linux.microsoft.com,
	petr.pavlu@suse.com,
	linux@weissschuh.net,
	samitolvanen@google.com,
	da.gomez@samsung.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Subject: [v2 2/3] kernel: refactor and globalize lookup_or_create_module_kobject()
Date: Thu,  6 Feb 2025 21:45:37 -0800
Message-Id: <20250207054538.1110340-3-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250207054538.1110340-1-shyamsaini@linux.microsoft.com>
References: <20250207054538.1110340-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lookup_or_create_module_kobject() is static and marked as __init,
this is not ideal for global usage.

Fix this limitation by refactoring and declaring this as global:
 - Refactor it by removing BUG_ON() and 'if else' construct by returning
   early
 - Remove static and __init markers from the function and add its
   declaration in module.h
 - Mark this function as "__modinit". To facilitate this, move the
   __modinit macro construct to module.h

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 include/linux/module.h |  8 +++++++
 kernel/params.c        | 48 ++++++++++++++++++------------------------
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 12f8a7d4fc1c..57d09b4e4385 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -162,6 +162,14 @@ extern void cleanup_module(void);
 #define __INITRODATA_OR_MODULE __INITRODATA
 #endif /*CONFIG_MODULES*/
 
+#ifdef CONFIG_MODULES
+#define __modinit
+#else
+#define __modinit __init
+#endif
+
+struct module_kobject __modinit * lookup_or_create_module_kobject(const char *name);
+
 /* Generic info of form tag = "info" */
 #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
 
diff --git a/kernel/params.c b/kernel/params.c
index 4b43baaf7c83..5d16696b1daa 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -595,12 +595,6 @@ static ssize_t param_attr_store(const struct module_attribute *mattr,
 }
 #endif
 
-#ifdef CONFIG_MODULES
-#define __modinit
-#else
-#define __modinit __init
-#endif
-
 #ifdef CONFIG_SYSFS
 void kernel_param_lock(struct module *mod)
 {
@@ -763,38 +757,38 @@ void destroy_params(const struct kernel_param *params, unsigned num)
 			params[i].ops->free(params[i].arg);
 }
 
-static struct module_kobject * __init lookup_or_create_module_kobject(const char *name)
+struct module_kobject __modinit * lookup_or_create_module_kobject(const char *name)
 {
 	struct module_kobject *mk;
 	struct kobject *kobj;
 	int err;
 
 	kobj = kset_find_obj(module_kset, name);
-	if (kobj) {
-		mk = to_module_kobject(kobj);
-	} else {
-		mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
-		BUG_ON(!mk);
-
-		mk->mod = THIS_MODULE;
-		mk->kobj.kset = module_kset;
-		err = kobject_init_and_add(&mk->kobj, &module_ktype, NULL,
+	if (kobj)
+		return to_module_kobject(kobj);
+
+	mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
+	if (!mk)
+		return NULL;
+
+	mk->mod = THIS_MODULE;
+	mk->kobj.kset = module_kset;
+	err = kobject_init_and_add(&mk->kobj, &module_ktype, NULL,
 					   "%s", name);
 #ifdef CONFIG_MODULES
-		if (!err)
-			err = sysfs_create_file(&mk->kobj, &module_uevent.attr);
+	if (!err)
+		err = sysfs_create_file(&mk->kobj, &module_uevent.attr);
 #endif
-		if (err) {
-			kobject_put(&mk->kobj);
-			pr_crit("Adding module '%s' to sysfs failed (%d), the system may be unstable.\n",
-				name, err);
-			return NULL;
-		}
-
-		/* So that we hold reference in both cases. */
-		kobject_get(&mk->kobj);
+	if (err) {
+		kobject_put(&mk->kobj);
+		pr_crit("Adding module '%s' to sysfs failed (%d), the system may be unstable.\n",
+			name, err);
+		return NULL;
 	}
 
+	/* So that we hold reference in both cases. */
+	kobject_get(&mk->kobj);
+
 	return mk;
 }
 
-- 
2.34.1

