Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ABD384245;
	Sat,  6 Jun 2026 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780770293; cv=none; b=BxyPM43B2RmA7Kl4L7lM/64N+OqN+QzmRnV7KMVFN/QfcSdMoa36w1fRIuZmlmRo41BjsZ/2fXdueJ48p0dfQtgHEeXd1miGbV4+IL6RYk4LOW3pyyFp5hqFqzMEa5kzZDI7+Rgg9M4VKzqkHE5ipqVNPM0nXZ5YWOgqRlqrjc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780770293; c=relaxed/simple;
	bh=3T458tR0aVleBKNVEq1AycLXElKaBiKNy8awCUsVAEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VkwYuZwSeWkG6JPIwGhEk2GqxXAO0FamDRJdPPcp9asW3sJiIEmw2flaHEu9VmQik4g48BXdCyczkLN7TEbza+l1sqEKJW+nxvmspqKisWVpWVFrGhCrPHIQYGJ/b2QNFAhIJNfmVLZSds21dSz6aVpeqlv215r/W7D3teAMCbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jil2dERN; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wwVbQNR5; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jil2dERN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wwVbQNR5"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gXmtN2rNvz9spj;
	Sat,  6 Jun 2026 20:24:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780770284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iGIHdO1aE4dkpQKizg9zHuUHbzM6bAkYdqsgWGarRr0=;
	b=jil2dERNXMUGAxFhBnhTvoG+O96Rw70uF+a0scFpIXax71yQYBLP2y9YdLg6JHoli+kVUt
	Cqy3Ic656VTgm8xZcLR65MrpAEmyRgK+iaFMC2vIbvMRowoCRg4UKsx5b25pk3M+UKdjdm
	e99AoW8B5lDmxWZ8kGfIBfWAkBU0Vh/LcXWNY2jrgckZ2hEPH5zg1M4aFlhI2E9tdlwow8
	OhC3kRMQHHleozT6YB9/fSQY807G+3j1s14DFI+g8s67uvF3wF7d5CntUiHM5MtSuPpKL8
	/PKB24PjnS0BQ3ZDHHkW++KFUJV2yuT6KLaef7qW5yusbmq2CTvLGBOkdUomxw==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780770282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iGIHdO1aE4dkpQKizg9zHuUHbzM6bAkYdqsgWGarRr0=;
	b=wwVbQNR5OnV3P8JtzSyi58rNLqSk5gxmzQHHNFETDqgzljRD6aXhIcNGLIFASkD++HlF77
	x2C46mVfCkpVNrNiTnuULEiPXon26SyYjujh0m/gUkiQxiltDwP2uTHqhy+iYuID9AjDhs
	BsP9PA/AoT9CZOleiwyyTSjjnq30PQpzfvn3Zbx423nArs28g9W4TeqaZj/hGg5qPSrKU0
	acs6vu5GlobFdOXAYwPB7UvE6UTySoF8YUXzvO5yIX0GirJOPLPHiZ3TZGpic7qNz4q3YJ
	yBJWFFTKEmYX/NgTLcto6+l1UeaTgj3fC4QX851Kc1nA8T0JW+Nzn3db14TIWA==
Date: Sat, 06 Jun 2026 20:24:26 +0200
Subject: [PATCH] rust: module_param: use pr_warn_once! for null pointer
 warning
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-module-param-pr-warn-once-v1-1-96d9a93e8a1b@mailbox.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MwQqDMBAFf0X27IIGbcVfKR4W87QLNQkbagviv
 xtkTnOYOSjDFJnG6iDDrlljKNLWFc1vCStYfXFyjXs0Bd6i/37ASUw2TsY/scAxzGB4t/TdAHl
 2LZU+GRb93+/XdJ4XyPEU6GsAAAA=
X-Change-ID: 20260606-module-param-pr-warn-once-ed2f548ea741
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780770273; l=1049;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=3T458tR0aVleBKNVEq1AycLXElKaBiKNy8awCUsVAEg=;
 b=QiNKS/vQPX3lusqKfFgFPjKgyjKUuWKCF8fQp4YYH/s5FQtGgsm3v/iC4PFylDt8snkGBB5Bd
 NCtA2KVN3ijChl3y5E7XNVmshbvuZsw32Vz4/2h743RJkgj0+zvltEn
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-ID: 28fd9766d3a141c4797
X-MBO-RS-META: jarti9tfh7m49wtibifbcobnm4djt51h

This resolves the existing TODO that asked for pr_warn_once! once
it became available.

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 rust/kernel/module_param.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
index 6a8a7a875643..dd6d663a0a3c 100644
--- a/rust/kernel/module_param.rs
+++ b/rust/kernel/module_param.rs
@@ -62,8 +62,7 @@ pub trait ModuleParam: Sized + Copy {
     // NOTE: If we start supporting arguments without values, val _is_ allowed
     // to be null here.
     if val.is_null() {
-        // TODO: Use pr_warn_once available.
-        crate::pr_warn!("Null pointer passed to `module_param::set_param`");
+        crate::pr_warn_once!("Null pointer passed to `module_param::set_param`");
         return EINVAL.to_errno();
     }
 

---
base-commit: 838a0871cb3cf5988560d17afaaf57592bdb486b
change-id: 20260606-module-param-pr-warn-once-ed2f548ea741

Best regards,
-- 
Maurice Hieronymus <mhi@mailbox.org>

