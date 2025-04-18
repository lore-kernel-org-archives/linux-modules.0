Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9536213E97
	for <linux-modules@vger.kernel.org>; Fri, 18 Apr 2025 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995057; cv=none; b=dXjUDYw58Mc4AxSwlBuI+GJL1KM+1CKXi5pcrRZ9U//U0Ep/W8dksfjQIx1SHNSzoEiL6YxWu0z2LOFpQZ0z1/RfCvqehZipzLOSb2AFkkltWu/WnMzcyRVOwmoeRwzhC2IjAlDgKjxvs/BGmcIiJqJkLXOlHy0anOKF1Z173Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995057; c=relaxed/simple;
	bh=WE+4kcegKFumEU2/cCwpl70p8Q1yafjeQmFvljLxkuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gciru5lFYDq1WuZKRJ0B79SdRdmNTHC1cl9Rjh9zgjMRAwYxqU2YfI2Kk5rURhMGovuZ6XIclhRZ97hL1b84sJ+9tRq6FvEIC37F6SFIWY/QIku1De/GZCtnGBduyTfmsH03DrghFBF9ehvF9o4qlWtIJnvz4sIYCRpv1U2ZjTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gfcTRceH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfcTRceH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744995054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IwYvfZYZHKsg0xrd3I7bSHuR9+QYC+M2RfO1isygVyE=;
	b=gfcTRceHHZVb8+FXlyozEzM/vWUjvVGPeTmyBZQFqDN5D3a7PUUfRpC4RgI45PxRDmbCYk
	tJYnrG7FBXkJHWJaq/tn05esEcRaoQLgPmu76LUQYbxSJ+bCiZws+rvl/G9RkTKZ9sj49l
	9RpJCH3pHMPqc88sCn/0YDNJVqoL5GE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-__br2OdSO92IMyOgKTTcsQ-1; Fri,
 18 Apr 2025 12:50:51 -0400
X-MC-Unique: __br2OdSO92IMyOgKTTcsQ-1
X-Mimecast-MFC-AGG-ID: __br2OdSO92IMyOgKTTcsQ_1744995049
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83A0319560BC;
	Fri, 18 Apr 2025 16:50:49 +0000 (UTC)
Received: from redhat.com (unknown [10.96.134.19])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 859611954B0B;
	Fri, 18 Apr 2025 16:50:48 +0000 (UTC)
From: "Herton R. Krzesinski" <herton@redhat.com>
To: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	samitolvanen@google.com,
	da.gomez@samsung.com,
	herton@redhat.com,
	nathan@kernel.org
Subject: [PATCH v2] lib/test_kmod: do not hardcode/depend on any filesystem
Date: Fri, 18 Apr 2025 13:50:47 -0300
Message-ID: <20250418165047.702487-1-herton@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Right now test_kmod has hardcoded dependencies on btrfs/xfs. That
is not optimal since you end up needing to select/build them, but it
is not really required since other fs could be selected for the testing.
Also, we can't change the default/driver module used for testing on
initialization.

Thus make it more generic: introduce two module parameters (start_driver
and start_test_fs), which allow to select which modules/fs to use for
the testing on test_kmod initialization. Then it's up to the user to
select which modules/fs to use for testing based on his config. However,
keep test_module as required default.

This way, config/modules becomes selectable as when the testing is done
from selftests (userspace).

While at it, also change trigger_config_run_type, since at module
initialization we already set the defaults at __kmod_config_init and
should not need to do it again in test_kmod_init(), thus we can
avoid to again set test_driver/test_fs.

v2: also update tools/testing/selftests/kmod/config with the removed
dependencies.

Signed-off-by: Herton R. Krzesinski <herton@redhat.com>
---
 lib/Kconfig.debug                   |  6 ---
 lib/test_kmod.c                     | 64 +++++++++++++++--------------
 tools/testing/selftests/kmod/config |  5 ---
 3 files changed, 34 insertions(+), 41 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9fe4d8dfe578..1e0f8cbf0365 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2983,13 +2983,7 @@ config TEST_DYNAMIC_DEBUG
 config TEST_KMOD
 	tristate "kmod stress tester"
 	depends on m
-	depends on NETDEVICES && NET_CORE && INET # for TUN
-	depends on BLOCK
-	depends on PAGE_SIZE_LESS_THAN_256KB # for BTRFS
 	select TEST_LKM
-	select XFS_FS
-	select TUN
-	select BTRFS_FS
 	help
 	  Test the kernel's module loading mechanism: kmod. kmod implements
 	  support to load modules using the Linux kernel's usermode helper.
diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index 064ed0fce75a..f0dd092860ea 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -28,14 +28,20 @@
 
 #define TEST_START_NUM_THREADS	50
 #define TEST_START_DRIVER	"test_module"
-#define TEST_START_TEST_FS	"xfs"
 #define TEST_START_TEST_CASE	TEST_KMOD_DRIVER
 
-
 static bool force_init_test = false;
-module_param(force_init_test, bool_enable_only, 0644);
+module_param(force_init_test, bool_enable_only, 0444);
 MODULE_PARM_DESC(force_init_test,
 		 "Force kicking a test immediately after driver loads");
