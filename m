Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF3514F124
	for <linux-modules@vger.kernel.org>; Fri, 12 Apr 2024 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712948032; cv=none; b=QzPv0vKbnut+xaHaqURcyM+4x1V1SvX8NpSDkWVvK85yJ48sBcGvnjGPTFhV9qhQWVMM9evXYKwyQrwZ51SCZx5rAyBlSNF2T2o9bxc/EkKFC7vY6RupayZwa3w+xO+4n4g9iwHhC5gnbcAQDUDwLg+JyZC7vsE4mp9Ra3ddZUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712948032; c=relaxed/simple;
	bh=FHYmDrKaqpfpTRuPXl2DoFH5LA+zgDT0YDVnlDewaH0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SyWzGblyhapzw03IkaftGlCeDBwPqB89h2+mcD9VsJfg71hCkgN6guJBt3hgHgJBQtrhJEMTKTTzgLPRDBS/VYu7tgWOYGDMxLPEgAyGPXnzRBXXn2jwOWpAI5Rh9rlWrwe1YpZZHtMhHSOvLjy0cRLd8Dc494Y3t8JeSafZ5jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cfD3ehD2; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cfD3ehD2"
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7d667dd202cso164061439f.1
        for <linux-modules@vger.kernel.org>; Fri, 12 Apr 2024 11:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712948029; x=1713552829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ku+cYfV3CL9NDsoRJLchzk83CxUteslcXBw1rBPpBQ4=;
        b=cfD3ehD2hT973F+ZCY6H8bzsssillE4z3k/ST3LiDA+KsZEC93DvdH2nHabn4lwbM/
         gzzWmQ0FelTAd12EfQ2Q89/OOFcmp/D47J4s9Yxnz/0PmprwCzX5mh6JlZjCwCwoZ67Z
         4+bcnIkQCrVWQ0HUHcTqnh3fRgEbwvzdu0dCI3dD8ulsOpl8ohi1Fsdy3KCfO/Vrt3JH
         SLd8t4AAH/v/I8LSXxT2gfLars1zKHxakXOV+ioxTk8z6BQQhMGVBHFb8BrFgc5+oIYB
         e/JV4dSz09Xh8l/K3yVtU03hjZlOvQEJkbBJUFphJfyfKZz0tgFt9kkvqjryRU1LYLJn
         mS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712948029; x=1713552829;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ku+cYfV3CL9NDsoRJLchzk83CxUteslcXBw1rBPpBQ4=;
        b=hX5lqMB2LXI7Jz7MTVEs1PlNF4Nz0UBITNQxRnlYzZ9wzx3a4QrqGwUKcf0zfeA6fg
         KoGFpqAc/KUcnAHpNtXOnOvx1a33e8nQYqhcKxCvsK7rUSEUtGCgVH+qyz6TuMI37Tpe
         uBOMf/c1cwIwKe+iljiTninwNVqYQACSS37Hejk8xBL0ZWa86+4ld+U5Kyr8y4allAOt
         TRWPq+2hhM0J4q5Hy81ZK9n/QSPAQ2Lf+ERTDFlpq3NtOYmFW9/a2xcXWcMNRBcaZonL
         k+HfWqrzqaWiZK4tWt4RriCjeD/G54gb+fI06DtoBTbg+IAU4PryVlpprXCtb0HjeZM4
         3LlA==
X-Gm-Message-State: AOJu0YzrwfOTkX9Z4Fdu5PnFqpCpDH5yP0Imv6fzWj0YC+I4RXKGmlHL
	zXO5VBGbC/XoTQaXsHg2KXsJqAQwUkIvKuAUg75icl6b723+FadzcC0RldEBPiPJW1LLKaY/AMb
	/FLexIAjSMQf0AYzV7fNvIA==
X-Google-Smtp-Source: AGHT+IFIgCcbrNG0WVTnmYkDHfTcUVCEG2xc3xCMlYSow98Vu7k7eQ29VCUlewX5/iqYIg8yJw0Aoj31HUwl+kTG/A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6638:2720:b0:482:dafb:95b7 with
 SMTP id m32-20020a056638272000b00482dafb95b7mr108126jav.2.1712948029249; Fri,
 12 Apr 2024 11:53:49 -0700 (PDT)
Date: Fri, 12 Apr 2024 18:53:47 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADqDGWYC/x3NQQ6CMBBG4auQWTsJVBrUqxgXWH50QilkRgmEc
 Hcbl9/mvZ0MKjC6FTspFjGZUkZ1Kii82/QCS5dNrnR1WVeO7aMpzBsP0ITI49R9I3hoY7RtNA5 88edr8GievW8oZ2ZFL+t/cX8cxw/Rj1rpcgAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712948028; l=1692;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=FHYmDrKaqpfpTRuPXl2DoFH5LA+zgDT0YDVnlDewaH0=; b=pWm/MHLjmrDU97kGz+go/s2QQbsbuuiO6zSazvNgFRTlpwEH0VSe83O/r1uhKZsmlXVlSBlD4
 r6ftS/8HNstBETceWQdRRLeikrnqi2Zc9U6HVKPIW0at/1YtRhfCNrR
X-Mailer: b4 0.12.3
Message-ID: <20240412-strncpy-kernel-module-kallsyms-c-v1-1-ba3f0fc16163@google.com>
Subject: [PATCH] kallsyms: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces. The goal is to remove its use completely [2].

namebuf is eventually cleaned of any trailing llvm suffixes using
strstr(). This hints that namebuf should be NUL-terminated.

static void cleanup_symbol_name(char *s)
{
	char *res;
	...
	res = strstr(s, ".llvm.");
	...
}

Due to this, use strscpy() over strncpy() as it guarantees
NUL-termination on the destination buffer. Drop the -1 from the length
calculation as it is no longer needed to ensure NUL-termination.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
Link: https://github.com/KSPP/linux/issues/90 [2]
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
---
 kernel/module/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index ef73ae7c8909..62fb57bb9f16 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -348,7 +348,7 @@ const char *module_address_lookup(unsigned long addr,
 	}
 	/* Make a copy in here where it's safe */
 	if (ret) {
-		strncpy(namebuf, ret, KSYM_NAME_LEN - 1);
+		strscpy(namebuf, ret, KSYM_NAME_LEN);
 		ret = namebuf;
 	}
 	preempt_enable();

---
base-commit: d7ad0581567927c433918bb5f06f3d29f89807d3
change-id: 20240412-strncpy-kernel-module-kallsyms-c-8539c5e7bf57

Best regards,
--
Justin Stitt <justinstitt@google.com>

