Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE2A409103
	for <linux-modules@vger.kernel.org>; Thu,  4 Jun 2026 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780571125; cv=none; b=uBgBfhdZPAtusu2A1tMB6KW7dKDRv4+JuHnJf/Jid8QfGMkV6u5qVnZTNhWPh3oxswfv5O98MXLXzEQ9cP7sA3LQ9x6RWOcULsNOnWpI2PYQdznlEaczX+8UPDe91ui2VsMQDlyfNK4FCkbEU0QEMHDEZYuDBneO9i9EnwS47V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780571125; c=relaxed/simple;
	bh=C92wi7j9PlBKhkeVJo2ng45cmm9eFGU8sPOk7F3JB84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHhh+0pG7jUrXIJ25bCaJNlLP1JwtlqcLse81RuOf8b3HXgQfdRBVRmw5XSXlg4KdP4S/kweDhW7cNlXCTsCe0NtSK+/S6HsxTOpYtFhy0wOhudqqLG6KOkv3FJ3Xv5C3/bzvYxTN70BZuB33wgeXtP65+9j35IheNg1hTIibic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T6KMsC+a; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T6KMsC+a"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so7106555e9.1
        for <linux-modules@vger.kernel.org>; Thu, 04 Jun 2026 04:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780571122; x=1781175922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niEZAFnY1RLD4JLGZab4EnFoTzKTvX/YTAN74sNfQw8=;
        b=T6KMsC+a0TrPZf4QJMlyoVXe0gi4auctgiU6LnhrhtHzmXtyW7uVyHxo0rkzxrxMLE
         CPHBTnEvu0H4coziLY5QiJCMci9gKZSpNN/TZPsDDyYLmfbg3weI/cZwW4W3jKQclozv
         Xw6pnrJhh3jckDcNVGrdBQ/zBib9orVqVT2gJD7ON34DQ7ng0kQmUjgn8+emwPJlLtoi
         Rs+fobLJlvtWwZogIhCCcL/QcSh5X/hCa9ngRD1CHv1w6BNJdl1TIvcnzz5v3FEdj8Bm
         6o05ItZHHFD8tbhQzsy1znmffAS4ZJYq6ffhB259n5/8r5ygNN2DBVOaknT6YSQmY83t
         5KNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780571122; x=1781175922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=niEZAFnY1RLD4JLGZab4EnFoTzKTvX/YTAN74sNfQw8=;
        b=fhyGP2RcqbpqhihDuiF+LxgefWgmHC5EmIuDtNpVcFIKcXh/brHXmJmFA1cHKc/r7M
         txKmjLb2SFEZD9FdilUt+fv0lzmucvKFUToaoURP7djYikZYijMjDUoqJsXWEEZNcgw7
         uMRR4Ib0Wa+KaaIRUMm0Glii88cNkU6olDLr0IZ81xeiWgWdpqr1oL9pH/ns2F1mMcA9
         IMwEhER/I8mYcE2fKas7TgaU86iK+8E/yeLjwsVfSvJLt5D4BrwzUZf8v5yiouENPcLL
         fRd7gl7T8PMjxRsvbhAevi1BbsE8EFyIs+uBH+PilGFU95XYVCJrhQMN2ugi4KulInUj
         HJnA==
X-Forwarded-Encrypted: i=1; AFNElJ9U4cnJDDFsur2JpnBLmQ0nyiN7Frclpsefb8NWg0WNBE3BcnCMrcqi5rjC39mbz+C9lUiXo46xqfJVSzkK@vger.kernel.org
X-Gm-Message-State: AOJu0YwFFOB/lT1lebZzLu9QTOmd20rNspmcoMgAIKvuyUxWehPCQ10k
	Du7gOvP4L104554x5usW/Py4f2gwJoBOtXfGwXosxoelV5yWIga1wA9GO6aRPE8WAHY=
