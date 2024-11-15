Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4380F1CF7A1;
	Fri, 15 Nov 2024 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731696783; cv=none; b=tKL2YxUCtbJy9GwRLtVodrZl2ljD9vLBc1V7tbLypEy4MmeVJyKatPCqnVciHiFfVIuMdl9Z2uVcMhVVFIlzlVpJnsBPIrLj34QkKskum8VHUGikqosjblwbo9k62U9QrglyH9yn2hb0WPC6Z8AtSekxzbN2lOACwR/JpRbZwD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731696783; c=relaxed/simple;
	bh=eXOwHe7QH5bnP9rQ+BlUjJBh59aUkCVWjIpLNs9EmMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BR7MdAD7TNKEebTROECj/esDXaZkVc9c9AxB0wzbj/uYpgSPsUguR6HtKUFS+8EJiwk9vBaIGalBI+QgbnuY5VW0uBnPtYXF+u5r+jOi5WzZCn8kT6RLu5TrfubuhYMU6jnZDm91uWIhV8FqYi+lQYUyGMHHjBLxD6+znieqDXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=XlMahzFa; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="XlMahzFa"
Received: from wse.fritz.box (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 304E02FC005B;
	Fri, 15 Nov 2024 19:52:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731696779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oB3wVTOYDjYG0EVP0UM+4AWHLyhp0NUtISXowyiALJg=;
	b=XlMahzFaRxnVAmwVcgFSyscBt1yDaLtdYIxQdKOB0E4H8z1lwmrCo5wRidiNdRmFLrNE+1
	3hQgPL7ur+7Avu09GkyBygFosNkOfD7dCyWQmxImCLEQYlfTXDW/Z36zOMZd++1U37u0Xx
	NMi6gfI7heHXF/MrQE/EpgM9zTAGTYo=
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
Subject: [PATCH v5 2/2] module: Block a module by TUXEDO from accessing GPL symbols
Date: Fri, 15 Nov 2024 19:50:31 +0100
Message-ID: <20241115185253.1299264-3-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115185253.1299264-1-wse@tuxedocomputers.com>
References: <20241115185253.1299264-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <ukleinek@kernel.org>

TUXEDO has not yet relicensed a module for GPLv2+ as a reply from former
contributers the committed code under GPLv3+ is awaited.

Teach the module loader that this module is not GPLv2 compatible despite
the declaration to be GPLv2 compatible until the relicensing is complete.

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
[Remove relicensed modules and accusatory language]
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 kernel/module/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 905d7b60dd709..df2549352ca8a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2029,6 +2029,14 @@ static const char *module_license_offenders[] = {
 
 	/* lve claims to be GPL but upstream won't provide source */
 	"lve",
+
+	/*
+	 * TUXEDO awaits 2 final answers to relicense the last module to GPLv2+
+	 * See https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/merge_requests/21 ,
+	 * https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/dd34594ab880ed477bb75725176c3fb9352a07eb ,
+	 * and https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/c8893684c2f869b2a6b13f1ef1ddeb4922f2ffe3
+	 */
+	"clevo_acpi",
 };
 
 /*
-- 
2.43.0

