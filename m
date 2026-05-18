Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41873481FA2
	for <linux-modules@vger.kernel.org>; Mon, 18 May 2026 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111666; cv=none; b=ozTow4HWRtYjI6fWgkXPHCYNStVj1hOMaambp8ucIq5VMLQCFnQ3YnpShSZORwSJmNJhDZ9TFpBEDyNrTg0ENMJmSYk9wbMfIhxeo+roMd3r+832GHfce+kt0vZD7FWqcPqHsrfDQy9pu17qHfxNkhWa46PTLiA+cFvo+n2+T/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111666; c=relaxed/simple;
	bh=0GMy557X2yIPxBvMxVdGjzD8em/l/TBASpj6hxhrv8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVGmUfs1wJe6ltZrgI4fBESOFS/ChxhvJYnX6s/hvrEurjlgoKlDcO4cI9EnXphPGqXfC0tm5j6sMXShL7pBpLdpe86vaORiVo0+czZOmKqmy0ybrTOOU9m3zFfX7Z1NaeoB9U+qyHwXhWBmQxRv+lexSuHqhFsOalmR8PVXQ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Huw7mbZ/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Huw7mbZ/"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba17c8cfacso22718385ad.2
        for <linux-modules@vger.kernel.org>; Mon, 18 May 2026 06:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779111665; x=1779716465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ1AlD1AM21fm4X96F6F2/fw1jm8rVL0VNrv0bCYenQ=;
        b=Huw7mbZ/5fKzJKKAH/8JY0q0tGNw7zo5vqe/Mr84yo5S0jljTHI1h+crJU6REFAGou
         Z8RU3P7A1e0OjnKFosQg5HhPV2rzgJCTJeYp9AdKpdhQrGOoalCosI6vQ3/8Lr5bwF9Y
         Bme2057FtCi6/LP38myo902Zx/6975WbHW3eudt3z9gYSR79iW1NpeHVOikQAu8AsCEm
         JKRCblF8kQ9omVFXFQWM2Q3ARbbMAae6xEWlsUAHNJT+YSxgOwPCvC+nyqpbTnxCPllP
         zsVPVXa9neKyyQziKmCU1tqCjTq/wOb7jXBqgUDUBysiFX9t+R0xocxBZN3JufjuwvLD
         Lndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111665; x=1779716465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ1AlD1AM21fm4X96F6F2/fw1jm8rVL0VNrv0bCYenQ=;
        b=ELNNOtCO+0fOd8KAOaBLQKPr1CAwrfXFwREiXrGLkgyQ8+IvPlT5VQjHtaOwtH+4gg
         f+FHm27lZXOmZkaVxKvxI0nfO3827+d5Fx8iHiz36oBBQiGbXrfjFon6efUN5y9/3ZlD
         qJJHY7jrjFLGUULMC3qaSo5nBVd/xL9NzGiGRlpWw8Kt+2DLtRIBmILIRrn1pmiTgGpG
         h7hz2W7XbCksuQ5fHXXkxfJQtrmE2xduuvJ0Yb89a1s3++Ipn8M6YduPAO6T6hIMfzbI
         buvQJsjfeVI+VL1RSEERQr+7tYLTlItdSlA7w0SY48oZcJaaHtDVpG5GS5uV8/7fEIR7
         of3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/9U9dpKXgteBMrvmEr6rKABWz//IswewjAguyKtxKv6kCI7K/6uxcdfhFHMsu9eQb/hdv0lG0ch/yZ+CUg@vger.kernel.org
X-Gm-Message-State: AOJu0YwkIOo8l+RJEPgk3m6EBzbpUQkJBkmMC0Ec+mmDNuy+PAWzXtox
	vGvYZhiANjbhPsRVhiNzNLtWoJUeTHARjCcA4AOdygI/cLA6aYAYtMpc
X-Gm-Gg: Acq92OG5BPG8BlsczLQMrN7XJ6VSto1bnFqwr0npzMzQtdU8R3BjbqnabXhhP1zooqJ
	+pXiFjtIxaKkUgsPXXyAWOjyL0ldxN8Lce9P6hMaUQt9e1QaL00IrFwwzHW+CYScq/D0mbSyClZ
	Mqa+l1dotWmFQD6LprPAyWYR89BrDo/RvyRZK1NtzyYbg267Qy+p8/2IYDPouCANUawaSibR8+S
	j2FN/zoI0hT0d4M4Y6pbEReEMcwNERuqQbzVK5sPxSgWdUnmNBFKBu68qBBDcRvFzb/jHoErVrv
	FaBQRUu3vxQMv12S+cuPmUdPyJwE3rTlH/+HPEyWkaJaneFTeN6QuKXwBkleFY9JfQd/6xxIXNp
	C7qUN1Y71Hiawx48oNuetzdrMaWqjjFnyzUGEAlHrbp5mgvMi0Vl0p8d3qQ8ZYMisR4OEdzA1+d
	7w/IylMuYRxvBZAO9Ie8iMfiWw+WAIQuRyXyvfFksg9YFEcrIe/s80xt4I3LNguTygKq2VdI7IO
	WGf0/XxOdzaQVYSyKBEeuKn5gBrF06681XWBpMCKtoM8872eQ==
X-Received: by 2002:a17:902:c948:b0:2b2:4f43:b48c with SMTP id d9443c01a7336-2bd7e8423a7mr173026705ad.14.1779111664551;
        Mon, 18 May 2026 06:41:04 -0700 (PDT)
Received: from localhost.localdomain (ec2-54-199-123-161.ap-northeast-1.compute.amazonaws.com. [54.199.123.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fb17sm148500135ad.1.2026.05.18.06.40.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 May 2026 06:41:03 -0700 (PDT)
From: Xiaobo Liu <cppcoffee@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	atomlin@atomlin.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	Xiaobo Liu <cppcoffee@gmail.com>
Subject: [PATCH] rust: kernel: module_param: replace pr_warn with pr_warn_once
Date: Mon, 18 May 2026 21:40:53 +0800
Message-ID: <20260518134053.4078-1-cppcoffee@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace pr_warn!() with pr_warn_once!() in module_param::set_param() to
avoid flooding the kernel log when a null pointer is repeatedly passed.

The original code had a TODO comment noting that pr_warn_once should be
used once available. Since pr_warn_once!() is now available, switch to it
and update the comment accordingly.

Signed-off-by: Xiaobo Liu <cppcoffee@gmail.com>
---
 rust/kernel/module_param.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
index 6a8a7a875..fedb709fa 100644
--- a/rust/kernel/module_param.rs
+++ b/rust/kernel/module_param.rs
@@ -62,8 +62,8 @@ pub trait ModuleParam: Sized + Copy {
     // NOTE: If we start supporting arguments without values, val _is_ allowed
     // to be null here.
     if val.is_null() {
-        // TODO: Use pr_warn_once available.
-        crate::pr_warn!("Null pointer passed to `module_param::set_param`");
+        // `pr_warn_once` is already available, use it.
+        crate::pr_warn_once!("Null pointer passed to `module_param::set_param`");
         return EINVAL.to_errno();
     }
 
-- 
2.34.1

