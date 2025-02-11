Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B352676E7;
	Tue, 11 Feb 2025 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310589; cv=none; b=Bwrep2kfwd0dURcBLFYyzpEdSxTu8aU3CQGDKPfuvVUns0pVlqdns/eqtypKpHeDvbupZVrMetYIHUNKGhEWcYhMoUf8iJFowkH3lKbOXhyYzObcs5RjxKpmY7JV869emDnP+qZzaR9/yBnDOcNEHCToT8unaY6skWrIs9tSNwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310589; c=relaxed/simple;
	bh=MooFLEl0bWPjHa3KlXQVOeMtCdlP7U0xpaaXz9mwZvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgE+qNf0ipgKdLBW2tClkJdVx/5JnNRhLmbJHR8v2D18fldcNUpczkgaLZFX06Ja4HA81qNrrZ5uROQ0OTS5J4zzl/5bN/MjtGvd575cmslDZaYvDE4GkVP/ZqXtAsdrkoYYv2tRLAIwMPQzgV0OxrIwalAtaTyqfij+YMQGAqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=e5LZ3OYk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="e5LZ3OYk"
Received: from thinkpad-p16sg1.. (d66-183-104-158.bchsia.telus.net [66.183.104.158])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5F75E2107AB3;
	Tue, 11 Feb 2025 13:49:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F75E2107AB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739310587;
	bh=Eg74aJvcfhvMWz2U+6WWbgLN/WbFA7n4ktssOz5i0E4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5LZ3OYkM4mBTKpKufldtlCuxffLm3HSXUe3HtS5JkcZGChmBWxPzVs8SK09pkWgu
	 nQErit/CYCV1u53q6rLpeMGQBWrQHsiONzhMe9aWoxQ4RUCwcLRMy7+UR4lIn/h2na
	 W8PBL2MG5rdUQbb7RYNE4GyOXh6N9Cu8AURyQyQ8=
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
Subject: [PATCH v3 2/4] kernel: refactor lookup_or_create_module_kobject()
Date: Tue, 11 Feb 2025 13:48:40 -0800
Message-Id: <20250211214842.1806521-3-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
References: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
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

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 kernel/params.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 4b43baaf7c83..6e87aef876b2 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -770,31 +770,28 @@ static struct module_kobject * __init lookup_or_create_module_kobject(const char
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

