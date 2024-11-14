Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320531F8F0B;
	Thu, 14 Nov 2024 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580309; cv=none; b=D/YiAKqVCaECZ4IE6kNleCWjJH9Dxh2Qh0wBLaSBPIgMv9rlscJwhZvi2tqOrsxQb8uJZcb69h6fR28c019mVFJdjHjQR8VTSC0D6W+00mKhisLEmaSyg14eqf2iwEPnIwTruKRmAPxPmKLICm+VSmqaYpvd7s2ZTfXF7vM75iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580309; c=relaxed/simple;
	bh=e7Kv5H6ICil1nLzt3NYP114OkhApUX6xbrbhiUW00fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DK4Q6/BVhuz7w9WVJmXtOAKlQWUh8jhL8nxsSsjDAuC1X6qFYDs8/5PeuZ4HaYhBbLJfB+aZ1RTKY2RSiuTSgTDZMtj09QpTRZ/AC/7HUxtrKWm30TcbMmECgxDAcbjnTjnwTvJ6JpW8Waq4+5BueQiQ621BPa1g/y8zjjBKN6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vF5MYQed; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vF5MYQed"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DCFC4CECD;
	Thu, 14 Nov 2024 10:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731580308;
	bh=e7Kv5H6ICil1nLzt3NYP114OkhApUX6xbrbhiUW00fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vF5MYQedB0REIKSNg/FLuVHeCXLxYAew4eFrJHYUMW0jQ2O9fCq/ebNE12pustAKL
	 x87+TVMYD2w7t0DUBdnMimkPRGtRRNnpBR7wKYKKzXhpyNc8x6NzQ0pf8R6qk5Z5XM
	 uOWezp38lvOJTiGe1bY+6QxcY5NB6BjdGlOdU8PHJKk/WOJ3XfIkNKSSVeAvNy7eUV
	 F9ZvKnQzlRxbVQ8l6xYTHnuNEAzg3VfWu+ykjc4PBHxMPWoHO9JDr6xxRvU24SUDya
	 udcJO9S2vY3EiMtn8SA3yEmJbmr+Mmi9xbz8LUL9p9vs6fvY3Hsiw1ATfIo0YiRP3f
	 vD9DYhB892q7Q==
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
Subject: [PATCH 1/2] module: Put known GPL offenders in an array
Date: Thu, 14 Nov 2024 11:31:33 +0100
Message-ID: <20241114103133.547032-5-ukleinek@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2109; i=ukleinek@kernel.org; h=from:subject; bh=e7Kv5H6ICil1nLzt3NYP114OkhApUX6xbrbhiUW00fA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnNdGHLLvJH63zK3KlJYxSiv0fheuwhbx9HeKzx N49KScbzvWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZzXRhwAKCRCPgPtYfRL+ Tg9GB/9xsjdS29pA3GOb9iqYNvM4F4E2DPRSyCxHpBfLznY+FroS+8yER4dr417soNCiOUfQQJo zaVvuaWPxqWx57uRByaAiYa/ou2lYbAmD0x2vZmpgAF2lf9OR9jD7qtn4ZayMtzlYZoX3ogFCQf QeE5DTwq+Rea6O9/bP1mzW387vvcODy81ur198dFFwZytt1Y1YxIQYR/edyWZr+TD+IMuHaojVM x/mo2hQ7OAu6hXbmPZyyJrzFK2g2/3RZElCFYQ5//IDP6P8ds6TS76nhFdZZAnAwBueQogDYhcc aAl6s6Dht75+uW7lHTWzpak55bMmPbx4T4NN6296Z8PqQ01n
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Instead of repeating the add_taint_module() call for each offender, create
an array and loop over that one. This simplifies adding new entries
considerably.

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 kernel/module/main.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5399c182b3cb..878191c65efc 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2332,11 +2332,20 @@ static int rewrite_section_headers(struct load_info *info, int flags)
 	return 0;
 }
 
+static const char *module_license_offenders[] = {
+	/* driverloader was caught wrongly pretending to be under GPL */
+	"driverloader",
+
+	/* lve claims to be GPL but upstream won't provide source */
+	"lve",
+};
+
 /*
  * These calls taint the kernel depending certain module circumstances */
 static void module_augment_kernel_taints(struct module *mod, struct load_info *info)
 {
 	int prev_taint = test_taint(TAINT_PROPRIETARY_MODULE);
+	size_t i;
 
 	if (!get_modinfo(info, "intree")) {
 		if (!test_taint(TAINT_OOT_MODULE))
@@ -2385,15 +2394,11 @@ static void module_augment_kernel_taints(struct module *mod, struct load_info *i
 	if (strcmp(mod->name, "ndiswrapper") == 0)
 		add_taint(TAINT_PROPRIETARY_MODULE, LOCKDEP_NOW_UNRELIABLE);
 
-	/* driverloader was caught wrongly pretending to be under GPL */
-	if (strcmp(mod->name, "driverloader") == 0)
-		add_taint_module(mod, TAINT_PROPRIETARY_MODULE,
-				 LOCKDEP_NOW_UNRELIABLE);
-
-	/* lve claims to be GPL but upstream won't provide source */
-	if (strcmp(mod->name, "lve") == 0)
-		add_taint_module(mod, TAINT_PROPRIETARY_MODULE,
-				 LOCKDEP_NOW_UNRELIABLE);
+	for (i = 0; i < ARRAY_SIZE(module_license_offenders); ++i) {
+		if (strcmp(mod->name, module_license_offenders[i]) == 0)
+			add_taint_module(mod, TAINT_PROPRIETARY_MODULE,
+					 LOCKDEP_NOW_UNRELIABLE);
+	}
 
 	if (!prev_taint && test_taint(TAINT_PROPRIETARY_MODULE))
 		pr_warn("%s: module license taints kernel.\n", mod->name);
-- 
2.45.2

