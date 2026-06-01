Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6C83769EF
	for <linux-modules@vger.kernel.org>; Mon,  1 Jun 2026 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315504; cv=none; b=cxE8zHhJ90l4s2fnOXTgYX8DaJHENuJmBv7bTJZFy2PRd+oizQabbRMqonZvUhUJ4CoaN9cNfP6IM6ypeWtCHf+E8aFzZxyGl0ymea29YVoVxWCH4PXGf/YW8YR2s6uitIdyjb6S49obpEyiIVCqUQDwnrvd7LwzjmZgbka652s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315504; c=relaxed/simple;
	bh=/BEze5uZvE97vkdxdEKscGQmmLTlvHt75B8/b2suPbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3JIJmgRPDRE3zVLLO2Cc1NRn5MBuzSKMl+nQpFLWSb2TDgBifDMAl2TFZfssy+0ofEbiJF2X43E5uEnDy3fiZtS2/kSk2Ypl0wPo9JhdL8cHPfBRK7VxhWE6RTnQHNB53Xgv0Rg4YGLwPKS0dyaeQdhxAU/xHTFS/B0bsbN1I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8ZaUJTl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8ZaUJTl"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so112018245e9.3
        for <linux-modules@vger.kernel.org>; Mon, 01 Jun 2026 05:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780315501; x=1780920301; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwPLhLRZkxVDbJ+XZfxPTCPSMzzunTFiSNGj95FvoLA=;
        b=X8ZaUJTlJSmPN5Lp2+drVg+Y8VYUe7hHrC2s+iTm+6b4FkIO3e6P2MkXYFG1ec5KlY
         ax4/vFi6P0aGj3O8nnMSeex2hpAdOHlcrqHv3ZNuIoyK2/zhaeRHWAkasCfVhInfCFGJ
         Xj9BZ6YzVEawtEvRcUXbD9zF34F+Ck+RkNQRStqsHaVOCYdTjXS+6695GvJDdADA7YD/
         lDUVbLfNMcwbgBoLEw6LIXuqutA1Gjp5RmrMybocMbhC9NrhCNcNfvCjSEvykrrs7iAK
         WVSWuxl/WBD86kovAd6lMwp0DBI9Vc2itChVue2CNMo2htHRhaViBUSGYQdthbdgdCnm
         z2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780315501; x=1780920301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CwPLhLRZkxVDbJ+XZfxPTCPSMzzunTFiSNGj95FvoLA=;
        b=Feo0DrBz+hdRJeQNEt7JLtUD9Ry2M4glYFA6JMV4YL5UE9vQ+7B7wkw+zrz8NNqqoV
         XvyXaSZNzzJWT1Jbaoy0g6pDnVm8XOy22x9jyfNNJeD6+Hho3Uuiw1L4klRbsG+vvzmw
         w1pRy3vrAe0FaSpYpAFlmBq9ylpupnMWL/bWM2XLoVRRzKA5Mvj8vvG6Fnybf3WsC3X6
         xDmvjRcGovkdxYWKN2FkKWV8it8Hsgiw3BILJ4v5GinRcQnpBL7B7h/PKxqdo2F02BRW
         xPoopypTYKsOS/fUV0UrOV4A+AocMnfIO6KLdcJNnuFa0SGh2YBK2ZXG3gnbgBwfYBUw
         ttPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8DG9mng7NSpAGw8QK2TeOXxv/2GmgeYZKdfTCqG7nkk7eCXkx7K2/WqmFWslJc6ZqO+2Nbv/BqzgwCg81R@vger.kernel.org
X-Gm-Message-State: AOJu0YwWxNC+kUSGHMOUiZn5uWuKy0JMxpWRhiFG30D6nJGHePnVBik2
	ma9x9/ScIn3btsVLnKG1/nUrQdffNuQPcRAPvM786+KkBzxDgl2ynvJB
