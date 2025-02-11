Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46042676F9;
	Tue, 11 Feb 2025 21:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310590; cv=none; b=n8hzZN/RPxJd8Y5WSKT91g0RcveT6NfUto7R7iTzKpXaC+UMNTUVwli590+Xuqof8wNLbLm0iTprol0OZgqYYEfeVPHN5Fx9yqiEhFkZnCHYNiF+nYWJn8aPvXckj9/BrI74rqeu66X7hWxq7c4N2YtwudEjPBYqUgQveL/oP2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310590; c=relaxed/simple;
	bh=/Vw0uA/SfcM1Q5cZ2D0GVUFQ1fCC93v6eCJXbUyAOKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T+ssMxAJbDYFg6ojaONyrmHlY0CY4nRTCCYBihD2nwYN5BbPt7lzjYxMpK5Nr5Wd3ELZGhqLfMkJTWl5H7SJ8Fzr2xbrI1V+V/B/EP60Xq+gnBdiI3vLI+yXGvxQkdkXVHzELIPw8nHMItO4HcGJBO2I2WiJpUyheLbEfnIZViM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WThL7b9M; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WThL7b9M"
Received: from thinkpad-p16sg1.. (d66-183-104-158.bchsia.telus.net [66.183.104.158])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0EE412107AB5;
	Tue, 11 Feb 2025 13:49:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0EE412107AB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739310588;
	bh=spbTcWnNZV/JIcqv/y8cbywTNmS9a7lMbI4mTbTwEKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WThL7b9MXhjdL/yP/jL5UsSyOyc2zgHo6MzmEkqDsZ6neDOVPGvFa1LYW+xLVH41O
	 VWFzfJ2H0uN4LI5OJCsPO6p4W8YD6wTOZPoyy2M4PiNdULLT11AjKKoHn8bBlDp46m
	 dYkcsZRYutoT93eCiBNzMunbzm/Ttv1L8H+DDej4=
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
Subject: [PATCH v3 4/4] drivers: base: handle module_kobject creation
Date: Tue, 11 Feb 2025 13:48:42 -0800
Message-Id: <20250211214842.1806521-5-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
References: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

module_add_driver() relies on module_kset list for
/sys/module/<built-in-module>/drivers directory creation.

Since,
commit 96a1a2412acba ("kernel/params.c: defer most of param_sysfs_init() to late_initcall time")
drivers which are initialized from subsys_initcall() or any other
higher precedence initcall couldn't find the related kobject entry
in the module_kset list because module_kset is not fully populated
by the time module_add_driver() refers it. As a consequence,
module_add_driver() returns early without calling make_driver_name().
Therefore, /sys/module/<built-in-module>/drivers is never created.

Fix this issue by letting module_add_driver() handle module_kobject
creation itself.

Fixes: 96a1a2412acb ("kernel/params.c: defer most of param_sysfs_init() to late_initcall time")
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 drivers/base/module.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/base/module.c b/drivers/base/module.c
index 5bc71bea883a..218aaa096455 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -42,16 +42,13 @@ int module_add_driver(struct module *mod, const struct device_driver *drv)
 	if (mod)
 		mk = &mod->mkobj;
 	else if (drv->mod_name) {
-		struct kobject *mkobj;
-
-		/* Lookup built-in module entry in /sys/modules */
-		mkobj = kset_find_obj(module_kset, drv->mod_name);
-		if (mkobj) {
-			mk = container_of(mkobj, struct module_kobject, kobj);
+		/* Lookup or create built-in module entry in /sys/modules */
+		mk = lookup_or_create_module_kobject(drv->mod_name);
+		if (mk) {
 			/* remember our module structure */
 			drv->p->mkobj = mk;
-			/* kset_find_obj took a reference */
-			kobject_put(mkobj);
+			/* lookup_or_create_module_kobject took a reference */
+			kobject_put(&mk->kobj);
 		}
 	}
 
-- 
2.34.1

