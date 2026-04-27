Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [211.125.139.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFFA32695F;
	Mon, 27 Apr 2026 02:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777257741; cv=none; b=e7OIy24ZR/GZhk7RC/WTPKdpvswZpj7HbgMnj7S1nd7c8PgLZj+LK+0oA87n77dliAdcFsKaptZhJF+bUFPZgfy/39e/7IvB0vb5HlZgmW5BhE3loXmZRZ/mVnI+LCIk0VUUeQyw6SVuCpu0dAsxp9DXTaIl9IidRUpCUqNkqik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777257741; c=relaxed/simple;
	bh=McKmRd1+Lo18DKCybZFxap3kme/nTmBld+wIUrdjyzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CIgxyB4WSHVOkFYbsr9Avg9npAAOtvZfMLHm66fjcqpsQAQYMrih3/S3s27q+KQA/4ROztwY4ELIKNZCdC575miw17+hEceCo2younO8V4pn+q/PgvnRvnQuf5cCCyvtEzl4zmOp1nV/pLYlz08eRS7FH84JLu0zIi4CyMlZe3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=LFLzvzH3; arc=none smtp.client-ip=211.125.139.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="LFLzvzH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1777257738; x=1808793738;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=sE3kgNN3imuWW8hZNcKI+XXyp7KMJ221snrHqXZwehc=;
  b=LFLzvzH3xT7WvsutvC1vryHhdaaK+c59lWZfwQj9sUpSFSHTofbiynwd
   EeuOn7c9BzDHDcKd02twratnrcoc4LBROjBQKYaqNAZWoxGbf86jy/y21
   CdUji7fnfuYt2dWSvdoV9WOtzfrphjNUKxQW8+LpAB4nCS/uiIVLDrlto
   k0IwgeTCYYdFeqGVty05xF1ECvqrKp/P/flO/ul+zkMffrnLkq0ZahoQv
   k5j/+069/fKjMDhhI8sEoAme/Ia6RYkczIKNZXPf3t8oH8ELdK47q7v/C
   QwpUYInVtmprbY//72G69VGY27onHLoHW+jeHZblCPeqVZkjFXVxVg3be
   g==;
X-CSE-ConnectionGUID: utbI0cNWQuiwEtJGX669wQ==
X-CSE-MsgGUID: +DuhioqIQrWG++sngv3Lfg==
Received: from unknown (HELO jpmta-ob02-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::7])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:42:05 +0900
X-CSE-ConnectionGUID: 7HUeG7JaR32fPxS0uugJNQ==
X-CSE-MsgGUID: eOsZfxyWTs2J2kChy1QIog==
X-IronPort-AV: E=Sophos;i="6.23,201,1770562800"; 
   d="scan'208";a="52275256"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:eb3e:119e])
  by jpmta-ob02-os7.noc.sony.co.jp with ESMTP; 27 Apr 2026 11:42:04 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Date: Mon, 27 Apr 2026 11:41:22 +0900
Subject: [PATCH v4 2/4] coresight: pass THIS_MODULE implicitly through a
 macro
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-acpi_mod_name-v4-2-22b42240c9bf@sony.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8244;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=McKmRd1+Lo18DKCybZFxap3kme/nTmBld+wIUrdjyzs=;
 b=owGbwMvMwCU2bX1+URVTXyjjabUkhsx3Z34yPONbtepKVIh3pMbDW2YcLw+qfL9xbkfIXMePh
 wXn5Tt5d5SyMIhxMciKKbKUKlX/2rsiaEnPmdeKMHNYmcCGcHEKwER6qxgZzgr/rWPk7mUod53R
 xWF3gf/afmnG6GdS/AfuHuELUTdYxcgwcbkrbyy3yIRpGXf5ctefnvJK9Ovz9GP/K9K7tovoHXr
 IAgA=
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=75227BFABDA852A48CCCEB2196AF6F727A028E55

Rename coresight_init_driver() to __coresight_init_driver() and replace
it with a macro wrapper that passes THIS_MODULE implicitly. This is in line with
what other buses do.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Co-developed-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 drivers/hwtracing/coresight/coresight-catu.c       | 2 +-
 drivers/hwtracing/coresight/coresight-core.c       | 4 ++--
 drivers/hwtracing/coresight/coresight-cpu-debug.c  | 3 +--
 drivers/hwtracing/coresight/coresight-funnel.c     | 3 +--
 drivers/hwtracing/coresight/coresight-replicator.c | 3 +--
 drivers/hwtracing/coresight/coresight-stm.c        | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-core.c   | 2 +-
 drivers/hwtracing/coresight/coresight-tnoc.c       | 2 +-
 drivers/hwtracing/coresight/coresight-tpdm.c       | 3 +--
 drivers/hwtracing/coresight/coresight-tpiu.c       | 2 +-
 include/linux/coresight.h                          | 4 +++-
 11 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index ce71dcddfca2..0c8698c8fc5e 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -706,7 +706,7 @@ static int __init catu_init(void)
 {
 	int ret;
 
-	ret = coresight_init_driver("catu", &catu_driver, &catu_platform_driver, THIS_MODULE);
+	ret = coresight_init_driver("catu", &catu_driver, &catu_platform_driver);
 	tmc_etr_set_catu_ops(&etr_catu_buf_ops);
 	return ret;
 }
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 46f247f73cf6..4ebcbd95b7fb 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1694,7 +1694,7 @@ static void __exit coresight_exit(void)
 module_init(coresight_init);
 module_exit(coresight_exit);
 
