Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B8E3081D6;
	Sat,  7 Mar 2026 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772874026; cv=none; b=HuFVPT3ws+Jke6K4dUbN5ResPW8wFb6LwhCLxv7c1hYQ52l+wK/kEq03ZTL1alK1Ye44n/VfZ5Ls+l6fi+XoT6bu7krtmr1TiWM3qYV6M7udJULQYcmSaWW1Lc2C+PpRRSgPVIt1y0v+LK4jvjvIUY+ZnR1mSNDSoggmQ0iUntc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772874026; c=relaxed/simple;
	bh=3Z272WYFtO5uGBnjs7PVCEN6ue8hLru9MIHqIwAzxpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmCrVF7bgKd8qTFJhZvT41f8ywwAqigmf1MloTvfrRpMs5s0y1/UEmmg34dB4ic/MulEOdRnFrH/HN/iLShK8GEvdgFP8DeApyOkzN5F6/o4PKMFfgVkskI3wPCwPIot9xAQQ1pm9FyTCUm3BHb7WNzAaYAP3v2SCCtJ5KU2ges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opensource.nslick.com; spf=none smtp.mailfrom=opensource.nslick.com; dkim=pass (2048-bit key) header.d=nslick.com header.i=@nslick.com header.b=VHXdamZ3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W9HnBZDG; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opensource.nslick.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=opensource.nslick.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nslick.com header.i=@nslick.com header.b="VHXdamZ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W9HnBZDG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9382C1D00278;
	Sat,  7 Mar 2026 04:00:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 07 Mar 2026 04:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nslick.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1772874023; x=
	1772960423; bh=L5R2K3GzCxY/Yqfz5ray4C4Nua3KsWSO21oO3oIVPj8=; b=V
	HXdamZ3hgKRR8D9hszEiPARZ6CzYYQ3IN/RxhwJPbNV66XbP1AXCEfMX547axYyA
	NsSGWOP2/FNPrjTNP1OPVSKZxB5tiXcKaBYw1BAtasj6eOPIJbfdGbdMUHDXb7N8
	3bCoZrAN0R6ybwEG9pyVisYNjEhJ22AeAW36TR4WbG1rnpYjxMrFQSY7rDsc79CN
	nQ5bYKPqeN2L+cIWtJMCH85n+2N+aHTzYX1FHfLWGsI64gi0qkyzBqEG1unnmgKc
	sU0TtjVXYtvGOiB2jyb6ewpkkxfihFII1+yedA19FDemHfBcpX4PubXbEvAs2n2R
	bScGFCYOTns7yEC9eQnbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1772874023; x=1772960423; bh=L
	5R2K3GzCxY/Yqfz5ray4C4Nua3KsWSO21oO3oIVPj8=; b=W9HnBZDGWkBO00GTM
	oZkrRLCQP0YkbkJQZAbGYGkaeD14FzmOlsxAY8fopr5LiJirFV1SkQ6doh3EqvAf
	hiQ8BcLWbxj1CaoLw5cvJfmoVe771M7bd5ADiZU6tJLdx/7yjdbkhHRXWVHKfQTU
	K2heuooF7i5Dn2XRWSBibuAbv7sIAA2VHHH0dU0aoikeV6sO1+c2bKfTMr8w2vCJ
	/XvGye8z5u9WpvI5q4ePqRIElKhHbuobPxsAeCLx0xdnS5idU9JmKxdG5pjQ/BgM
	pAxxugVGwsebk6DZS9vwIlnqYkl7/r5/azHKfpfPtfcLZCYiHOLZHscSkQlxj66F
	Eu9Tw==
X-ME-Sender: <xms:J-mradlmV5bfJTuJOMvcO5GQeQpdL8NGTjklIpdo9ot9QmYWElxSgQ>
    <xme:J-mraVNAisgrIxL_sV3dXWn3-Ed5DfiEerOu_LF3zEvDXkXceEWVr2APZPVbB_pPY
    -5zLR36-LxaDIL4DsTlUAbUpgFips1fE1SjzIefD3Wy4HPkrJmLibs>
