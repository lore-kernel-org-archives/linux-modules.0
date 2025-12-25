Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236661DE8BE
	for <linux-modules@vger.kernel.org>; Thu, 25 Dec 2025 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766682577; cv=none; b=PXM7+/JW+xz+OV2y2qUbGl3BY+wlPih7oCdo22K3m5qUgSzWFb1o+F+Q8DndBl+6Xp5LwZxIJiYXgrA6TdNIr9d2rCgblBJ7U4XIPiSA7tutKXocYuSOYLCVlwiqiexsMiRB8NMTTGGRFjffF/RpM1vFyct0sV5KicW6qfSbULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766682577; c=relaxed/simple;
	bh=83f1PmfWzI1WjUX/Z+ePAovTV+WhzN6hT02XuFuHSRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jz5DLBpaI+H6nBams+beqW8TR21tFEiNEcEYv/IgXDt+9F6zB+vQHGU8x6Rnpr66E2z5tkHknUVYIZld528QiFVfYnqDo8ueYhABEWYDL7/WZcJ5rFuGZwweMpEZms7JHhflrZti+k9rZp9vtwIkdU9WLW7joF9U0wiuL25+BsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXMUnk+v; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXMUnk+v"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78f99901ed5so59511737b3.3
        for <linux-modules@vger.kernel.org>; Thu, 25 Dec 2025 09:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766682574; x=1767287374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJnvW0A6SgbXQs1NHQABSopMa/fuZliTPpr4o45JmhI=;
        b=fXMUnk+vblykz5k/Qjx0Cv+TicrsEuewTAzLDmrrg6csQdZJJ3NmfAl/8FmTGUV5PU
         vCoi6sG1vV5qpe+/k1d1Pk8EgPFR6tkjfYBJ8Yv7mTa1EIPJTI07wiezdbJdZtukpAiV
         +aijoPhiA8XscSUWZg84Du1LCPTxjAvh6gCIUYcryxSWyivItAafL6EIlA0Sl2e2OP8S
         tLu56J71c2s/b2TpxI5CzdChUwqKCpeEs+WAmeTocnyVmLmi32sLrDfllaOFKtfIlt13
         YtU2MFpUY8aDVB8tFX3Tu6aZf3G4ASOWDTlIUon7wdwqcbOxBmoY9bjsJdIrzJhtOe5w
         XRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766682574; x=1767287374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qJnvW0A6SgbXQs1NHQABSopMa/fuZliTPpr4o45JmhI=;
        b=CsyFNAHHbymHANWFY+tnOVNwsCrgHDFGVWgwnjTtn+JVcCf/3AMFlIJrybsS+X4OOA
         fNkiir4CD+8f46ZsfIRfWfoHfxzhvY8zpWQ6Mu2o6A8Q1BxJwWYpjzmT6CjXzXMcp1oV
         kBlxemnzhRw4mSn0nFbmxLbLD5HIjoak0A99YXIOWEJanxIIiCuS4X30FjL6UDVpiyTA
         9kMYHci6NZJcGGwbvbZYcrMwVjr6javOqjZc8MiSB/FuR5KYFgRKMCl+W1IfQCh+VOFB
         bhTomBi8enBHvHeVcam8gYgBkX4apQmJPncO6XrWNzkH7w9flHdCxB0c5GxSEhWc4AL7
         yjtA==
X-Forwarded-Encrypted: i=1; AJvYcCXD6SCXLNnw6vzS/XPfTOroCOPKV7skHNIagxwrkL3DVuQMI+2TFVZiKFnFQcKCm2vyi2DBvXzx8SPVxsI/@vger.kernel.org
X-Gm-Message-State: AOJu0YyM81XiwMPJYSXKZEFFm+k3bnTK4sqjrFI3Tg1x/lvJPpWGtUzJ
	aljihhiZ11/ymMBGUvbBtqxTZMLGyfflhvI50S/ZK31JnGe8suH4PTs7
X-Gm-Gg: AY/fxX5ulLuw01J5bXlNi69nVX9QvBnedxZL+JuDJVulkeRvyLX9cijIDm+S1ViiFny
	jQuZwak8v7tbJuXfJAmYEO0+vK08Xj1PSwlbzqSGXXM8kNiU2aKDALTw/qkEoaP7JMrUs0nybKN
	+HpYF68AaRFtPVCPo99ypERd/fdDhIp0I0Zqq/b9HlFTYzpYBJgAy5/ZnIF5zNMpbV8gcmN37oO
	zCqf6+BzazJj9d3BnsdIbQ4BDmgm8sITbTJOyixxa295EcStWI1eJQknOW98At+w14cM+/yx/rN
	MgrWukuItdchEkpPAZ9SbD0hDmh7AwYxyEofe3Ee53j3ldexgtXhN21yak2DOBOweIdObvUeGxe
	NNniGQ1cINJ+B+SC6sz0xysuAGifCGtJLA4TVWi89GkVCQUkKBnzyMCW1/FN7/A7A5hs9GqDrqQ
	OaH1driqY=
X-Google-Smtp-Source: AGHT+IEOI5N8F1QPJkwKkoNFoaHrbTb32hBNxWVW0/bhknzb+bHcnaSpekV7BEM78upWGjfs7XzINw==
X-Received: by 2002:a05:690c:670a:b0:78e:3dcf:7aaa with SMTP id 00721157ae682-78fb40294eemr168823547b3.39.1766682574047;
        Thu, 25 Dec 2025 09:09:34 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:5a70:118b:3656:4527])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb452c441sm76158037b3.46.2025.12.25.09.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 09:09:33 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v4 1/7] kernel.h: drop STACK_MAGIC macro
Date: Thu, 25 Dec 2025 12:09:23 -0500
Message-ID: <20251225170930.1151781-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251225170930.1151781-1-yury.norov@gmail.com>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The macro was introduced in 1994, v1.0.4, for stacks protection. Since
that, people found better ways to protect stacks, and now the macro is
only used by i915 selftests. Move it to a local header and drop from
the kernel.h.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/gpu/drm/i915/gt/selftest_ring_submission.c | 1 +
 drivers/gpu/drm/i915/i915_selftest.h               | 2 ++
 include/linux/kernel.h                             | 2 --
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_ring_submission.c b/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
index 87ceb0f374b6..600333ae6c8c 100644
--- a/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
+++ b/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
@@ -3,6 +3,7 @@
  * Copyright © 2020 Intel Corporation
  */
 
+#include "i915_selftest.h"
 #include "intel_engine_pm.h"
 #include "selftests/igt_flush_test.h"
 
diff --git a/drivers/gpu/drm/i915/i915_selftest.h b/drivers/gpu/drm/i915/i915_selftest.h
index bdf3e22c0a34..72922028f4ba 100644
--- a/drivers/gpu/drm/i915/i915_selftest.h
+++ b/drivers/gpu/drm/i915/i915_selftest.h
@@ -26,6 +26,8 @@
 
 #include <linux/types.h>
 
+#define STACK_MAGIC	0xdeadbeef
+
 struct pci_dev;
 struct drm_i915_private;
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5b46924fdff5..61d63c57bc2d 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -40,8 +40,6 @@
 
 #include <uapi/linux/kernel.h>
 
-#define STACK_MAGIC	0xdeadbeef
-
 struct completion;
 struct user;
 
-- 
2.43.0