-int coresight_init_driver(const char *drv, struct amba_driver *amba_drv,
+int __coresight_init_driver(const char *drv, struct amba_driver *amba_drv,
 			  struct platform_driver *pdev_drv, struct module *owner)
 {
 	int ret;
@@ -1713,7 +1713,7 @@ int coresight_init_driver(const char *drv, struct amba_driver *amba_drv,
 	amba_driver_unregister(amba_drv);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(coresight_init_driver);
+EXPORT_SYMBOL_GPL(__coresight_init_driver);
 
 void coresight_remove_driver(struct amba_driver *amba_drv,
 			     struct platform_driver *pdev_drv)
diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 629614278e46..3a806c1d50ea 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -757,8 +757,7 @@ static struct platform_driver debug_platform_driver = {
 
 static int __init debug_init(void)
 {
-	return coresight_init_driver("debug", &debug_driver, &debug_platform_driver,
-				     THIS_MODULE);
+	return coresight_init_driver("debug", &debug_driver, &debug_platform_driver);
 }
 
 static void __exit debug_exit(void)
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 3f56ceccd8c9..0abc11f0690c 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -412,8 +412,7 @@ static struct amba_driver dynamic_funnel_driver = {
 
 static int __init funnel_init(void)
 {
-	return coresight_init_driver("funnel", &dynamic_funnel_driver, &funnel_driver,
-				     THIS_MODULE);
+	return coresight_init_driver("funnel", &dynamic_funnel_driver, &funnel_driver);
 }
 
 static void __exit funnel_exit(void)
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 07fc04f53b88..2f382de357ee 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -418,8 +418,7 @@ static struct amba_driver dynamic_replicator_driver = {
 
 static int __init replicator_init(void)
 {
-	return coresight_init_driver("replicator", &dynamic_replicator_driver, &replicator_driver,
-				     THIS_MODULE);
+	return coresight_init_driver("replicator", &dynamic_replicator_driver, &replicator_driver);
 }
 
 static void __exit replicator_exit(void)
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index aca6cec7885a..4e860519a73f 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -1050,7 +1050,7 @@ static struct platform_driver stm_platform_driver = {
 
 static int __init stm_init(void)
 {
-	return coresight_init_driver("stm", &stm_driver, &stm_platform_driver, THIS_MODULE);
+	return coresight_init_driver("stm", &stm_driver, &stm_platform_driver);
 }
 
 static void __exit stm_exit(void)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index c89fe996af23..bc5a133ada3e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -1046,7 +1046,7 @@ static struct platform_driver tmc_platform_driver = {
 
 static int __init tmc_init(void)
 {
-	return coresight_init_driver("tmc", &tmc_driver, &tmc_platform_driver, THIS_MODULE);
+	return coresight_init_driver("tmc", &tmc_driver, &tmc_platform_driver);
 }
 
 static void __exit tmc_exit(void)
diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
index 96a25877b824..9e8de4323d28 100644
--- a/drivers/hwtracing/coresight/coresight-tnoc.c
+++ b/drivers/hwtracing/coresight/coresight-tnoc.c
@@ -344,7 +344,7 @@ static struct platform_driver itnoc_driver = {
 
 static int __init tnoc_init(void)
 {
-	return coresight_init_driver("tnoc", &trace_noc_driver, &itnoc_driver, THIS_MODULE);
+	return coresight_init_driver("tnoc", &trace_noc_driver, &itnoc_driver);
 }
 
 static void __exit tnoc_exit(void)
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index eaf7210af648..8464edbba2d4 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -1563,8 +1563,7 @@ static struct platform_driver static_tpdm_driver = {
 
 static int __init tpdm_init(void)
 {
-	return coresight_init_driver("tpdm", &dynamic_tpdm_driver, &static_tpdm_driver,
-				     THIS_MODULE);
+	return coresight_init_driver("tpdm", &dynamic_tpdm_driver, &static_tpdm_driver);
 }
 
 static void __exit tpdm_exit(void)
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index b8560b140e0f..7b029d2eb389 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -310,7 +310,7 @@ static struct platform_driver tpiu_platform_driver = {
 
 static int __init tpiu_init(void)
 {
-	return coresight_init_driver("tpiu", &tpiu_driver, &tpiu_platform_driver, THIS_MODULE);
+	return coresight_init_driver("tpiu", &tpiu_driver, &tpiu_platform_driver);
 }
 
 static void __exit tpiu_exit(void)
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 2131febebee9..b9ec5f195907 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -691,7 +691,9 @@ coresight_find_output_type(struct coresight_platform_data *pdata,
 			   enum coresight_dev_type type,
 			   union coresight_dev_subtype subtype);
 
-int coresight_init_driver(const char *drv, struct amba_driver *amba_drv,
+#define coresight_init_driver(drv, amba_drv, pdev_drv) \
+	__coresight_init_driver(drv, amba_drv, pdev_drv, THIS_MODULE)
+int __coresight_init_driver(const char *drv, struct amba_driver *amba_drv,
 			  struct platform_driver *pdev_drv, struct module *owner);
 
 void coresight_remove_driver(struct amba_driver *amba_drv,

-- 
2.43.0

