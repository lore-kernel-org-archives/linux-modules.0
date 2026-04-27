Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [211.125.139.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8373264EA;
	Mon, 27 Apr 2026 02:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777257741; cv=none; b=DX8IFh4j6AbjuGIwfNXgaqa1FcBDLiZHDPEnmvzVSpi9fjhgU9fXlRH/d8NUocbF+a8/v5/csFOWE6vubLV/4QANYv0edUa5RM4F1RLzKkJ3ezaRmNFqL+Oz/cJXTBO8EOqgGqynzk6m7TlucrrNAcrlbcr9m51ac+SUgp9WEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777257741; c=relaxed/simple;
	bh=4FGEsKZVItFVh3wNPBycUa5qbrb/KXyEWcUvvYGRmTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LEMVvTYMAqhT+yAXiAc5X3Va/UbXnbIFCAvScRvF3yBYZYJtHoCtXOHDTZ+psbVCGh6IkWmcfUlxH2EM1hR9psccjwAnNe4bfjsN5QIZSjVxwinhgdrxsCpyTk55tgKp7aHviMqTv5BXjnPJv1tJq3KuUOk/lXEfgqP1/GWOIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=FitoFzXR; arc=none smtp.client-ip=211.125.139.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="FitoFzXR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1777257736; x=1808793736;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wwgvEYLWg4ZMf3xZuScEeBxUIZJiuxnz1K7s2O07bsk=;
  b=FitoFzXRopiCHWl6S3HztbbqImJ6J46jip6WWjk9rXCIaZTTKfKc8++t
   Ve3dKlUvOys+zjEVyPdgnAyo/AaSxbwnphMvfpCOB13IrzPHDo311Q91C
   Njml3EtIksQ9UjBcqPpPywLx1B8+eCkGPBy1FxyVXJcW2j0XRhC33ST9u
   yvLLBjue5DBUi0G/N1qYWFVrJzJTtHvCJManjYyJ3NvTc1w6zbz0s1C+9
   4ZGPB3nyFe9u23X+ClHTI1MA1pfyQVLekaahaS6+4PFNPrWgU/0ILMBvA
   I3OFHxLLDEVHtHdYkjvmsk2OGYYZBxbJ2pJBEPOvV+0VFkjFFxFJ+Li3V
   g==;
X-CSE-ConnectionGUID: DyLCiPLSR/6Z1EQCg3y6Sg==
X-CSE-MsgGUID: VanL0y6XQ7WCKlbCQlfHkA==
Received: from unknown (HELO jpmta-ob02-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::7])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:42:04 +0900
X-CSE-ConnectionGUID: 3gISxFTbRE6wRXgzByRNeQ==
X-CSE-MsgGUID: 2jQXR9N4SDWHcLwm1Lb4tg==
X-IronPort-AV: E=Sophos;i="6.23,201,1770562800"; 
   d="scan'208";a="52275253"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:eb3e:119e])
  by jpmta-ob02-os7.noc.sony.co.jp with ESMTP; 27 Apr 2026 11:42:03 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Date: Mon, 27 Apr 2026 11:41:21 +0900
Subject: [PATCH v4 1/4] kernel: param: initialize module_kset before
 do_initcalls()
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-acpi_mod_name-v4-1-22b42240c9bf@sony.com>
References: <20260427-acpi_mod_name-v4-0-22b42240c9bf@sony.com>
In-Reply-To: <20260427-acpi_mod_name-v4-0-22b42240c9bf@sony.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Mike Leach <mike.leach@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Mike Leach <mike.leach@arm.com>
Cc: Rahul Bukte <rahul.bukte@sony.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>, 
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
 Daniel Palmer <daniel.palmer@sony.com>, Tim Bird <tim.bird@sony.com>, 
 linux-modules@vger.kernel.org
X-Mailer: b4 0.16-dev-3bfbc
X-Developer-Signature: v=1; a=openpgp-sha256; l=3267;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=4FGEsKZVItFVh3wNPBycUa5qbrb/KXyEWcUvvYGRmTk=;
 b=owGbwMvMwCU2bX1+URVTXyjjabUkhsx3Z372X/GQFn/G+CwxnE2+ZN2+arfP4R0tjR9nbT/+N
 HinJqd1RykLgxgXg6yYIkupUvWvvSuClvScea0IM4eVCWQIAxenAEzEfAsjw/Jn1Zt/uwolbWX4
 eUZPJ7zz/nwmG4676TFGCRxtT7+332D4Z7fVe96ZkKBJ6ieTePemvi+sszoXW8p479qp4PMmbUr
 6jAA=
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=75227BFABDA852A48CCCEB2196AF6F727A028E55

module_kset is initialized in param_sysfs_init(), a subsys_initcall. A number
of platform drivers register themselves prior to subsys_initcalls
(tegra194_cbb_driver registers in a pure_initcall, for example). With an
upcoming patch ("driver core: platform: set mod_name in driver registration")
that sets their mod_name in struct device_driver, lookup_or_create_module_kobject()
will be called for those drivers, which calls kset_find_obj(module_kset, mod_name).
This causes a null deref because module_kset isn't alive yet.

Fix this by initializing module_kset in do_basic_setup() before do_initcalls().
Modernize the pr_warn while we're at it.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 include/linux/module.h |  4 ++++
 init/main.c            |  1 +
 kernel/params.c        | 21 +++++++++------------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..6478596e8f9f 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -886,6 +886,10 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
 #ifdef CONFIG_SYSFS
 extern struct kset *module_kset;
 extern const struct kobj_type module_ktype;
+
+void param_sysfs_init(void);
+#else
+static inline void param_sysfs_init(void) {}
 #endif /* CONFIG_SYSFS */
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
diff --git a/init/main.c b/init/main.c
index 96f93bb06c49..01552c6b62ff 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1486,6 +1486,7 @@ static void __init do_basic_setup(void)
 	ksysfs_init();
 	driver_init();
 	init_irq_proc();
+	param_sysfs_init();
 	do_ctors();
 	do_initcalls();
 }
diff --git a/kernel/params.c b/kernel/params.c
index 74d620bc2521..d1e3934fb3a7 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -942,22 +942,19 @@ const struct kobj_type module_ktype = {
 /*
  * param_sysfs_init - create "module" kset
  *
- * This must be done before the initramfs is unpacked and
- * request_module() thus becomes possible, because otherwise the
- * module load would fail in mod_sysfs_init.
+ * Must run before:
+ * - do_initcalls(): some drivers register during initcalls and rely on
+ *   module_kset existing for their sysfs module symlink.
+ * - rootfs_initcall (initramfs unpack): request_module() becomes possible.
+ *   But if module_kset is null, module load would fail in mod_sysfs_init(),
+ *   causing request_module() to fail.
  */
-static int __init param_sysfs_init(void)
+void __init param_sysfs_init(void)
 {
 	module_kset = kset_create_and_add("module", &module_uevent_ops, NULL);
-	if (!module_kset) {
-		printk(KERN_WARNING "%s (%d): error creating kset\n",
-			__FILE__, __LINE__);
-		return -ENOMEM;
-	}
-
-	return 0;
+	if (!module_kset)
+		pr_warn("Error creating module kset\n");
 }
-subsys_initcall(param_sysfs_init);
 
 /*
  * param_sysfs_builtin_init - add sysfs version and parameter

-- 
2.43.0