X-ME-Received: <xmr:J-mraYGG5yGWtxBndShAKuRHXwcYakl0ZWNwglySMaBqR9q-xqDaNXoaoZU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedukedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheppfhitghhohhl
    rghsucfuihgvlhhitghkihcuoehlihhnuhigsehophgvnhhsohhurhgtvgdrnhhslhhitg
    hkrdgtohhmqeenucggtffrrghtthgvrhhnpeetudevkeeuvefghfetleehkeegudeigfel
    gffhtedvkeevgfekueelfeevfeelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehlihhnuhigsehophgvnhhsohhurhgtvgdrnhhslhhitghk
    rdgtohhmpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhgtghhrohhfsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtrhdrphgr
    vhhluhesshhushgvrdgtohhmpdhrtghpthhtohepuggrrdhgohhmvgiisehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsrghmihhtohhlvhgrnhgvnhesghhoohhglhgvrdgtohhm
    pdhrtghpthhtoheprghtohhmlhhinhesrghtohhmlhhinhdrtghomhdprhgtphhtthhope
    hmrggvnhhnihgthhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehi
    nhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpd
    hrtghpthhtohepshhkhhgrnheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:J-mrabs_jdaR9MTgpZOpgoCPX9AmQlvDw7Ps6ipRDjpy3B76b2vqMw>
    <xmx:J-mraYTEkNioB1CSSvqzCx3XLLASQdh6w7c-aFX_CeE7isx01J7vIw>
    <xmx:J-mraVNoSQNcpyVTPMWgEce8QAyfCyMn1zIS1n-cTyM2TbtARY6teg>
    <xmx:J-mraW4CqxSlsdwsukPkzCoxLdDwBsoJJ7Tj6VJgaxyyo_7S7oD9Aw>
    <xmx:J-mraa9Nw9wZqSR4puXzjGJxdSOL7_gpjCEA08CKj1Aa-LhNyqGRrCOD>
Feedback-ID: i78f146c6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Mar 2026 04:00:22 -0500 (EST)
From: Nicholas Sielicki <linux@opensource.nslick.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Matthias Maennich <maennich@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-modules@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicholas Sielicki <linux@opensource.nslick.com>
Subject: [PATCH v2 1/2] module: expose imported namespaces via sysfs
Date: Sat,  7 Mar 2026 03:00:09 -0600
Message-ID: <20260307090010.20828-2-linux@opensource.nslick.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307090010.20828-1-linux@opensource.nslick.com>
References: <20260307090010.20828-1-linux@opensource.nslick.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the only way for userspace to inspect the symbol
namespaces a module imports is to locate the .ko on disk and invoke
modinfo(8) to decompress/parse the metadata. The kernel validated
namespaces at load time, but it was otherwise discarded.

Add /sys/module/*/import_ns to expose imported namespaces for
currently loaded modules. The file contains one namespace per line and
only exists for modules that import at least one namespace.

Signed-off-by: Nicholas Sielicki <linux@opensource.nslick.com>
---
 Documentation/ABI/testing/sysfs-module |  9 ++++
 include/linux/module.h                 |  1 +
 kernel/module/main.c                   | 69 +++++++++++++++++++++++++-
 3 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-module b/Documentation/ABI/testing/sysfs-module
index 6bc9af6229f0..d5b7d19bd310 100644
--- a/Documentation/ABI/testing/sysfs-module
+++ b/Documentation/ABI/testing/sysfs-module
@@ -48,6 +48,15 @@ Contact:	Kay Sievers <kay.sievers@vrfy.org>
 Description:	Show the initialization state(live, coming, going) of
 		the module.
 
+What:		/sys/module/*/import_ns
+Date:		January 2026
+KernelVersion:	7.1
+Contact:	linux-modules@vger.kernel.org
+Description:	List of symbol namespaces imported by this module via
+		MODULE_IMPORT_NS(). Each namespace appears on a separate line.
+		This file only exists for modules that import at least one
+		namespace.
+
 What:		/sys/module/*/taint
 Date:		Jan 2012
 KernelVersion:	3.3
diff --git a/include/linux/module.h b/include/linux/module.h
index 14f391b186c6..60ed1c3e0ed9 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -413,6 +413,7 @@ struct module {
 	struct module_attribute *modinfo_attrs;
 	const char *version;
 	const char *srcversion;
+	const char *imported_namespaces;
 	struct kobject *holders_dir;
 
 	/* Exported symbols */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c3ce106c70af..53e421ff2ede 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -607,6 +607,36 @@ static const struct module_attribute modinfo_##field = {              \
 MODINFO_ATTR(version);
 MODINFO_ATTR(srcversion);
 
