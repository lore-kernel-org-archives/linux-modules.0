Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1FA18CC15;
	Thu, 27 Feb 2025 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682189; cv=none; b=WfQvwNQ/DPbaLv+MauPeTbgeg3+juabupPbLxbKwfD66kC4KZrzAWxpXYCRWNNwO/Hes/Lff6gQUb5b8PJbnrFqZ94F5UA6X1vzwUWCMaZppbgYpANUP7E12bBhI52C579VQWQ/X/NKWIuPQT9kHkUdbMngBEPj3Cg2FLQvyVsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682189; c=relaxed/simple;
	bh=QOVVy30w0yjGDUx0alWe7xFwKYpr8UhCqjh3XxGTLNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppy80L2bPn4coZ7aKR4bOqBVNzEj77Ok0YlATMGqhT37PYhL87ku3rYQDOPBE9LYNNd+pMmtPSrlFAx2dj+JsfuUzjFvGVdyomWwodG15bqoXWxsyViNd1REUhdDAiqcIbbgQfqzHnwcLsCbufua5SpZUKHExOMWqZUTRjfpeRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Qa2QBq0w; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Qa2QBq0w"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id CF669210D0F6;
	Thu, 27 Feb 2025 10:49:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF669210D0F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740682187;
	bh=YLcGI/kTb053KSrsSt4PANHRSfrrT+EuSgp6dgWUy98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qa2QBq0ws/Y3y6J+65iDfKkRgJZpsvckx6XJytKhf3xXf5lKwdE4o0alfX2xFvRX4
	 tDoWio3xYbrPQi45jUstiVfGA+se94PObaHbc+ZyDofCnqhebf43qIMDGzLX1tZqp9
	 QkgCYPd/AJo8P9pOhw1Q6WdC6QYJ/+BB8BvwEdYM=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Cc: petr.pavlu@suse.com,
	code@tyhicks.com,
	linux@rasmusvillemoes.dk,
	christophe.leroy@csgroup.eu,
	hch@infradead.org,
	mcgrof@kernel.org,
	frkaya@linux.microsoft.com,
	vijayb@linux.microsoft.com,
	linux@weissschuh.net,
	samitolvanen@google.com,
	da.gomez@samsung.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	stable@kernel.org
Subject: [PATCH v4 2/4] kernel: refactor lookup_or_create_module_kobject()
Date: Thu, 27 Feb 2025 10:49:28 -0800
Message-Id: <20250227184930.34163-3-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227184930.34163-1-shyamsaini@linux.microsoft.com>
References: <20250227184930.34163-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the unlikely event of the allocation failing, it is better to let
the machine boot with a not fully populated sysfs than to kill it with
this BUG_ON(). All callers are already prepared for
lookup_or_create_module_kobject() returning NULL.

This is also preparation for calling this function from non __init
code, where using BUG_ON for allocation failure handling is not
acceptable.

Since we are here, also start using IS_ENABLED instead of #ifdef
construct.

Fixes: 96a1a2412acb ("kernel/params.c: defer most of param_sysfs_init() to late_initcall time")
Cc: stable@kernel.org
Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 kernel/params.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index a2441ce059ae..787662663e34 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -767,31 +767,28 @@ static struct module_kobject * __init lookup_or_create_module_kobject(const char
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
+	if (kobj)
+		return to_module_kobject(kobj);
 
-		/* So that we hold reference in both cases. */
-		kobject_get(&mk->kobj);
+	mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
+	if (!mk)
+		return NULL;
+
+	mk->mod = THIS_MODULE;
+	mk->kobj.kset = module_kset;
+	err = kobject_init_and_add(&mk->kobj, &module_ktype, NULL, "%s", name);
+	if (IS_ENABLED(CONFIG_MODULES) && !err)
+		err = sysfs_create_file(&mk->kobj, &module_uevent.attr);
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

