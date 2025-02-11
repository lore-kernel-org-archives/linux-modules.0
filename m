Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27C32676DC;
	Tue, 11 Feb 2025 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310589; cv=none; b=JUwT3wfkwpnU8d8MGavQRlLHz16NxZbZYSl2MZ/ax77h8DgEsaXZBtf+Mgxzu+KUXviu/YkbNePJxzmlfTfwYKCdYXVDEjweedQHWBCDFMTJKAEDT0XlaerfnkRDfolf/zPeq79J35bM9nGYzTXtCfKWrn5+D8tkpOwdvRsTnj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310589; c=relaxed/simple;
	bh=i8qGikLjsH6XlE1U6wYSjOj/XPM/2vdBaBXdq55VsiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m0w6o+9oDwAqj0zf1ZuYGiZsBSDBWoDloU/01AQnoNr7I/VcCzS8O1/pm5gJ5TtN+HPKn9+ZlWzxw6Py6HYoeKw1RLc2XJTL5XGrxWmwK1aJvwuaYJC+waWTGTqE+Uc1pchedmQsxvB/YFOL7YsJjWIM2PQvFVNzgQcAagF14IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ELcehVbe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ELcehVbe"
Received: from thinkpad-p16sg1.. (d66-183-104-158.bchsia.telus.net [66.183.104.158])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0C45A2107AB2;
	Tue, 11 Feb 2025 13:49:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0C45A2107AB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739310587;
	bh=iaV/F7Xzowo/6Ktj0hPa5MUS5KH+gVRqXjzycDnnDws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ELcehVbe2hh23WvfQVJjN+hRGt5fTWqdyzK87PcJsoi6jPUvIYbNvZ+ikiCbVsPqK
	 eRKOWybeb0r0D4ihoTXXiwNf3xxP4cUiwSBaZj2kzcaA70B4rQVnT4VhKhBoPZ/qQa
	 gK8Y0LN4MaUOXzi8X3+Lx0ig4UFhg5OhPMyDLnB0=
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
Subject: [PATCH v3 1/4] kernel: param: rename locate_module_kobject
Date: Tue, 11 Feb 2025 13:48:39 -0800
Message-Id: <20250211214842.1806521-2-shyamsaini@linux.microsoft.com>
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

The locate_module_kobject() function looks up an existing
module_kobject for a given module name. If it cannot find the
corresponding module_kobject, it creates one for the given name.

This commit renames locate_module_kobject() to
lookup_or_create_module_kobject() to better describe its operations.

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