+static void setup_modinfo_import_ns(struct module *mod, const char *s)
+{
+	mod->imported_namespaces = NULL;
+}
+
+static ssize_t show_modinfo_import_ns(const struct module_attribute *mattr,
+				      struct module_kobject *mk, char *buffer)
+{
+	return sysfs_emit(buffer, "%s\n", mk->mod->imported_namespaces);
+}
+
+static int modinfo_import_ns_exists(struct module *mod)
+{
+	return mod->imported_namespaces != NULL;
+}
+
+static void free_modinfo_import_ns(struct module *mod)
+{
+	kfree(mod->imported_namespaces);
+	mod->imported_namespaces = NULL;
+}
+
+static const struct module_attribute modinfo_import_ns = {
+	.attr = { .name = "import_ns", .mode = 0444 },
+	.show = show_modinfo_import_ns,
+	.setup = setup_modinfo_import_ns,
+	.test = modinfo_import_ns_exists,
+	.free = free_modinfo_import_ns,
+};
+
 static struct {
 	char name[MODULE_NAME_LEN];
 	char taints[MODULE_FLAGS_BUF_SIZE];
@@ -1058,6 +1088,7 @@ const struct module_attribute *const modinfo_attrs[] = {
 	&module_uevent,
 	&modinfo_version,
 	&modinfo_srcversion,
+	&modinfo_import_ns,
 	&modinfo_initstate,
 	&modinfo_coresize,
 #ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
@@ -1760,11 +1791,43 @@ static void module_license_taint_check(struct module *mod, const char *license)
 	}
 }
 
+static int copy_modinfo_import_ns(struct module *mod, struct load_info *info)
+{
+	char *ns;
+	size_t len, total_len = 0;
+	char *buf, *p;
+
+	for_each_modinfo_entry(ns, info, "import_ns")
+		total_len += strlen(ns) + 1;
+
+	if (!total_len) {
+		mod->imported_namespaces = NULL;
+		return 0;
+	}
+
+	buf = kmalloc(total_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	p = buf;
+	for_each_modinfo_entry(ns, info, "import_ns") {
+		len = strlen(ns);
+		memcpy(p, ns, len);
+		p += len;
+		*p++ = '\n';
+	}
+	/* Replace trailing newline with null terminator. */
+	*(p - 1) = '\0';
+
+	mod->imported_namespaces = buf;
+	return 0;
+}
+
 static int setup_modinfo(struct module *mod, struct load_info *info)
 {
 	const struct module_attribute *attr;
 	char *imported_namespace;
-	int i;
+	int i, err;
 
 	for (i = 0; (attr = modinfo_attrs[i]); i++) {
 		if (attr->setup)
@@ -1783,6 +1846,10 @@ static int setup_modinfo(struct module *mod, struct load_info *info)
 		}
 	}
 
+	err = copy_modinfo_import_ns(mod, info);
+	if (err)
+		return err;
+
 	return 0;
 }
 
-- 
2.53.0