X-Gm-Gg: Acq92OE/IpKjPr6kguoAETcopCz49aDhqsnXeU/xWl05GNhzS1n+l3goQKJeqtXXUau
	OMsj6lh3Ttu/GA6SmS2CF7Rga6Xp6ETlOhCLXTs7JuNI9kkMyspCeSxBfSa6ZQocA8gYqOTqeaI
	M0U0/wDUgqwHZ5nqKBUJDPJJQKll6wnCVkXb593sVtwmWwx9MsBHYFy2N3iKdmGzLfmDl50zHG6
	kntvdGO6LXHeuA2BCnbCEQ9AWqAgdEgdQktr6vP7Kz85Rdv+QmlnyeD22tHzov3wPJpmtlM30KP
	IIAyfRH4f454fQTVQsB8DCmMjzrXJJkFhyvtnRqQfHXrgic08DrcYcIiJ2VdllfGQBuU2kS2WTu
	YFClZAZaKerXppJLxV6TZFnvtv1xXgVNG9cBOB5BCrNaIXUbBrIAxkDhc0OIzgag6xi6ySPqr3w
	3aFPaF9vmOY+25nIZ5eMHkoimn5uPOG4X4l/EqC/6pN4JKfnV6zRW4oh3BQs/XJySfjFcoq0Ddh
	v2mwX3pIoFETDVdpFoOhs2Bzr74+Pq/BcM=
X-Received: by 2002:a05:600c:4453:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-490bc50dcecmr46150515e9.16.1780571121990;
        Thu, 04 Jun 2026 04:05:21 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7a273e3sm99648235e9.0.2026.06.04.04.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 04:05:21 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	Matthew Wood <thepacketgeek@gmail.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] xtensa/simdisk: Avoid referring to module::args
Date: Thu,  4 Jun 2026 13:04:45 +0200
Message-ID: <20260604110455.1608038-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604110455.1608038-1-petr.pavlu@suse.com>
References: <20260604110455.1608038-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When simdisk support is built as a loadable module,
simdisk_param_set_filename() receives a pointer into module::args and
stores each filename pointer as is.

In preparation for removing module::args, update the simdisk.filename
parameter code to copy the provided string. This is somewhat complicated by
the fact that simdisk support can also be built-in, in which case the
parameters are parsed during early boot before slab is available. In that
case, the command line itself is preserved for the lifetime of the kernel,
so continue storing the incoming pointer directly.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/xtensa/platforms/iss/simdisk.c | 38 +++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 7c7a2aa749f8..a2ddb49c269d 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -41,7 +41,7 @@ module_param(simdisk_count, int, S_IRUGO);
 MODULE_PARM_DESC(simdisk_count, "Number of simdisk units.");
 
 static int n_files;
-static const char *filename[MAX_SIMDISK_COUNT] = {
+static char *filename[MAX_SIMDISK_COUNT] = {
 #ifdef CONFIG_SIMDISK0_FILENAME
 	CONFIG_SIMDISK0_FILENAME,
 #ifdef CONFIG_SIMDISK1_FILENAME
@@ -50,20 +50,48 @@ static const char *filename[MAX_SIMDISK_COUNT] = {
 #endif
 };
 
+/*
+ * The simdisk code can be built either into the kernel or as a loadable module.
+ * When built-in, CONFIG_SIMDISK{0,1}_FILENAME can be used to specify the
+ * initial simdisk filenames and additional filenames can be provided on the
+ * kernel command line. These arguments are parsed during early boot when slab
+ * is not yet available, but the command line itself is preserved for the
+ * lifetime of the kernel, so the incoming pointer is stored directly.
+ * When built as a loadable module, each value is copied with kstrdup() and all
+ * allocated memory is freed in simdisk_param_free_filename() when the module is
+ * unloaded.
+ */
 static int simdisk_param_set_filename(const char *val,
 		const struct kernel_param *kp)
 {
-	if (n_files < ARRAY_SIZE(filename))
-		filename[n_files++] = val;
-	else
+	char *str;
+
+	if (n_files >= ARRAY_SIZE(filename))
 		return -EINVAL;
+
+#ifdef MODULE
+	str = kstrdup(val, GFP_KERNEL);
+	if (!str)
+		return -ENOMEM;
+#else
+	str = (char *)val;
+#endif
+
+	filename[n_files++] = str;
 	return 0;
 }
 
+static void simdisk_param_free_filename(void *arg)
+{
+	for (int i = 0; i < n_files; i++)
+		kfree(filename[i]);
+}
+
 static const struct kernel_param_ops simdisk_param_ops_filename = {
 	.set = simdisk_param_set_filename,
+	.free = simdisk_param_free_filename,
 };
-module_param_cb(filename, &simdisk_param_ops_filename, &n_files, 0);
+module_param_cb(filename, &simdisk_param_ops_filename, NULL, 0);
 MODULE_PARM_DESC(filename, "Backing storage filename.");
 
 static int simdisk_major = SIMDISK_MAJOR;
-- 
2.54.0

