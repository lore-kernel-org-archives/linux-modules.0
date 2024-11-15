Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E6B18C034;
	Fri, 15 Nov 2024 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675707; cv=none; b=EAlEn8LO0gcsKhwpPJI3PfY5PL6+NFrI8PkQHAL7YHJyxiYQJ4MdmNoTZ0GViVZ+X3hn9LlVodaQElcpkBau/HZjuJC5nDXoAAT8A9PGJJvg2JafkPazQSKy0K3Ju2vsjmsYHWrL9safcJ27wLa0C/ntqtq1ZZOMKx8JmybT+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675707; c=relaxed/simple;
	bh=1lqXTJ5LEuxXFklhwIpxvIBS1wTM/RN1yjPv/nA7NCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QuRQ9LfmVEO9vVaVmlV7/r2UmZqftAB/2EZh2VPzMifskS6th+5wAI2Of2WwgIx0FUJoo8QMX4aHrDMKUj9BWVx6wq/TQzTT7LBGrKL4pT+vp6qFf0GRtXcXWOHSsHNXskbJFCXsTMqUdff3Y6hta1rfbeZevaCiDrJlU/+zGh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=B5AAxyUs; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="B5AAxyUs"
Received: from wse.fritz.box (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id F01FB2FC005D;
	Fri, 15 Nov 2024 14:01:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731675703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvTGolRSXKQu3OPFCUVk1lx0gdMkUUzStzWSVGW9QVE=;
	b=B5AAxyUsOFUN8HUwuP5XTtnwTBHKqdocbSmJxx4FjigJjLOzJFBdt2WCd0dhQxU+y/CCdf
	P+v/DkhcpPeBDQuZOIHYeAqIf+f6he9cvgYtz1QfGWDJIHFNtqJ51ZKi++VCTUWJJExmDv
	pDO9WvP8GAIn6s3h4AtyI0Lhlrkrp8A=
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
Subject: [PATCH v3 2/2] module: Block some modules by TUXEDO from accessing GPL symbols
Date: Fri, 15 Nov 2024 13:58:42 +0100
Message-ID: <20241115130139.1244786-3-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115130139.1244786-1-wse@tuxedocomputers.com>
References: <20241115130139.1244786-1-wse@tuxedocomputers.com>
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

