Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC2F27990C
	for <linux-modules@vger.kernel.org>; Tue,  6 May 2025 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530331; cv=none; b=IMuG4/vh09GbziWjCNf1MqQM6h2ErjeN2/NBlo9njQSoS6bAeDVgRtRTX+7POLWHyg/LXVJVriqKues4kuTIMn7O809eD9DfbxDy4YdYuS16hObjXi6jygv4Yexw105YJAMyOm0JOHQDYPZT/6omlq8XeFPBUaByzUK/p+EowSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530331; c=relaxed/simple;
	bh=YVk29pr4jxdTxuOL5/uKItZoROJiA9b9HABqIaoG4dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gEZFmuGTFbucvmAGSv+Q9J43Nv93ZnXHqbmC72prcwXRrh37W4bBlXACSWu/zGBvPHDJ7K4jjgYKkZtQL9HD7C+C9W3na81QuY8sK3u7ASypenIPxJLi36Ldt417ux44x8a47WvdFSIRKWJl87i5ZsdqeedUDmpvfugrdLyRP7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=fVcfaAZv; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="fVcfaAZv"
Received: from mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:2ca6:0:640:bc98:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 356E660AE7;
	Tue,  6 May 2025 14:18:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id aIaYHl0Ll4Y0-5bCcLZ7J;
	Tue, 06 May 2025 14:18:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1746530319; bh=a5fsHHJiZVYEhDHu9ZOaaeBNoaRTfCgya5lUq8I4gAo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=fVcfaAZvVnPMzojVK+DYQYlRCRYDk8I/YXI1+8g2Zw18bkaS0pCBD3hB1693ouTHO
	 o9mKzxFj5EUdvlHtxly38gIQt5ETXoSBdPOhkazu8Ij1xqsWhtvYKJQzluUmwkGBLr
	 5pt8iM2YEk25xYLLevBvw1OG9bpDBpzcpzvz7I2A=
Authentication-Results: mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	linux-modules@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+7fb8a372e1f6add936dd@syzkaller.appspotmail.com
Subject: [PATCH] kernel: fix error handling in lookup_or_create_module_kobject()
Date: Tue,  6 May 2025 14:17:42 +0300
Message-ID: <20250506111742.3109640-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'lookup_or_create_module_kobject()', an internal kobject is created
using 'module_ktype'. So plain 'kobject_put()' causes an attempt to use
an uninitialied completion pointer in 'module_kobject_release()' and
'mod_kobject_put()' should be used instead. But if the driver (e.g. USB
gadget as in this particular case reported by syzkaller) is configured
as compiled-in, THIS_MODULE is NULL and there is no relevant module
object to call the latter against. So introduce an internal wrapper
'__module_kobject_put()' which is expected 'struct module_kobject' and
so fix error handling in 'lookup_or_create_module_kobject()'.

Reported-by: syzbot+7fb8a372e1f6add936dd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7fb8a372e1f6add936dd
Fixes: 1c7777feb0e2 ("kernel: refactor lookup_or_create_module_kobject()")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 include/linux/module.h |  3 +++
 kernel/module/sysfs.c  | 15 ++++++++++-----
 kernel/params.c        |  3 ++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index b3329110d668..2b4ab389c1bc 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -891,6 +891,9 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
 #ifdef CONFIG_SYSFS
 extern struct kset *module_kset;
 extern const struct kobj_type module_ktype;
+void __module_kobject_put(struct module_kobject *mkobj);
+#else /* not CONFIG_SYSFS */
+static inline void __module_kobject_put(struct module_kobject *mkobj) { }
 #endif /* CONFIG_SYSFS */
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index b401ff4b02d2..7519920f4f55 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -323,11 +323,7 @@ static int module_add_modinfo_attrs(struct module *mod)
 
 static void mod_kobject_put(struct module *mod)
 {
-	DECLARE_COMPLETION_ONSTACK(c);
-
-	mod->mkobj.kobj_completion = &c;
-	kobject_put(&mod->mkobj.kobj);
-	wait_for_completion(&c);
+	__module_kobject_put(&mod->mkobj);
 }
 
 static int mod_sysfs_init(struct module *mod)
@@ -362,6 +358,15 @@ static int mod_sysfs_init(struct module *mod)
 	return err;
 }
 
+void __module_kobject_put(struct module_kobject *mkobj)
+{
+	DECLARE_COMPLETION_ONSTACK(c);
+
+	mkobj->kobj_completion = &c;
+	kobject_put(&mkobj->kobj);
+	wait_for_completion(&c);
+}
+
 int mod_sysfs_setup(struct module *mod,
 		    const struct load_info *info,
 			   struct kernel_param *kparam,
diff --git a/kernel/params.c b/kernel/params.c
index e668fc90b83e..2cf1f17840e0 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -780,7 +780,8 @@ struct module_kobject __modinit * lookup_or_create_module_kobject(const char *na
 	if (IS_ENABLED(CONFIG_MODULES) && !err)
 		err = sysfs_create_file(&mk->kobj, &module_uevent.attr);
 	if (err) {
-		kobject_put(&mk->kobj);
+		/* Not 'mod_kobject_put()' because THIS_MODULE may be NULL. */
+		__module_kobject_put(mk);
 		pr_crit("Adding module '%s' to sysfs failed (%d), the system may be unstable.\n",
 			name, err);
 		return NULL;
-- 
2.49.0

