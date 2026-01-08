Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E078F5B;
	Thu,  8 Jan 2026 04:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767847676; cv=none; b=DtDXZ3XZoO0DfHHjxzeCoOLMF/680IpbfYMg0kKD1KpPJYf9uDyIzcd9WMB9zpghMHLGxy3vVMW9MakxlumGWSr40bBrY3vLH7Ab3fdK2dUKlxkYmVmRtQtPY9N/Y9XWZXvW68uOKG9zib1La0uRIisDBb2g7V+zsWZYz7+CLlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767847676; c=relaxed/simple;
	bh=IpQ/kXxg+3ay3LFN7kednsxoShZVAU2hu7rUQMRBWq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h12fmHTW3CTXeoeLYYk5YlpZ136D51HXkMbJKHiWw95vnLL7IRpGw8TlVVRbYjk+NTG/ACmkpQ/yk4155B2CgJbOIOFdmnaxSjQfayZgipy3+/A5BEXhkd55PnEbdts7rlMgT5C0mgcm8puM6KmQ/YXDCwphZdQxVQpvOKDht2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opensource.nslick.com; spf=none smtp.mailfrom=opensource.nslick.com; dkim=pass (2048-bit key) header.d=nslick.com header.i=@nslick.com header.b=Aqia+ilK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oxEnw26M; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opensource.nslick.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=opensource.nslick.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nslick.com header.i=@nslick.com header.b="Aqia+ilK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oxEnw26M"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6DBD61400042;
	Wed,  7 Jan 2026 23:47:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 07 Jan 2026 23:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nslick.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1767847673; x=1767934073; bh=g1eB+j4dfwoyO90edPApB
	yptJu5iZbYYciRgccD50wY=; b=Aqia+ilKbvrxKkni+QevJkFDQbGO/ZnhURjJy
	oyumSsqKqPT4Rwr3tXSytbWhrqyg3Q7he8sp7L0fKRbP5GaOoWxYwa1+dDR0+yaJ
	LMFgjIM81/x/4NQoihskbqJX3V6EM+PzLqRj3d6D3dLAjSqAU6f5x2kpxC+CS5yU
	UUURnrF+M3N+o1O4PDF1FPHTbyqyJmq9ellTha4rAJC5aVom8SmrKKNorWMWnKoz
	DTrh6xd6LjypB43e6Iz3XJYW4OH2ERH4sMXBx69g57Wr3DE01FyP7NNE6pvyY6X9
	SLFdSTI4QlsuLrUErgpmL6FF9RspFb1KBwgsqak8G1F9Jd+cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767847673; x=1767934073; bh=g1eB+j4dfwoyO90edPApByptJu5iZbYYciR
	gccD50wY=; b=oxEnw26MRhGlDS36OJ4sKLrcICijcGjZaNZMPxDArIlj0SlfOjJ
	j3gpovqe2NupIKHZR0qkNMd2f2/HlwCSvSbbjYAWIUWgCDdzvhp2qiX/fLliJ4RJ
	hF78uA5a8BHGdWRmVJg53EozeaFk6hIJmuyGUrNLnCmJx+a+p4pqde/asvAl+ddh
	hWABlXE8eHOqY5gWMql4KKo11diFJ658O07tgcRYSjlLZt5+vKllzQALvWJ/Q9hL
	cuMJi99n6PDsp7O1Ngf0gQVak8JsyyEF1P9v7/yCgOSlslxvmHLkvXPtc+17mFK8
	UTjIALvrfIctvCIfNP9AB2lLMV2VNwMdDcQ==
X-ME-Sender: <xms:-DZfaZibQWG4ajXq8d4XRo_g0Qqx9oGVUFk6GLeKRGLNqMxOuvONmw>
    <xme:-DZfaZfhIppc0p3ZSkKlojoymVTa0Ykugg8U9PbRXLlNLt9O-8M4NkUZRQOLdUR8H
    U5lxjrXYEHWp6FWEVtYAMGIR9uIKvXRWYnXxLhs2-mzzNsgpoBTWhU>