X-Gm-Gg: Acq92OH56rqgb/TIkUiMubDfS7vt89B/RtH9qLYBmqLm69tuBIVYgbBsz6udbRvh49H
	J6u+JrJqcYSoBC70mRjlcd0kpiYQuE5igpqWXNwgcKb53O4zvkuECa1Kifb7zhe2KCLlAXNC/PW
	0NjXegAk7l3MERSvBPqqwemtqUFWto2BAGEFgKSmZU18mDNS9NovcXqQF+OskndiRAM+4qxGus0
	X1qNMKeJh316MDsiW30kh+Zm2NuglzroxgGgTU+XeyOC/Q88Wn9kyPotQ/9xu8RSkZT/+06q5tC
	enKs2KyL0HRbU0kaSFBi1kpl4qsoo9miEQtaNS4vzetGuDl+pPpsM5pP1CwyLwu3xRTzNg95RyP
	W/YAq3QYW67WzwgkHVpXNjda2a7BOPbc90iPCgDWRfhilRh439GkZ4vnfYKXyR+qiXzT03JMQRw
	AShorQSCd7eWtnIYWppKi7UbsMW0jqe0YaSxkzFbfOwg==
X-Received: by 2002:a05:600c:4715:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-490a2932381mr196252395e9.11.1780315501072;
        Mon, 01 Jun 2026 05:05:01 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:05:00 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:04:47 +0000
Subject: [PATCH v3 01/24] docs/dyndbg: update examples \012 to \n
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-1-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
In-Reply-To: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=2677;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=/BEze5uZvE97vkdxdEKscGQmmLTlvHt75B8/b2suPbI=;
 b=c8S96t+ZCXu5kmm15ytCexf2F+SACA7KqyLI8HX9Eb3WTFBQJJe/DEwNE9wWzQI9kMMtWSMe2
 BCeYdCPPvMcCqA4vhxh710sNmgly3GwhDZJllsv9yBgjcughOSsHbPp
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

commit 47ea6f99d06e ("dyndbg: use ESCAPE_SPACE for cat control")
changed the control-file to display format strings with "\n" rather
than "\012".  Update the docs to match the new reality.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Tested-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 095a63892257..4b14d9fd0300 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -38,12 +38,12 @@ You can view the currently configured behaviour in the *prdbg* catalog::
 
   :#> head -n7 /proc/dynamic_debug/control
   # filename:lineno [module]function flags format
-  init/main.c:1179 [main]initcall_blacklist =_ "blacklisting initcall %s\012
-  init/main.c:1218 [main]initcall_blacklisted =_ "initcall %s blacklisted\012"
-  init/main.c:1424 [main]run_init_process =_ "  with arguments:\012"
-  init/main.c:1426 [main]run_init_process =_ "    %s\012"
-  init/main.c:1427 [main]run_init_process =_ "  with environment:\012"
-  init/main.c:1429 [main]run_init_process =_ "    %s\012"
+  init/main.c:1179 [main]initcall_blacklist =_ "blacklisting initcall %s\n"
+  init/main.c:1218 [main]initcall_blacklisted =_ "initcall %s blacklisted\n"
+  init/main.c:1424 [main]run_init_process =_ "  with arguments:\n"
+  init/main.c:1426 [main]run_init_process =_ "    %s\n"
+  init/main.c:1427 [main]run_init_process =_ "  with environment:\n"
+  init/main.c:1429 [main]run_init_process =_ "    %s\n"
 
 The 3rd space-delimited column shows the current flags, preceded by
 a ``=`` for easy use with grep/cut. ``=p`` shows enabled callsites.
@@ -59,10 +59,10 @@ query/commands to the control file.  Example::
 
   :#> ddcmd '-p; module main func run* +p'
   :#> grep =p /proc/dynamic_debug/control
-  init/main.c:1424 [main]run_init_process =p "  with arguments:\012"
-  init/main.c:1426 [main]run_init_process =p "    %s\012"
-  init/main.c:1427 [main]run_init_process =p "  with environment:\012"
-  init/main.c:1429 [main]run_init_process =p "    %s\012"
+  init/main.c:1424 [main]run_init_process =p "  with arguments:\n"
+  init/main.c:1426 [main]run_init_process =p "    %s\n"
+  init/main.c:1427 [main]run_init_process =p "  with environment:\n"
+  init/main.c:1429 [main]run_init_process =p "    %s\n"
 
 Error messages go to console/syslog::
 

-- 
2.54.0

