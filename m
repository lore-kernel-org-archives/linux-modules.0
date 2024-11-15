Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89281BBBFE;
	Fri, 15 Nov 2024 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675098; cv=none; b=c+8FoP+2WWL6ffqZGtdf52IMjyRpy3gCbrQ763vkxVZpDCpEA2VbwtiegR1o1Ew2vOuRRmhwrqL2EpAjOMBYZcmQQ9yyrgw13K4QPLzKXt4FeqaA3lLDRyOwCutPap0+SOlT8COXEqFrjOTsB7dCZLbxfMFbDSjzRns6AmW/RiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675098; c=relaxed/simple;
	bh=cKFDZRbLAsD+HU2hNoRZtN6nZnKyYpbXJngT5aLrxbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzbs/8Ycky4wjCg2DxVjrXOGt8IisDpRv5XKenM005op60GLHC4UrELL7UUvZv9ltjHhE3g1Ku10AF11C2tzAgW7qlE7jqWB0kSJ0C8zjVd37HAn2iagCczO98AqhGsojdMsNm1bbrHY8DyzXoAUxyLiQW3CA/AfSZfMrS7Ik7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=urKl7sWC; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="urKl7sWC"
Received: from wse.fritz.box (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 0107B2FC005B;
	Fri, 15 Nov 2024 13:51:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731675089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4MHsbl+M+GIK9whBqhnhf0aHDdPHEL8Hcvpfaf/hkeU=;
	b=urKl7sWCBLesLxUZYLTdL76Q8uhjVk61I+u1cp6ld+NJ8VPgk/stWDFx44U9Lbjf/frT2Z
	bUS1KvUl51JU8OcUF8XBgAbjUOFjihT6Le9/qPC6CZnRnvMTD442stDFG2seho+6jNIhpZ
	91LwqhiGYED8/cT1aYhQYG8py1HGK1Q=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: u.kleine-koenig@baylibre.com,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	samitolvanen@google.com,
	da.gomez@samsung.com,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@leemhuis.info,
	vv@tuxedocomputers.com,
	cs@tuxedo.de
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH v2 2/2] module: Block some modules by TUXEDO from accessing GPL symbols
Date: Fri, 15 Nov 2024 13:49:40 +0100
Message-ID: <20241115125121.1242871-3-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115125121.1242871-1-wse@tuxedocomputers.com>
References: <20241115125121.1242871-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <ukleinek@kernel.org>

TUXEDO has not yet relicend all modules for GPLv2+ as former contributer
need to be contacted that comited code under GPLv3+.

So teach the module loader that these modules are proprietary despite
their declaration to be GPLv2 compatible until the relicensing is complete.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 kernel/module/main.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 905d7b60dd709..3f391183aaf97 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2029,6 +2029,29 @@ static const char *module_license_offenders[] = {
 
 	/* lve claims to be GPL but upstream won't provide source */
 	"lve",
+
+	/*
+	 * Tuxedo distributes their kernel modules under GPLv3, but intentially
+	 * lies in their MODULE_LICENSE() calls.
+	 * See https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427
+	 */
+	"tuxedo_io",
+	"tuxedo_nb04_keyboard",
+	"tuxedo_nb04_wmi_ab",
+	"tuxedo_nb04_wmi_bs",
+	"tuxedo_nb04_sensors",
+	"tuxedo_nb04_power_profiles",
+	"tuxedo_nb04_kbd_backlight",
+	"tuxedo_nb05_keyboard",
+	"tuxedo_nb05_kbd_backlight",
+	"tuxedo_nb05_power_profiles",
+	"tuxedo_nb05_ec",
+	"tuxedo_nb05_sensors",
+	"tuxedo_nb05_fan_control",
+	"clevo_wmi",
+	"tuxedo_keyboard",
+	"clevo_acpi",
+	"uniwill_wmi",
 };
 
 /*
-- 
2.43.0

