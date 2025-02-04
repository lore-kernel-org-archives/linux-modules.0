Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67881155300;
	Tue,  4 Feb 2025 05:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738646592; cv=none; b=SR74IatS44HhOjw+EAp6ds0WaZ3o8FbwpkciuGAd1+CwD7XOqPiXsSZDiwLQbbRQ87xFLpXWoP3lXU6kQQ8/1X2wwcTimarV/qruOFbHyaQiCsU9jNWoq3yZhMI4PJT1O3pmBBYBcYP0Df7IQqng5KQ9nlztkSM/TGmI9VyNy4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738646592; c=relaxed/simple;
	bh=UVp817FmXr3cNnMienD40UydCcCR1Q1BOqMpQxywWiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qFmQp3DVhIdL2a3lXoAbvjanqDeOl8HCl2FA8nAjttKWZNaB9tr8AHQbw38Ldk2RQcMKWmNUwPQRbQAW88Gu6GH/vgpB9+gE6MMPotHn3HyLk5Qys1Mx5c5tl2xq0m0zOWVbBU3NYxH/3Bk83xMaRlcICQMkKSFANLOL0eGI0Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FKmo535+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FKmo535+"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id A5C5B2066C1F;
	Mon,  3 Feb 2025 21:23:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A5C5B2066C1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738646590;
	bh=cvXuNjcj9yYbFPM1G7gRfvjS+yimOvGhctKDxaPytKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FKmo535+oDG0PQO9PCFs/4b7AZJOZNRpJJ7JU4+GfEadEltP2iruxo+NkmwsAs9Nw
	 JvAJ4dLv5T+bT01mhafrwxMzDIr7pQqFfo3+ZztyC0OBTa8uWMvdCwOKvBT6jIAtTL
	 t0WT+v2mpuFoXjMzuhSMz3iU326p9AMHoPGm62XE=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Cc: code@tyhicks.com,
	linux@rasmusvillemoes.dk,
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
Subject: [v1 2/3] include: move lookup_or_create_module_kobject()/to_module* to module.h
Date: Mon,  3 Feb 2025 21:22:21 -0800
Message-Id: <20250204052222.1611510-3-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204052222.1611510-1-shyamsaini@linux.microsoft.com>
References: <20250204052222.1611510-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the following to module.h to allow common usages:
 - lookup_or_create_module_kobject()
 - to_module_attr
 - to_module_kobject

This makes lookup_or_create_module_kobject() as inline.

Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 include/linux/module.h | 39 +++++++++++++++++++++++++++++++++++++++
 kernel/params.c        | 39 ---------------------------------------
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 12f8a7d4fc1c..ba5f5e6c3927 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -894,8 +894,47 @@ static inline void *module_writable_address(struct module *mod, void *loc)
 #endif /* CONFIG_MODULES */
 
 #ifdef CONFIG_SYSFS
+/* sysfs output in /sys/modules/XYZ/parameters/ */
+#define to_module_attr(n) container_of_const(n, struct module_attribute, attr)
+#define to_module_kobject(n) container_of(n, struct module_kobject, kobj)
 extern struct kset *module_kset;
 extern const struct kobj_type module_ktype;
+
+static inline struct module_kobject * __init lookup_or_create_module_kobject(const char *name)
+{
+	struct module_kobject *mk;
+	struct kobject *kobj;
+	int err;
+
+	kobj = kset_find_obj(module_kset, name);
+	if (kobj) {
+		mk = to_module_kobject(kobj);
+	} else {
+		mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
+		BUG_ON(!mk);
+
+		mk->mod = THIS_MODULE;
+		mk->kobj.kset = module_kset;
+		err = kobject_init_and_add(&mk->kobj, &module_ktype, NULL,
+					   "%s", name);
+#ifdef CONFIG_MODULES
+		if (!err)
+			err = sysfs_create_file(&mk->kobj, &module_uevent.attr);
+#endif
+		if (err) {
+			kobject_put(&mk->kobj);
+			pr_crit("Adding module '%s' to sysfs failed (%d), the system may be unstable.\n",
+				name, err);
+			return NULL;
+		}
+
+		/* So that we hold reference in both cases. */
+		kobject_get(&mk->kobj);
+	}
+
+	return mk;
+}
+
 #endif /* CONFIG_SYSFS */
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
diff --git a/kernel/params.c b/kernel/params.c
index 4b43baaf7c83..3c0798b79f76 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -537,10 +537,6 @@ const struct kernel_param_ops param_ops_string = {
 };
 EXPORT_SYMBOL(param_ops_string);
 
-/* sysfs output in /sys/modules/XYZ/parameters/ */
-#define to_module_attr(n) container_of_const(n, struct module_attribute, attr)
-#define to_module_kobject(n) container_of(n, struct module_kobject, kobj)
-
 struct param_attribute
 {
 	struct module_attribute mattr;
@@ -763,41 +759,6 @@ void destroy_params(const struct kernel_param *params, unsigned num)
 			params[i].ops->free(params[i].arg);
 }
 
-static struct module_kobject * __init lookup_or_create_module_kobject(const char *name)
-{
-	struct module_kobject *mk;
-	struct kobject *kobj;
-	int err;
-
-	kobj = kset_find_obj(module_kset, name);
-	if (kobj) {
-		mk = to_module_kobject(kobj);
-	} else {
-		mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
-		BUG_ON(!mk);
-
-		mk->mod = THIS_MODULE;
-		mk->kobj.kset = module_kset;
-		err = kobject_init_and_add(&mk->kobj, &module_ktype, NULL,
-					   "%s", name);
-#ifdef CONFIG_MODULES
-		if (!err)
-			err = sysfs_create_file(&mk->kobj, &module_uevent.attr);
-#endif
-		if (err) {
-			kobject_put(&mk->kobj);
-			pr_crit("Adding module '%s' to sysfs failed (%d), the system may be unstable.\n",
-				name, err);
-			return NULL;
-		}
-
-		/* So that we hold reference in both cases. */
-		kobject_get(&mk->kobj);
-	}
-
-	return mk;
-}
-
 static void __init kernel_add_sysfs_param(const char *name,
 					  const struct kernel_param *kparam,
 					  unsigned int name_skip)
-- 
2.34.1

