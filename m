Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38973093B8
	for <linux-modules@vger.kernel.org>; Fri, 27 Mar 2026 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774617853; cv=none; b=bDQiN+yFKCaR77SwTX3YQd/7AhCFp2RHvgHPQ5SPd7nIAXPCl1xJiw1ZKBQhehqSVO7CgkEp9k+k9MfVM84YwLJw8aTL8HpiCIN0L7vc6zOBCJwuavg7N0GjbNPp7kjTML/XNxXT5jOimsr33kJNSbD3MckUxl59Cw/hAH00mQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774617853; c=relaxed/simple;
	bh=gB0i7nsxXUeq9tY4oOg0whotF78mMCOWdZ3tnpBwklE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGB/qkt60bKjswqSPr2DdBAU82XYgPR6C4Nd9w57yzhsipZ8q4tYCjOi5V+U6byjdzMhAATw7deToWWhyjQfoMnc6UcIwqgmot5YEcBXlBU9XO0BYD3jiMlxGIbggb4Tw6KinKF1W9O+FlOSKw0/WsQnHqUWGyfTmQkbh22eR4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=O3Jr5Fya; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="O3Jr5Fya"
Received: from mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:494f:0:640:ed81:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id 42C99C46FA;
	Fri, 27 Mar 2026 16:24:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id VNWFBvIGsqM0-gCm9Q4UP;
	Fri, 27 Mar 2026 16:23:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1774617839; bh=0CwSYhkBgGiuGEbyJhnvf326GHQvt0d27IOFTpLoYY8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=O3Jr5Fya7RBtj7KPYzeU+KfDKBUx/RBtEHK7WJc+aSGbT0BYh3rbSxhrJMQLE/qH2
	 yUer01GGcSEKeaDZ9qKEiojJkPJQTM2MpnvoADartD9zF3fKgtPaz/TEcXQKDXmG4F
	 NxY/aXtgITNLJKq1BI7k/66go12xIg6y2HOjIunY=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: linux-modules@vger.kernel.org,
	linux-mm@kvack.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [RFC PATCH] modules: extend {kstrdup,kfree}_const() to handle per-module .rodata
Date: Fri, 27 Mar 2026 16:22:47 +0300
Message-ID: <20260327132247.861984-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since kernel modules has their own .rodata sections, functions like
'kstrdup_const()' called from the module context are not required to
copy string constants from these sections. Likewise, 'kfree_const()'
in such a context becomes a no-op also because the whole module's
.rodata is freed at module unloading. OTOH this proof-of-concept
implementation introduces substantial overhead due to calls to
'__module_address()' from 'is_module_rodata()', which is much slower
than 'is_kernel_rodata()'. Anyway, comments are highly appreciated.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 include/linux/module.h | 6 ++++++
 kernel/module/main.c   | 9 +++++++++
 mm/util.c              | 7 +++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 14f391b186c6..7edaf2b730ce 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -623,6 +623,7 @@ bool is_module_address(unsigned long addr);
 bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
 bool is_module_percpu_address(unsigned long addr);
 bool is_module_text_address(unsigned long addr);
+bool is_module_rodata(unsigned long addr);
 
 static inline bool within_module_mem_type(unsigned long addr,
 					  const struct module *mod,
@@ -807,6 +808,11 @@ static inline bool is_module_text_address(unsigned long addr)
 	return false;
 }
 
+static inline bool is_module_rodata(unsigned long addr)
+{
+	return false;
+}
+
 static inline bool within_module_core(unsigned long addr,
 				      const struct module *mod)
 {
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c3ce106c70af..5003cacd0786 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3858,6 +3858,15 @@ bool is_module_text_address(unsigned long addr)
 	return __module_text_address(addr) != NULL;
 }
 
+bool is_module_rodata(unsigned long addr)
+{
+	struct module *mod;
+
+	guard(rcu)();
+	mod = __module_address(addr);
+	return mod && within_module_mem_type(addr, mod, MOD_RODATA);
+}
+
 void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
 {
 	struct module *mod;
diff --git a/mm/util.c b/mm/util.c
index b05ab6f97e11..8dd1f1e95554 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -26,6 +26,7 @@
 #include <linux/compat.h>
 #include <linux/fsnotify.h>
 #include <linux/page_idle.h>
+#include <linux/module.h>
 
 #include <linux/uaccess.h>
 
@@ -42,7 +43,8 @@
  */
 void kfree_const(const void *x)
 {
-	if (!is_kernel_rodata((unsigned long)x))
+	if (!is_kernel_rodata((unsigned long)x) &&
+	    !is_module_rodata((unsigned long)x))
 		kfree(x);
 }
 EXPORT_SYMBOL(kfree_const);
@@ -98,7 +100,8 @@ EXPORT_SYMBOL(kstrdup);
  */
 const char *kstrdup_const(const char *s, gfp_t gfp)
 {
-	if (is_kernel_rodata((unsigned long)s))
+	if (is_kernel_rodata((unsigned long)s) ||
+	    is_module_rodata((unsigned long)s))
 		return s;
 
 	return kstrdup(s, gfp);
-- 
2.53.0

