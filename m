Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4904372B27
	for <linux-modules@vger.kernel.org>; Thu, 21 May 2026 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380062; cv=none; b=jNh2Iv2Ct65c4OLzNeZSAuBaFI4ir8B5Nxb8GNkwqPJvYsncWDZxTwQ72l5VNrO1qlEwaW1yJ0LaIe2F918+Dl8aAX9az5JJ+tlHop+DXZH8/BbY59rB62irFIFCeb33vHVnvlD4kUSyrw1DddSLHCD41PaSzDtNuIr2v44zLPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380062; c=relaxed/simple;
	bh=EvaOvJK7gUYlg9eSrzLdiPePr+0IURW/C6idzGNV3Is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z2KvdaGVC16zN3cajo6xC6o4cSp/paAV0Z6VkEG15AyZ3o/7lakR5CsbxA82z5VHzKAFMtMBrqQAvAhgbARKcS0ARU0t/UC3wgWOHclfz3gefj5yzlVwR/edvJNSOzqwI7VrrpoNrCVFbq2D28cj0ct/w/NRStRFOjRbNKS0XzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oL6IFDmN; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oL6IFDmN"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65c3ea2ebf7so7340936d50.0
        for <linux-modules@vger.kernel.org>; Thu, 21 May 2026 09:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779380060; x=1779984860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0dyt1TzRyN36X5hR8tAOgPi+dzA4gZF2bfoIRk7jjmc=;
        b=oL6IFDmNEDFbOLkKiBJk7piHl+DHZZdJi0RuoFGC9uplQs8lJ7ebjRG49Xf43M3UUo
         goj1bb7WBsVgPzDnWBFAesQjYroqEpr8wIvh60/C2O12p+lFpGX+I9+vGnEo7XEF7ikc
         WyhIAGjpwmqfNX3uvINJQzsgCjiGxfzsuHnfeSfJxBh9NxIUWm+HRBJvKhiay+4hLwxA
         wRa/4zybsbzLPFuGhDHTkOES6vCgDZ3kVgSoGeUQ629MMLuxHLaAGBGIxpmb8NCe2VaN
         W/ibIZWLFgkg9WVW54rGTJE6jCh+R6tewqgOXXixRH0qycvyqq4m/6pqL5gSgg7a4Bxq
         NEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779380060; x=1779984860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dyt1TzRyN36X5hR8tAOgPi+dzA4gZF2bfoIRk7jjmc=;
        b=s6tiRDxlvL1WKWsqsQlTYo2idajG994VpUd6GXX/wbRwcxzFhu7nRmVd2W91lFqJhz
         EDMhaVjQVt7xb2mM3UZ5rTL/+9srFOCjK3qccyoAsBlm0+09kWCcEDntHmURjnWkOvVV
         HTiQcPpBdrHXL1mAXt6gQ2YlUedxhaG5PaD/lym4IkUd+ZIoY0rGTxUZC3c2acrcJ3Y2
         MtYFy+5BqhQUOPy7g2S6U056hDjpnkV+NvUWucl3ueUYuYjiibnyjebWc2/0qBqoF77o
         tUqH6ZNpKn3QMeZtOFBkP+XKHvY6WBdFEDMWU2NBMLbbv53YU0N0hjcCLtyx3WxOV55X
         R2Bg==
X-Gm-Message-State: AOJu0Yw8DDQAYg4c/zP5K/Xd/V/eCbCUmwxCRST/BlZCmutzLOq/kCu9
	+uHHnPuG6SKhWPD8kdlBcx4pYva7J1k35Pkl0TjIFbAmrA1ZZ03Yp1Nn
X-Gm-Gg: Acq92OES1YkglTEtAHVUO0h2GMPPiAVQ61Ps+er7X8o3Yd0j1o5W1+zX/zKpjwrgVcI
	YNqw0BkG3KSn3o+vg0QOpnYQSlhf6CcYPmRH9rdRe/nS1c9jQgZbEnX1UIef16ZVSqajnxaSBnp
	wmxOJ+Wh8tGU6c8LwHgmvvzh08v7rViIrTUd3a2d2pCiP3xlqSi0I3kRZQ03tqW1HoaRW40URlY
	r6B+B+zuAquweNZPrC7x+n3D78KHczG8Y2vGqf62XD/u/LLnvmUC75BdlqjPIP6mMq2eWMpRPBx
	wjhz8N1+ny/buNHOwivi4W6ASd/1c+oj0tkIeIXxVAUvESwd7/CT9Xh+Kpx5Jgiu7dc5ASYKTX9
	oN6JUq+wa9LIM6+YhULoDbgEb8hMhkdUdgE2mA75S06MDAn2dZyTwR5vfKozqvqgxtLechVd9zi
	PSRsq7aQLYaqxlxuR2+YDu2fpzjRuUa8ApItavbHK8D1yp1pw=
X-Received: by 2002:a05:690c:9693:b0:7bb:712:a74f with SMTP id 00721157ae682-7d20b08586emr40415707b3.17.1779380059799;
        Thu, 21 May 2026 09:14:19 -0700 (PDT)
Received: from CachyOS.lan ([2600:6c63:417e:cfdc:e26c:e9d6:8bd3:e3fd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d2ca76a8cbsm4621827b3.32.2026.05.21.09.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:14:19 -0700 (PDT)
From: Kenny Glowner <sisyphuscode0311@gmail.com>
X-Google-Original-From: Kenny Glowner <SisyphusCode0311@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kenny Glowner <SisyphusCode0311@gmail.com>
Subject: [PATCH] rust: module_param: add missing newline to pr_warn
Date: Thu, 21 May 2026 11:14:05 -0500
Message-ID: <20260521161405.64042-1-SisyphusCode0311@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a trailing newline ('\n') to the pr_warn! call in set_param to
ensure the kernel ring buffer flushes the message correctly and
prevents log line smearing.

Link: https://github.com/Rust-for-Linux/linux/issues/1139

Signed-off-by: Kenny Glowner <SisyphusCode0311@gmail.com>
---
 rust/kernel/module_param.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
index 6a8a7a875643..fa26089be2e0 100644
--- a/rust/kernel/module_param.rs
+++ b/rust/kernel/module_param.rs
@@ -63,7 +63,7 @@ pub trait ModuleParam: Sized + Copy {
     // to be null here.
     if val.is_null() {
         // TODO: Use pr_warn_once available.
-        crate::pr_warn!("Null pointer passed to `module_param::set_param`");
+        crate::pr_warn!("Null pointer passed to `module_param::set_param`\n");
         return EINVAL.to_errno();
     }
 
-- 
2.54.0

