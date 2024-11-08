Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A112EBE7;
	Fri,  8 Nov 2024 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082348; cv=none; b=Nw76tXZ4mrcEVLcvveHuULmQv5SkjMDnYgOaxwZu2YStsOTTpFgSvzmezIqnqKG/jePj86nN9Kv0dYDCeuh77YxFmNwgaKVnZvp8yWypbzxcCd24afW5KAw7h2U5O8fjJI8b99gJDFMfkUGVpL/Xx7pGuibN7o9hlfTj4m5MOUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082348; c=relaxed/simple;
	bh=y7UEdgJZNHGbfohT5ewpxC1rRkwrbwYbdFePqHEeR/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=clbzGr8k0bFgjkLR/1Lu01Shsdn760I/8pDMZOFkJWNPsuKMW2KSeg8BRMvM/vnbgGwslreOpv8KunmreQmPzLk3YmKYIuZDfZLMD4Wng7yjTDD/svWpXTXeX68GmZYmUMg1nuFenofDofSqUCviWnwvt7V5IJfRySEShgBRBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uns91pKf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uns91pKf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F07ABC4CED3;
	Fri,  8 Nov 2024 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731082348;
	bh=y7UEdgJZNHGbfohT5ewpxC1rRkwrbwYbdFePqHEeR/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uns91pKfBAA+OWnZ0+lPlcekTLocGV4CQPqWE040euOvglKYClL/+5azIQ2l6IGnU
	 pFLB9E8wRoD02E5YsC/bPmgk6fAwzMyCvX18vY6tB1KfHp/nFqDRPWM4+RPiaXq4Kp
	 FFtvOAoTHWl6eCcP9rGuMQm7zfZd8JYnnTWEIT4wMxTusZmZ4NCcop6PWrkN79ylxn
	 MsIA+RN2oAU3iznLV8vf0D/AAYt9fRbYePlNqm+/eoIPzLbozqzI+k4TAK/+FCLw1X
	 nDiNFRFTAkaTIEdtyFnHDX/OwH8t8hHrrv/qMTMBsDIrq3M6/Ke+hWOQX3gBnAbPMU
	 RqH0s1HquHECQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64B6D5D69A;
	Fri,  8 Nov 2024 16:12:27 +0000 (UTC)
From: Daniel Gomez via B4 Relay <devnull+da.gomez.samsung.com@kernel.org>
Date: Fri, 08 Nov 2024 17:12:15 +0100
Subject: [PATCH RFC v3 3/4] module: update state and release reference
 under lock
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-modules-ro_after_init-v3-3-6dd041b588a5@samsung.com>
References: <20241108-modules-ro_after_init-v3-0-6dd041b588a5@samsung.com>
In-Reply-To: <20241108-modules-ro_after_init-v3-0-6dd041b588a5@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Thomas Gleixner <tglx@linutronix.de>, Jinjie Ruan <ruanjinjie@huawei.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: "Daniel Gomez (Samsung)" <d+samsung@kruces.com>, 
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731082346; l=927;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=oDK90qbYeBOZipkuaq567b8TktP7UW9UN57bt99vHXY=;
 b=66ib05tLV5YIvQdiwB6EdW2FQlciFDI8VnOCbvAoLDNo9f0q92j48REvKz2O62bMMp4KTZsDa
 u3HaxoUHdV5A2+WA8zNVf55mbFYUAnUdmd1IWvh5DsVP0LMV8/9bPiK
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
X-Endpoint-Received: by B4 Relay for da.gomez@samsung.com/20240621 with
 auth_id=175
X-Original-From: Daniel Gomez <da.gomez@samsung.com>
Reply-To: da.gomez@samsung.com

From: Daniel Gomez <da.gomez@samsung.com>

Ensure the module state change and reference drop operations are
performed within module_mutex to prevent potential race conditions in
the failure path.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 kernel/module/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 35a50ded64a6..2b45a6efa0a9 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2994,10 +2994,12 @@ static noinline int do_init_module(struct module *mod)
 fail_free_freeinit:
 	kfree(freeinit);
 fail:
+	mutex_lock(&module_mutex);
 	/* Try to protect us from buggy refcounters. */
 	mod->state = MODULE_STATE_GOING;
-	synchronize_rcu();
 	module_put(mod);
+	mutex_unlock(&module_mutex);
+	synchronize_rcu();
 	blocking_notifier_call_chain(&module_notify_list,
 				     MODULE_STATE_GOING, mod);
 	klp_module_going(mod);

-- 
2.39.2


