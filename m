Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4A91DE886;
	Thu, 27 Feb 2025 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682188; cv=none; b=Op6wiO+h2LFCRV/w4QMcNad3c2mPMKBlgfWa9TCDzA0w8/HtZFYc+9EQpUyhMYV8dKqDK8a849p+CQR24l/wj2Ilz7p4Xln7PYdmNmYcaRFJptfji1kMUKfNTwuYCJL8aoLLJGQ8f4zEQ4wrO8qzZ++vZLqBePCTGsVK/Ea/C6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682188; c=relaxed/simple;
	bh=NEW9Kvhv6AVv9x0tekY0QTVLhcvPWgHGgDjM6sfxuCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ISgBSKI/+B6aE0ThJC98HFqu0VSYnnXsxVrAXFxz6JlXKU5IoNww6EsWFrQr8fhDGrzYbf7Wz6MMR14Ch1HU6ldzqqRdEH4zj5xfA0c14R7uFSjM1oG9hByw0Y4t4j9lH7r8qM7sbK1j4qS0e2Ihb0oeejwfzz16TJTMvLUvN+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OcxiKY9k; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OcxiKY9k"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 72F55210D0F3;
	Thu, 27 Feb 2025 10:49:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 72F55210D0F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740682186;
	bh=y7FfcfW6l/ZYQyE7FEoc8vaQMcyZEY9fzM18x7DEGCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OcxiKY9kbm9LJFh2KWq4mBi33/wIaBChboDG7Bs/Sp5DYvpTD8CwKxg9Hrvw6myDK
	 YB1YESvfNfyS5Hr2D3CcpQxEfxxdB7y07WpDTP4k8aP4kB+qp50A264eaKZH5K8Sf9
	 v4RtkGqM+qKrldrwP3E7oBwgysceygUKlIn++jII=
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
Subject: [PATCH v4 1/4] kernel: param: rename locate_module_kobject
Date: Thu, 27 Feb 2025 10:49:27 -0800
Message-Id: <20250227184930.34163-2-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227184930.34163-1-shyamsaini@linux.microsoft.com>
References: <20250227184930.34163-1-shyamsaini@linux.microsoft.com>
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

Fixes: 96a1a2412acb ("kernel/params.c: defer most of param_sysfs_init() to late_initcall time")
Cc: stable@kernel.org
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 kernel/params.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 2509f216c9f3..a2441ce059ae 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -760,7 +760,7 @@ void destroy_params(const struct kernel_param *params, unsigned num)
 			params[i].ops->free(params[i].arg);
 }
 
-static struct module_kobject * __init locate_module_kobject(const char *name)
+static struct module_kobject * __init lookup_or_create_module_kobject(const char *name)
 {
 	struct module_kobject *mk;
 	struct kobject *kobj;
@@ -802,7 +802,7 @@ static void __init kernel_add_sysfs_param(const char *name,
 	struct module_kobject *mk;
 	int err;
 
-	mk = locate_module_kobject(name);
+	mk = lookup_or_create_module_kobject(name);
 	if (!mk)
 		return;
 
@@ -873,7 +873,7 @@ static void __init version_sysfs_builtin(void)
 	int err;
 
 	for (vattr = __start___modver; vattr < __stop___modver; vattr++) {
-		mk = locate_module_kobject(vattr->module_name);
+		mk = lookup_or_create_module_kobject(vattr->module_name);
 		if (mk) {
 			err = sysfs_create_file(&mk->kobj, &vattr->mattr.attr);
 			WARN_ON_ONCE(err);
-- 
2.34.1

