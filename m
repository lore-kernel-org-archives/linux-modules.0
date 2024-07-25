Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2F916D4C3;
	Thu, 25 Jul 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721907478; cv=none; b=DMDYi/bh7wqpQ5WuhS5Ob6Wcyx2s9wgzbMadZru5ZD0wp/mIXIQejxW9f2H7qtOcZwyZF6igdeQDPpLOXJcoSpIDTLJTR16Fc6SSMn02b6l8cVWC78QIbYpNhjTRlvVX1Coh7sfA7My+7QQOgf50/wc3MxQCxzMhqRlPwGcBDnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721907478; c=relaxed/simple;
	bh=a8Z6Q9tsTrYdEjiQ6k1+fN0sXA3vkOxm4OoLs3NCtlE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FRWBVO7esl2zb7/E1daLwhwmQPJ/ecbz23VaXyjRA9QpMRZrNYRdmGHntzixkn3Mydmh3MjwY/6IgaQ9IXAxegaNL5JrLAJxMJNvyLApGYv0pzVz0yVYIPjv6R5XgfMT33LRm8F4mYm9suCCdRv+RFRO4zGcRAS8giiEcZQkk/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=KdZDdP2s; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="KdZDdP2s"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721907473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8cRY9HOX7blyu3XT+Ji9M1eNuX4gkPBubPEEF4Jgnb4=;
	b=KdZDdP2sKyLQM4sLBuk6kJRtv09Qbeq0etLPQjHQ9fGprGvxS4ILbljILLe29R1eZyKrTC
	3io+gSMfC2N5zZ7voPtG2JD0zEwBdMObM60X/6KGd/VlVmdSlGwF6P/CBNae17U/AKXPdl
	E7Z81QG0UxF3DPdjDpNSe/smfnbdskBdeeV7xwStrhLJawaQ3IefYEtF9jyoAvlW0fPWJg
	jLO1esE01iB0FDTY80ZTdBsGKQ/nYe+ZuU6p5gGKhJXhCpXh5XKZVa6AWanCvkmWgEIlai
	zq+f8Vta+X4vcvZVToMuiHZuXbib6uaee+fViOAMW7fyDgyjZdRVzyouyalGYQ==
To: linux-modules@vger.kernel.org
Cc: mcgrof@kernel.org,
	linux-kernel@vger.kernel.org,
	didi.debian@cknow.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Qiang Yu <yuq825@gmail.com>
Subject: [PATCH] module: Add hard dependencies as syntactic sugar
Date: Thu, 25 Jul 2024 13:37:46 +0200
Message-Id: <04e0676b0e77c5eb69df6972f41d77cdf061265a.1721906745.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Panfrost and Lima DRM drivers use devfreq to perform DVFS, which is supported
on the associated platforms, while using simple_ondemand devfreq governor by
default.  This makes the simple_ondemand module a hard dependency for both
Panfrost and Lima, because the presence of the simple_ondemand module in an
initial ramdisk allows the initialization of Panfrost or Lima to succeed.
This is currently expressed using MODULE_SOFTDEP. [1][2]  Please see commits
80f4e62730a9 ("drm/panfrost: Mark simple_ondemand governor as softdep") and
0c94f58cef31 ("drm/lima: Mark simple_ondemand governor as softdep") for
additional background information.

With the addition of MODULE_WEAKDEP in commit 61842868de13 ("module: create
weak dependecies"), the dependency between Panfrost/Lima and simple_ondemand
can be expressed in a much better way as a weakdep, because that provides
the required dependency information to the utilities that generate initial
ramdisks, but leaves the actual loading of the required kernel module(s) to
the kernel.  However, being able to actually express this as a hard module
dependency would still be beneficial.

With all this in mind, let's add MODULE_HARDDEP as some kind of syntactic
sugar, currently implemented as an alias for MODULE_WEAKDEP, so the actual
hard module dependencies can be expressed properly, and possibly handled
differently in the future, avoiding the need to go back, track and churn
all such instances of hard module dependencies.  The first consumers of
MODULE_HARDDEP will be the Panfrost and Lima DRM drivers, but the list of
consumers may also grow a bit in the future.

For example, allowing reduction of the initial ramdisk size is a possible
future difference between handling the MODULE_WEAKDEP and MODULE_HARDDEP
dependencies.  When the size of the initial ramdisk is limited, the utilities
that generate initial ramdisks can use the distinction between the weakdeps
and the harddeps to safely omit some of the weakdep modules from the created
initial ramdisks, and to keep all harddep modules.

Due to the nature of MODULE_WEAKDEP, the above-described example will also
require some additional device-specific information to be made available to
the utilities that create initial ramdisks, so they can actually know which
weakdep modules can be safely pruned for a particular device, but the
distinction between the harddeps and the weakdeps opens up a path towards
using such additional "pruning information" in a more robust way, by ensuring
that the absolutely required harddep modules aren't pruned away.

[1] https://lore.kernel.org/dri-devel/4e1e00422a14db4e2a80870afb704405da16fd1b.1718655077.git.dsimic@manjaro.org/T/#u
[2] https://lore.kernel.org/dri-devel/fdaf2e41bb6a0c5118ff9cc21f4f62583208d885.1718655070.git.dsimic@manjaro.org/T/#u

Cc: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Qiang Yu <yuq825@gmail.com>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 include/linux/module.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 88ecc5e9f523..40e5762847a9 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -179,6 +179,14 @@ extern void cleanup_module(void);
  */
 #define MODULE_WEAKDEP(_weakdep) MODULE_INFO(weakdep, _weakdep)
 
+/*
+ * Hard module dependencies. Currently handled the same as weak
+ * module dependencies, but intended to mark hard dependencies
+ * as such for possible different handling in the future.
+ * Example: MODULE_HARDDEP("module-foo")
+ */
+#define MODULE_HARDDEP(_harddep) MODULE_WEAKDEP(_harddep)
+
 /*
  * MODULE_FILE is used for generating modules.builtin
  * So, make it no-op when this is being built as a module