+static char *start_driver;
+module_param(start_driver, charp, 0444);
+MODULE_PARM_DESC(start_driver,
+		 "Module/driver to use for the testing after driver loads");
+static char *start_test_fs;
+module_param(start_test_fs, charp, 0444);
+MODULE_PARM_DESC(start_test_fs,
+		 "File system to use for the testing after driver loads");
 
 /*
  * For device allocation / registration
@@ -508,6 +514,11 @@ static int __trigger_config_run(struct kmod_test_device *test_dev)
 	case TEST_KMOD_DRIVER:
 		return run_test_driver(test_dev);
 	case TEST_KMOD_FS_TYPE:
+		if (!config->test_fs) {
+			dev_warn(test_dev->dev,
+				 "No fs type specified, can't run the test\n");
+			return -EINVAL;
+		}
 		return run_test_fs_type(test_dev);
 	default:
 		dev_warn(test_dev->dev,
@@ -721,26 +732,20 @@ static ssize_t config_test_fs_show(struct device *dev,
 static DEVICE_ATTR_RW(config_test_fs);
 
 static int trigger_config_run_type(struct kmod_test_device *test_dev,
-				   enum kmod_test_case test_case,
-				   const char *test_str)
+				   enum kmod_test_case test_case)
 {
-	int copied = 0;
 	struct test_config *config = &test_dev->config;
 
 	mutex_lock(&test_dev->config_mutex);
 
 	switch (test_case) {
 	case TEST_KMOD_DRIVER:
-		kfree_const(config->test_driver);
-		config->test_driver = NULL;
-		copied = config_copy_test_driver_name(config, test_str,
-						      strlen(test_str));
 		break;
 	case TEST_KMOD_FS_TYPE:
-		kfree_const(config->test_fs);
-		config->test_fs = NULL;
-		copied = config_copy_test_fs(config, test_str,
-					     strlen(test_str));
+		if (!config->test_fs) {
+			mutex_unlock(&test_dev->config_mutex);
+			return 0;
+		}
 		break;
 	default:
 		mutex_unlock(&test_dev->config_mutex);
@@ -751,11 +756,6 @@ static int trigger_config_run_type(struct kmod_test_device *test_dev,
 
 	mutex_unlock(&test_dev->config_mutex);
 
-	if (copied <= 0 || copied != strlen(test_str)) {
-		test_dev->test_is_oom = true;
-		return -ENOMEM;
-	}
-
 	test_dev->test_is_oom = false;
 
 	return trigger_config_run(test_dev);
@@ -800,19 +800,24 @@ static unsigned int kmod_init_test_thread_limit(void)
 static int __kmod_config_init(struct kmod_test_device *test_dev)
 {
 	struct test_config *config = &test_dev->config;
+	const char *test_start_driver = start_driver ? start_driver :
+						       TEST_START_DRIVER;
 	int ret = -ENOMEM, copied;
 
 	__kmod_config_free(config);
 
-	copied = config_copy_test_driver_name(config, TEST_START_DRIVER,
-					      strlen(TEST_START_DRIVER));
-	if (copied != strlen(TEST_START_DRIVER))
+	copied = config_copy_test_driver_name(config, test_start_driver,
+					      strlen(test_start_driver));
+	if (copied != strlen(test_start_driver))
 		goto err_out;
 
-	copied = config_copy_test_fs(config, TEST_START_TEST_FS,
-				     strlen(TEST_START_TEST_FS));
-	if (copied != strlen(TEST_START_TEST_FS))
-		goto err_out;
+
+	if (start_test_fs) {
+		copied = config_copy_test_fs(config, start_test_fs,
+					     strlen(start_test_fs));
+		if (copied != strlen(start_test_fs))
+			goto err_out;
+	}
 
 	config->num_threads = kmod_init_test_thread_limit();
 	config->test_result = 0;
@@ -1178,12 +1183,11 @@ static int __init test_kmod_init(void)
 	 * lowering the init level for more fun.
 	 */
 	if (force_init_test) {
-		ret = trigger_config_run_type(test_dev,
-					      TEST_KMOD_DRIVER, "tun");
+		ret = trigger_config_run_type(test_dev, TEST_KMOD_DRIVER);
 		if (WARN_ON(ret))
 			return ret;
-		ret = trigger_config_run_type(test_dev,
-					      TEST_KMOD_FS_TYPE, "btrfs");
+
+		ret = trigger_config_run_type(test_dev, TEST_KMOD_FS_TYPE);
 		if (WARN_ON(ret))
 			return ret;
 	}
diff --git a/tools/testing/selftests/kmod/config b/tools/testing/selftests/kmod/config
index 259f4fd6b5e2..1f1e63494af9 100644
--- a/tools/testing/selftests/kmod/config
+++ b/tools/testing/selftests/kmod/config
@@ -1,7 +1,2 @@
 CONFIG_TEST_KMOD=m
 CONFIG_TEST_LKM=m
-CONFIG_XFS_FS=m
-
-# For the module parameter force_init_test is used
-CONFIG_TUN=m
-CONFIG_BTRFS_FS=m
-- 
2.47.1

