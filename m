Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CAC3C8737
	for <linux-modules@vger.kernel.org>; Tue,  2 Jun 2026 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440498; cv=none; b=Tq51Bs2yRsmx1mQlAgwEa6OogvzqNfOIphSkzdnkxdKDib5mJ767Haphb4gW1IXA7ZIl5MGqMvik8YEqU/Kb2lVEU/zHoxMvdqZ6aXwyRSD53LHs0WZdgvMeXT43Iu6MkWx2JCqu2FIOzo25/jpaVdyJwH787K81V4XFe5R+w5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440498; c=relaxed/simple;
	bh=/BEze5uZvE97vkdxdEKscGQmmLTlvHt75B8/b2suPbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MdAbNJJtJPiWHjJ9safbqupQcwGlWaDacxvfRoy+z3dACVWjFMca1JzlFnWV7595uWKI4jlSJEQP5DzIN8tVAARQ88HUM5BVVgW0/4Aa4oeg1M8bpgRLWZ3+UqrAkS+HA1s7Mz4XfaGgXnp2TuF5x1TeE3zYEfglKwX1tZtvPP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlEI31kN; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlEI31kN"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45eee266c6cso4406711f8f.1
        for <linux-modules@vger.kernel.org>; Tue, 02 Jun 2026 15:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440495; x=1781045295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwPLhLRZkxVDbJ+XZfxPTCPSMzzunTFiSNGj95FvoLA=;
        b=qlEI31kNxjbwB74F76h/iMA8Rt70PBfAVAwkfvOQ1OUWFaHg+UbcdRJZrCzi6K5HkO
         Hd8lnyadsYYTlSZz3jK1pWycosr71xS2M4gkHt5HIqBgWMW0INpWQbOTimKbIlKy2zso
         Oq1p7pXaJ8LAhZjSF1O2xlSlii4UyK5tnnIc3snbTN7GCBWwWva4f+qMsU2FmgeXgkrF
         OA/qHwFju4QSoJP6OgJ54C6ll2mhiQx4AGI3wHifogZfzGUa+spyNxhMVT1upnK12gfs
         Be/czoIFK+YVAZxE67rJbaOwKOKpqq++0nr59IloW0MBIUCheKY7/V+7LVsW3vAZepEJ
         Oz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440495; x=1781045295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CwPLhLRZkxVDbJ+XZfxPTCPSMzzunTFiSNGj95FvoLA=;
        b=Wmm3AnBI41Zg6y3RgLyKW1wB+j9ZbWcPsn7bavmPnos1QMOkRz3Rxo5oJ45+9kBwxd
         Q4S8ybSXF7HJQRlXgF8mw5ODBzNBW/DOYEMyFdhO71HXuGsMU3Wwf3IL4jsf1seAe3AB
         lTerkxxOcOTidgoe/0Sak7LnIodNh2d68weMAW3v19C8+I1YMZe+86/kKkPb2dMgfxcQ
         cLbFKVpqR709Bvh2CoHembIYZizS0oHMKLgVaksmSn6p2RcvTUukLkCWXH+HQM0HX92Z
         g708UwflUZwIVPu4OdGF4+9k9kTmU0ZmfVreY0bTa6xjrDr+j8m9RA/tW41/7a22/902
         FAJQ==
X-Forwarded-Encrypted: i=1; AFNElJ+z0vWfSqCNTHF248C17MTGG7Qzjh8AJh4Zeo0Uq0by4HDExIIQNoyX0BXdzZ0U/USObhkF4eWalLni0E/c@vger.kernel.org
X-Gm-Message-State: AOJu0YwWum7Z21iY2EJaUtfrW8IhdwwhmKIdpsqN0ivN9RDd0SKGDp6n
	c6yw4tfU8VN2iVpNymbwcHbf2H7NAZa1GREJn98pPpW54cZGSA1mBRo7
X-Gm-Gg: Acq92OFLWziYYWYacy7SF35tUBNo7umOPJonzaSYD6hd+r1e+vg68bJgSEry2ou8jFe
	UTpGuJ0+r1ijH84rzjFgUsnCm9LIFpovT9YpWvSbyhM0+MdMCsmqvq5y7BE5OE6jmbqGYHpF7MC
	7PTg+KfnirZLDrBWudieZOxtbfl8OP3yHq8bhOnAZEi1WCX1PAadcHdMVV/DQSN04Zg+P7GuZIb
	DyyprMp10RR8k1rr4KS1DQmf8hVRan/MFV6L5pxKAHUqygLwrkh+m0YivKyg9LsIk//egBLxPQx
	NyI9IJBQFxQ1g2UVV5Abr6oM6xF0RGOi3pNa1lVrA8N4dxiGz1AM0abfiuG3u30xAVbDtHT6PJU
	Mdk6zPIHian/lqypZZW78wd+CUmTgg+dJuEnqQpf8tzBJIYuv1B2aMbAk5mDbb+iftt7UWJODiT
	fv8ti3TCAYuBVUVkspamykHEryxrPgun8gO135Z0GCCA==
X-Received: by 2002:adf:e8ca:0:b0:45e:dabf:a00e with SMTP id ffacd0b85a97d-4602195abf8mr384315f8f.31.1780440494697;
        Tue, 02 Jun 2026 15:48:14 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:48:14 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:47:58 +0000
Subject: [PATCH v4 01/25] docs/dyndbg: update examples \012 to \n
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-1-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=2677;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=/BEze5uZvE97vkdxdEKscGQmmLTlvHt75B8/b2suPbI=;
 b=eGa6JOHZRbOrzq3N8stPRNIhRHhJDTd+EXMPhxsQVEHGQJoLEX5/8ExqTRqXIhbGFTDS7i/jW
 my6ir9qw9H/DG3fyTSa1Qx5Qli7GCViICT1Ms058vTbgPI0z3h/lvaZ
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

