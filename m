Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC874205E01;
	Mon, 16 Dec 2024 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369921; cv=none; b=srG+0KOuYVxGtr7ga3S48LIFizwxMV9sqcVDzqm9PvclWMtwKEkof/GrF7KH3CTrSuLQ9uGJaGcD3VpWR4DcHLUKeHtO62mvm7hYfHpV3EftRUgzmuXNBwbTUq5+j0BzFkT3niHIXP3Zxw1dX+Df8kdoaJdBtiRTYKtZPfxudGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369921; c=relaxed/simple;
	bh=afBfdADjktM8+i8Dk+LpQQ8DfaQoCenCEC7qVfZgIas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V6sVZJHaXhU/2/GV9xn63LvWP7OCUvX7gDlvtNAhu9lbayoi/zYWp9kkIGFP/iOCo5GfAczDtIgaqZXUNyyzLkxeiXJu1m8Xm9BOPMXLwc0rvr4AnLnEu4HRT9RZ7cU57lEl4w8aYsLdxVxOmEWD4cGTKkeNLZ1NRdZubdPaeFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=a8e3Hmj7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="a8e3Hmj7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734369915;
	bh=afBfdADjktM8+i8Dk+LpQQ8DfaQoCenCEC7qVfZgIas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a8e3Hmj7A6vP/czBlRA9pxpIFTNjXIy3/95al12+x6DXqkZdV4oZ0SUytbMAJpqyP
	 0JOXXsscFur+lC8noQzNn/NAW0lPh4cgUKd8JX9QoGNCP7wGWoqHhasJBSZLqXcaCQ
	 AtKHj9SDHrWs/Oq+ZCatjjQBNOe8NG32j32sxpw8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 18:25:09 +0100
Subject: [PATCH 2/3] module: Handle 'struct module_version_attribute' as
 const
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-attr-module-v1-2-3790b53e0abf@weissschuh.net>
References: <20241216-sysfs-const-attr-module-v1-0-3790b53e0abf@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-attr-module-v1-0-3790b53e0abf@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734369915; l=1698;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=afBfdADjktM8+i8Dk+LpQQ8DfaQoCenCEC7qVfZgIas=;
 b=qbXI4BdDazUuUKq3CRH3ac1wEt4oVU5O1pTUOy/Lf8Cim0uhLOPQIoykuFdOXRgVLv/gCrhk0
 9O7XA5hOLcICSd2rjc1xPGR/Do3a8JUFLibttaruRTSKcBQHR8HtWkL
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The structure is always read-only due to its placement in the read-only
section __modver. Reflect this at its usage sites.
Also prepare for the const handling of 'struct module_attribute' itself.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/module.h | 2 +-
 kernel/params.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 94acbacdcdf189e27013088de2202bccac9717e0..de2f2293204a4681072fba9ea3439e5582c81fbf 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -275,7 +275,7 @@ extern typeof(name) __mod_device_table__##type##__##name		\
 #else
 #define MODULE_VERSION(_version)					\
 	MODULE_INFO(version, _version);					\
-	static struct module_version_attribute __modver_attr		\
+	static const struct module_version_attribute __modver_attr	\
 		__used __section("__modver")				\
 		__aligned(__alignof__(struct module_version_attribute)) \
 		= {							\
diff --git a/kernel/params.c b/kernel/params.c
index e90733824528eacc77046f85c9ab4243467ca841..763261a7fef94d02503fa0d365d155c223fc382b 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -860,8 +860,8 @@ static void __init param_sysfs_builtin(void)
 ssize_t __modver_version_show(struct module_attribute *mattr,
 			      struct module_kobject *mk, char *buf)
 {
-	struct module_version_attribute *vattr =
-		container_of(mattr, struct module_version_attribute, mattr);
+	const struct module_version_attribute *vattr =
+		container_of_const(mattr, struct module_version_attribute, mattr);
 
 	return scnprintf(buf, PAGE_SIZE, "%s\n", vattr->version);
 }

-- 
2.47.1

