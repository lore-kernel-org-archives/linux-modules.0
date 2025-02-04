Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE29E25A635;
	Tue,  4 Feb 2025 05:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738646592; cv=none; b=YGOwY6boxwKYz0NCeRaRueE9Zf4n9Smv8WpM6tHGuab1QzxkLqkAg2r2iTpdNUVaeWBp5GJBETUbSCuYqWnlBxaD2cEPF8EjMw/w+xp+v96YpaWsiG5/2mngNWi4grs7yB0JdCM7ziswzumBIYQH1sVQQTpgxbM6kATQWWoy/tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738646592; c=relaxed/simple;
	bh=/UDhm/vaWOmQBD2Ymv1yhU7aLHSoK2nAEDtBJRfoU58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FkUt+oxsYc41Ro9Aqu29UsVapv/S6OmEBiuLerUURhAd8c/KQBVfTTSBfpG0tPquD9n2hg2M3Cv1uE/S68/0Y4Yu3ceyWuh5FKW8kmJ0aSvhqnOI44DUKSChslEVNakzLX8jmCvMf1+b6PZT0na55wDdrUyeaIwwWIwV2nQNrR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EePQux87; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EePQux87"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 567A3205721D;
	Mon,  3 Feb 2025 21:23:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 567A3205721D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738646590;
	bh=csRcyVR+eazDhu8zA5aLUmc3OVGKk3oiP6AFa429sl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EePQux87gxUelpWpxJzIu/HscLLmmNpNJAa16aRL4Mn1hZVk4e9b9v7ulwJEkS3MU
	 3gjMX50I8yFOv0DMOzKt2ZC9b4elPtmJpmxievXOfChkfAPiSX0mjMJZYUt5oKlG4y
	 G5oI51QM517ucJlYn6fxBO0orAbBb9zZSm5AoMlw=
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
Subject: [v1 1/3] kernel: param: rename locate_module_kobject
Date: Mon,  3 Feb 2025 21:22:20 -0800
Message-Id: <20250204052222.1611510-2-shyamsaini@linux.microsoft.com>
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

locate_module_kobject() look up for existing module_kobject
For given module name locate_module_kobject() look up for
corresponding module_kobject if it exists. If it coudln't
find its corresponding module_kobject then it creates one
for the given name.
Rename locate_module_kobject() to lookup_or_create_module_kobject(),
to better describe its operations.

This doesn't change anything functionality wise.

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 kernel/params.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 0074d29c9b80..4b43baaf7c83 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -763,7 +763,7 @@ void destroy_params(const struct kernel_param *params, unsigned num)
 			params[i].ops->free(params[i].arg);
 }
 
-static struct module_kobject * __init locate_module_kobject(const char *name)
+static struct module_kobject * __init lookup_or_create_module_kobject(const char *name)
 {
 	struct module_kobject *mk;
 	struct kobject *kobj;
@@ -805,10 +805,9 @@ static void __init kernel_add_sysfs_param(const char *name,
 	struct module_kobject *mk;
 	int err;
 
-	mk = locate_module_kobject(name);
+	mk = lookup_or_create_module_kobject(name);
 	if (!mk)
 		return;
-
 	/* We need to remove old parameters before adding more. */
 	if (mk->mp)
 		sysfs_remove_group(&mk->kobj, &mk->mp->grp);
@@ -876,7 +875,7 @@ static void __init version_sysfs_builtin(void)
 	int err;
 
 	for (vattr = __start___modver; vattr < __stop___modver; vattr++) {
-		mk = locate_module_kobject(vattr->module_name);
+		mk = lookup_or_create_module_kobject(vattr->module_name);
 		if (mk) {
 			err = sysfs_create_file(&mk->kobj, &vattr->mattr.attr);
 			WARN_ON_ONCE(err);
-- 
2.34.1

