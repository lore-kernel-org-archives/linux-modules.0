Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41421EB5F1;
	Thu, 27 Feb 2025 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682189; cv=none; b=TYOUrTnS8lRvoYuqPSF6wR9gnN96mvugCMFXW11qbcpcKECjCXVgut+XXqt3lQjQj/pzsK5arPkKiwV0YehhBWhe70OBXQuFg+rYjVwZ6fBtJL3GEsxeuU3XPgsko013pBoQcD0BJeD4yfXHx9/VpA2MJdAqNZ5VpJqUlqJN3Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682189; c=relaxed/simple;
	bh=zkUVQbXZA6UfRml83pvNEgbbiCOVrW+hq3234lsHr/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FtG4gwJFPHdpKle7bIBL4dveR90/HDxojkftJb8+Awwn5YPopVEmc1d/oxw59sC07xGzHWpX+TqPsm2QiNYcINfPUeCPszlPqYIls8E8U4/ukHL/Jnxt+L/YW/tfZBy3sRwaYf5Vst7vUrT0JFYo0JrQKUlHxdF+TxJy0xWqKGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WiFfz5sQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WiFfz5sQ"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4B50A210EAC0;
	Thu, 27 Feb 2025 10:49:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B50A210EAC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740682187;
	bh=e4CgCLqwxELPOdnQb3Zoj43eln0chDtI/SKnWIfVtfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WiFfz5sQjFVZRlZ9WYnbhtEIh/Uo08Mlwu7WCy4D+eiPUQc1pc6DHArghKpcOZdU0
	 phoIa9sLpERyzCfKT/kUVWrK+BkCCSwgon+umXbP7i9muxxYxUShBq/BkqMNARG+i4
	 BD/2xmkUud6Aqlsc+pjzwp20iWCldVe14GxSmFc8=
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
Subject: [PATCH v4 3/4] kernel: globalize lookup_or_create_module_kobject()
Date: Thu, 27 Feb 2025 10:49:29 -0800
Message-Id: <20250227184930.34163-4-shyamsaini@linux.microsoft.com>
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

lookup_or_create_module_kobject() is marked as static and __init,
to make it global drop static keyword.
Since this function can be called from non-init code, use __modinit
instead of __init, __modinit marker will make it __init if
CONFIG_MODULES is not defined.

Fixes: 96a1a2412acb ("kernel/params.c: defer most of param_sysfs_init() to late_initcall time")
Cc: stable@kernel.org
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 include/linux/module.h | 2 ++
 kernel/params.c        | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index d9a5183a9fe7..57044f2838be 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -162,6 +162,8 @@ extern void cleanup_module(void);
 #define __INITRODATA_OR_MODULE __INITRODATA
 #endif /*CONFIG_MODULES*/
 
+struct module_kobject *lookup_or_create_module_kobject(const char *name);
+
 /* Generic info of form tag = "info" */
 #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
 
diff --git a/kernel/params.c b/kernel/params.c
index 787662663e34..e668fc90b83e 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -760,7 +760,7 @@ void destroy_params(const struct kernel_param *params, unsigned num)
 			params[i].ops->free(params[i].arg);
 }
 
-static struct module_kobject * __init lookup_or_create_module_kobject(const char *name)
+struct module_kobject __modinit * lookup_or_create_module_kobject(const char *name)
 {
 	struct module_kobject *mk;
 	struct kobject *kobj;
-- 
2.34.1