X-ME-Received: <xmr:-DZfaXzdrDC-GsjncwmkuPBYezztAJ8ypMToUenlDqLyi2x_37X77I5_U3X7Z8dtkDJhzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheppfhitghhohhlrghs
    ucfuihgvlhhitghkihcuoehlihhnuhigsehophgvnhhsohhurhgtvgdrnhhslhhitghkrd
    gtohhmqeenucggtffrrghtthgvrhhnpeduieeuffeguddvuefhteetueeuffevgeekueei
    tedvkeffkeelteefhfehveffvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehlihhnuhigsehophgvnhhsohhurhgtvgdrnhhslhhitghkrdgt
    ohhmpdhnsggprhgtphhtthhopedvgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epmhgtghhrohhfsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtrhdrphgrvhhl
    uhesshhushgvrdgtohhmpdhrtghpthhtohepuggrrdhgohhmvgiisehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsrghmihhtohhlvhgrnhgvnhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtoheprghtohhmlhhinhesrghtohhmlhhinhdrtghomhdprhgtphhtthhopehmrg
    gvnhhnihgthhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhf
    rhgruggvrggurdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtg
    hpthhtoheprhguuhhnlhgrphesihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:-DZfabbkiRdiiz7r5iQGtpOa5DFhz--zJB_Wix0tW6-vdj3hGv-0cg>
    <xmx:-DZfadIxRL1WPcUDhgLGYB39wuDZq3V02K4ZsDJeu8ZgSzchryXU_A>
    <xmx:-DZfaa19wHehxSN5c493wMYHWNtEYQTWUf8YjuXZSAWBtGsn11z02g>
    <xmx:-DZfaZKhWcy5l_uuvGOL7qTDEUmNzUnK8BXFAvPwYKyKCU1KzPo0Vg>
    <xmx:-TZfaaSEUDamlh4c06CSu4xSJypw8lFIx9MS3OJHhYQhsYOyXcADECyn>
Feedback-ID: i78f146c6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 23:47:52 -0500 (EST)
From: Nicholas Sielicki <linux@opensource.nslick.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Matthias Maennich <maennich@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicholas Sielicki <linux@opensource.nslick.com>
Subject: [PATCH 1/2] module: expose imported namespaces via sysfs
Date: Wed,  7 Jan 2026 22:47:09 -0600
Message-ID: <20260108044710.33036-1-linux@opensource.nslick.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the only way for userspace to determine which symbol
namespaces a module imports is to locate the .ko file on disk (which may
not match the loaded module), then either parsing the binary manually
and handling any potential compression, or shelling-out to modinfo.

This is painful in cases where userspace wants to distinguish between
module variants that share the same name but import different
namespaces. For example, the nvidia-uvm module exists in both open and
closed source variants; the open source version imports the DMA_BUF
namespace while the closed source version does not, and networking
middleware may want to initialize itself differently depending on that.

Add /sys/module/*/import_ns to expose imported namespaces for loaded
modules. The file contains one namespace per line and only exists for
modules that import at least one namespace.

Signed-off-by: Nicholas Sielicki <linux@opensource.nslick.com>
---
 Documentation/ABI/testing/sysfs-module |  9 ++++
 include/linux/module.h                 |  1 +
 kernel/module/main.c                   | 62 +++++++++++++++++++++++++-
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-module b/Documentation/ABI/testing/sysfs-module
index 6bc9af6229f0..d8e2a33fd514 100644
--- a/Documentation/ABI/testing/sysfs-module
+++ b/Documentation/ABI/testing/sysfs-module
@@ -48,6 +48,15 @@ Contact:	Kay Sievers <kay.sievers@vrfy.org>
 Description:	Show the initialization state(live, coming, going) of
 		the module.
 
+What:		/sys/module/*/import_ns
+Date:		January 2026
+KernelVersion:	6.20
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
index d80c3ea57472..f1bcca03f90b 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -419,6 +419,7 @@ struct module {
 	struct module_attribute *modinfo_attrs;
 	const char *version;
 	const char *srcversion;
+	const char *imported_namespaces;
 	struct kobject *holders_dir;
 
 	/* Exported symbols */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 710ee30b3bea..6c41934f1135 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -607,6 +607,23 @@ static const struct module_attribute modinfo_##field = {              \
 MODINFO_ATTR(version);
 MODINFO_ATTR(srcversion);
 
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
+static const struct module_attribute modinfo_import_ns = {
+	.attr = { .name = "import_ns", .mode = 0444 },
+	.show = show_modinfo_import_ns,
+	.test = modinfo_import_ns_exists,
+};
+
 static struct {
 	char name[MODULE_NAME_LEN];
 	char taints[MODULE_FLAGS_BUF_SIZE];
@@ -1058,6 +1075,7 @@ const struct module_attribute *const modinfo_attrs[] = {
 	&module_uevent,
 	&modinfo_version,
 	&modinfo_srcversion,
+	&modinfo_import_ns,
 	&modinfo_initstate,
 	&modinfo_coresize,
 #ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
@@ -1753,11 +1771,48 @@ static void module_license_taint_check(struct module *mod, const char *license)
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
+static void free_modinfo_import_ns(struct module *mod)
+{
+	kfree(mod->imported_namespaces);
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
@@ -1776,6 +1831,10 @@ static int setup_modinfo(struct module *mod, struct load_info *info)
 		}
 	}
 
+	err = copy_modinfo_import_ns(mod, info);
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -1788,6 +1847,7 @@ static void free_modinfo(struct module *mod)
 		if (attr->free)
 			attr->free(mod);
 	}
+	free_modinfo_import_ns(mod);
 }
 
 bool __weak module_init_section(const char *name)
-- 
2.52.0

