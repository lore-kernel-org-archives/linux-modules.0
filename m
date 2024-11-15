Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F4554769;
	Fri, 15 Nov 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686802; cv=none; b=YDeNXHIhfqX+qPsnx/mXHbgaoMx6twD7B7/RdRQCJ1Uf2gju1zMx+ChkgVGsJbIE1FaNIr7JjZeE9kryd0WVMLuWiAJm3aE8M/b8VilqKHtoVNZ8BtXVVgXdu4ua6bn9YlHjvTIKSXTagynZoeSvfPK4GP0OvX+yPi1ucS12eQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686802; c=relaxed/simple;
	bh=R0KDEUStn8uHL5AhtfRXsN/yn7hHLoy44foGgfO9tGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRvoIGCHIxDZ2JfV5NcLL9KI4DmadM3noHc3Yp4bBzuo8aSGh+DxOniqUNRsEn3b+DJ/XuDPBASF8tNK9VNIpxmK/2hsgahEl5SNBwV8e4+BhtY9/QKKnAHLb2Uuv06tLzwiGhjI0TSQPWXQaYtG0zIu3Bv1H5zx7gELiPIfn24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=Apz4qd4Q; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="Apz4qd4Q"
Received: from wse.fritz.box (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id A464E2FC005D;
	Fri, 15 Nov 2024 17:06:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731686797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UhXDqRv1LyXn2u1yFtgwx0Z25KmuWLbbTBFTIWBTS0=;
	b=Apz4qd4Q32tFGicq9m2n43639Z02fMc1hFM5n0GQUYHslws317lO/8ysCcRJz7XMzgsB6e
	UmGzi5hxZ8GWtYZTYYDLxr0Wi3lBparuq1SY/VFDp3JfsRTZba6GvSY8NC/PY91xap9sNu
	6CVd4rVGwZFIezhznc+gL2TlN22VPK8=
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
	cs@tuxedo.de,
	wse@tuxedocomputers.com
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH v4 2/2] module: Block some modules by TUXEDO from accessing GPL symbols
Date: Fri, 15 Nov 2024 17:04:37 +0100
Message-ID: <20241115160633.1271757-3-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115160633.1271757-1-wse@tuxedocomputers.com>
References: <20241115160633.1271757-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <ukleinek@kernel.org>

TUXEDO has not yet relicensed all modules for GPLv2+ as former contributer
need to be contacted that comited code under GPLv3+.

So teach the module loader that these modules are proprietary despite
their declaration to be GPLv2 compatible until the relicensing is complete.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 kernel/module/main.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 905d7b60dd709..5df995ff0a9d3 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2029,6 +2029,30 @@ static const char *module_license_offenders[] = {
 
 	/* lve claims to be GPL but upstream won't provide source */
 	"lve",
+
+	/*
+	 * Tuxedo distributes some of their kernel modules under GPLv3, but
+	 * uses MODULE_LICENSE("GPL") calls.
+	 * See https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/merge_requests/21
+	 * and https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/dd34594ab880ed477bb75725176c3fb9352a07eb
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

