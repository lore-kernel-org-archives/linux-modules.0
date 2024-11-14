Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03701FAC47;
	Thu, 14 Nov 2024 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580311; cv=none; b=uY6LvXsdQ8oZC8rPyUKpYJpm50C1wi9CXX4bbity/jO6w+T0YY59ZOKaPDDrmcqf6FSHc0VxA0LeAQ9QKa+BuVJ4J9wahVT++neB1ov6UPC56D8BWjTdlBCSX0E2b5B1RHhj+2+enHQgz3FcsDPonZoHhZuVh99d82N5JD5Rt1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580311; c=relaxed/simple;
	bh=PvtFbg/8OOw9SaJ63G51HlH+PGdB8FZuVIeCmRurLBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5TGd+wpWYO0nWSAcE2PrGJM5TCdoaQRaMDeCCySnQfiQD/WWyPTXeo0h8yanrPw3neAcuzJGEEabqG3harksEvMB2dy01f2Vr3paXL5sfH46RD3vCCRaHxZhYCIK52lp5NYkmDs7Raijb/eAhww/LvRbofsUsmqJ7XBpUckfHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHGS4Z8F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHGS4Z8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5234EC4CECD;
	Thu, 14 Nov 2024 10:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731580311;
	bh=PvtFbg/8OOw9SaJ63G51HlH+PGdB8FZuVIeCmRurLBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LHGS4Z8F0wL30Lex/0uqMZFucCEXI1nFoncTAeW5vuigAA8+b7gR1JsyvEdqyJVME
	 I8fEu/64CvkiMa02Wj1eZukHaKJ1FDHN2uwQ6GjXZjfoXgAeooO/tWLVwBVeO6QUru
	 arXJjQ2+VjqCyRIdxQx09FnYa3DgImEGdEvthKyFpX1N3e8HnY3wAzgEM4sh0Gtq7l
	 9lMWEY+pRfALVU1Oy5ke+4Kd4ZlHkDj+M1BgNs/FAnbMstgjJo76vaZgT5toTpmFvQ
	 Kcp3uMOg3VcI7qUTzKL4tLhRPMvF/e69yRCehWTAYHxQR9CPs0sW89KES4KTRMO/Dg
	 rrlAlfloMvM/A==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	tux@tuxedocomputers.com,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH 2/2] module: Block modules by Tuxedo from accessing GPL symbols
Date: Thu, 14 Nov 2024 11:31:34 +0100
Message-ID: <20241114103133.547032-6-ukleinek@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114103133.547032-4-ukleinek@kernel.org>
References: <20241114103133.547032-4-ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2072; i=ukleinek@kernel.org; h=from:subject; bh=PvtFbg/8OOw9SaJ63G51HlH+PGdB8FZuVIeCmRurLBE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnNdGKZw0mWE7g1hW0HBpcAD8ExG6wnwPUjm1qA kSwKe5ZvrKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZzXRigAKCRCPgPtYfRL+ TtkrB/4rIFmp9c+r8N9S94itqsftcS4Kbq6QmiC/frrvUpaYaB23tXERKy8bFqrq18+P9UEDGG/ Ocn6aGWji3HRYFBX1VWTyRwvdKvN/cppS8RYGKQjzdXWxh0QJzEs5u46W3vWQwVcL3CyhkxA4Ai 5KOW5xbnl4FCoisUa5U98eZdohaRS4vS/enfzd1tt2S4ZTLCzinb4WcD6Urlhi2BVk0kRuJTWhn cx13X/3uSQK2OEYxUvepHzz60UhRJzisdpMlgCs1n3RyMI3irMrwHejdBGZILg8vi6NVDvHkCPd fmy2jNxqS4AvdJqucu+YVXDKZpZAuaD81ocYy2tUgsp3v05q
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Tuxedo licenses the modules used on their hardware under GPLv3+, to
"keep control of the upstream pacing" – and want to re-license the code
while upstreaming.

They were asked to then at least not use MODULE_LICENSE("GPL") which
declares compatibility to the kernel's GPLv2. They accepted the pull
request and shortly after reverted the change and so continue to lie
about the license.

So teach the module loader that these modules are proprietary despite
their declaration to be GPLv2 compatible "until the legal stuff is
sorted out".

Link: https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 kernel/module/main.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 878191c65efc..46badbb09d5e 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2338,6 +2338,39 @@ static const char *module_license_offenders[] = {
 
 	/* lve claims to be GPL but upstream won't provide source */
 	"lve",
+
+	/*
+	 * Tuxedo distributes their kernel modules under GPLv3, but intentially
+	 * lies in their MODULE_LICENSE() calls.
+	 * See https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427
+	 */
+	"gxtp7380",
+	"ite_8291",
+	"ite_8291_lb",
+	"ite_8297",
+	"ite_829x",
+	"stk8321",
+	"tuxedo_compatibility_check",
+	"tuxedo_io",
+	"tuxedo_nb02_nvidia_power_ctrl",
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
+	"tuxi_acpi",
+	"tuxedo_tuxi_fan_control",
+	"clevo_wmi",
+	"tuxedo_keyboard",
+	"clevo_acpi",
+	"uniwill_wmi",
 };
 
 /*
-- 
2.45.2

